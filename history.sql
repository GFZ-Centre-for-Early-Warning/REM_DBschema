--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: history; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA history;


ALTER SCHEMA history OWNER TO postgres;

SET search_path = history, pg_catalog;

--
-- Name: history_table(regclass); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION history_table(target_table regclass) RETURNS void
    LANGUAGE sql
    AS $_$
SELECT history.history_table($1, BOOLEAN 'f', BOOLEAN 't');
$_$;


ALTER FUNCTION history.history_table(target_table regclass) OWNER TO postgres;

--
-- Name: FUNCTION history_table(target_table regclass); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION history_table(target_table regclass) IS '
ADD auditing support TO the given TABLE. Row-level changes will be logged WITH FULL query text. No cols are ignored.
';


--
-- Name: history_table(regclass, boolean, boolean); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION history_table(target_table regclass, history_view boolean, history_query_text boolean) RETURNS void
    LANGUAGE sql
    AS $_$
SELECT history.history_table($1, $2, $3, ARRAY[]::text[]);
$_$;


ALTER FUNCTION history.history_table(target_table regclass, history_view boolean, history_query_text boolean) OWNER TO postgres;

--
-- Name: history_table(regclass, boolean, boolean, text[]); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION history_table(target_table regclass, history_view boolean, history_query_text boolean, ignored_cols text[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  _q_txt text;
  _ignored_cols_snip text = '';
BEGIN
    IF history_view THEN
	    --create trigger on view (use instead of trigger) - note: in case of multiple triggers on the same table/view the execution order is alphabetical
	    IF array_length(ignored_cols,1) > 0 THEN
		_ignored_cols_snip = ', ' || quote_literal(ignored_cols);
	    END IF;
	    
	    EXECUTE 'DROP TRIGGER IF EXISTS zhistory_trigger_row ON ' || target_table::text;
	    _q_txt = 'CREATE TRIGGER zhistory_trigger_row INSTEAD OF INSERT OR UPDATE ON ' ||
		     target_table::text ||
		     ' FOR EACH ROW EXECUTE PROCEDURE history.if_modified(' || 
			quote_literal(history_query_text) || _ignored_cols_snip || ');';
	    RAISE NOTICE '%',_q_txt;
	    EXECUTE _q_txt;
	    --workaround to update all columns after insert on view (instead of trigger on view does not capture all inserts like gid)
	    EXECUTE 'DROP TRIGGER IF EXISTS zhistory_trigger_row_modified ON history.logged_actions';
	    _q_txt = 'CREATE TRIGGER zhistory_trigger_row_modified AFTER INSERT ON history.logged_actions 
			FOR EACH ROW EXECUTE PROCEDURE history.if_modified_view();';
	    RAISE NOTICE '%',_q_txt;
	    EXECUTE _q_txt;
    ELSE
	    --create trigger on table (use after trigger)
	    IF array_length(ignored_cols,1) > 0 THEN
		_ignored_cols_snip = ', ' || quote_literal(ignored_cols);
	    END IF;

	    EXECUTE 'DROP TRIGGER IF EXISTS history_trigger_row ON ' || target_table::text;
            _q_txt = 'CREATE TRIGGER history_trigger_row AFTER INSERT OR UPDATE OR DELETE ON ' || 
                     target_table::text || 
                     ' FOR EACH ROW EXECUTE PROCEDURE history.if_modified(' ||
                     quote_literal(history_query_text) || _ignored_cols_snip || ');';
            RAISE NOTICE '%',_q_txt;
            EXECUTE _q_txt;
    END IF;
END;
$$;


ALTER FUNCTION history.history_table(target_table regclass, history_view boolean, history_query_text boolean, ignored_cols text[]) OWNER TO postgres;

--
-- Name: FUNCTION history_table(target_table regclass, history_view boolean, history_query_text boolean, ignored_cols text[]); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION history_table(target_table regclass, history_view boolean, history_query_text boolean, ignored_cols text[]) IS '
ADD transaction logging support TO a TABLE.

Arguments:
   target_table:       TABLE name, schema qualified IF NOT ON search_path
   history_view:       Activate trigger for view (true) or for table (false)
   history_query_text: Record the text of the client query that triggered the history event?
   ignored_cols:       COLUMNS TO exclude FROM UPDATE diffs, IGNORE updates that CHANGE only ignored cols.
';


--
-- Name: if_modified(); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION if_modified() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO pg_catalog, public
    AS $$
DECLARE
    history_row history.logged_actions;
    include_values BOOLEAN;
    log_diffs BOOLEAN;
    h_old hstore;
    h_new hstore;
    excluded_cols text[] = ARRAY[]::text[];
BEGIN
    history_row = ROW(
        NEXTVAL('history.logged_actions_gid_seq'),    -- gid
        TG_TABLE_SCHEMA::text,                        -- schema_name
        TG_TABLE_NAME::text,                          -- table_name
        TG_RELID,                                     -- relation OID for much quicker searches
        txid_current(),                               -- transaction_id
        session_user::text,                           -- transaction_user
        current_timestamp,                            -- transaction_time
        current_query(),                              -- top-level query or queries (if multistatement) from client
        substring(TG_OP,1,1),                         -- transaction_type
        NULL, NULL, NULL                             -- old_record, new_record, changed_fields
        );
 
    IF NOT TG_ARGV[0]::BOOLEAN IS DISTINCT FROM 'f'::BOOLEAN THEN
        history_row.transaction_query = NULL;
    END IF;
 
    IF TG_ARGV[1] IS NOT NULL THEN
        excluded_cols = TG_ARGV[1]::text[];
    END IF;
 
    IF (TG_OP = 'UPDATE' AND TG_LEVEL = 'ROW') THEN
	history_row.old_record = hstore(OLD.*);
        history_row.new_record = hstore(NEW.*);
        history_row.changed_fields = (hstore(NEW.*) - history_row.old_record) - excluded_cols;
        IF history_row.changed_fields = hstore('') THEN
        -- All changed fields are ignored. Skip this update.
            RETURN NULL;
        END IF;
    ELSIF (TG_OP = 'DELETE' AND TG_LEVEL = 'ROW') THEN
	history_row.old_record = hstore(OLD.*);
    ELSIF (TG_OP = 'INSERT' AND TG_LEVEL = 'ROW') THEN
	history_row.new_record = hstore(NEW.*);
    ELSE
        RAISE EXCEPTION '[history.if_modified_func] - Trigger func added as trigger for unhandled case: %, %',TG_OP, TG_LEVEL;
        RETURN NULL;
    END IF;
    INSERT INTO history.logged_actions VALUES (history_row.*);
    RETURN NULL;
END;
$$;


ALTER FUNCTION history.if_modified() OWNER TO postgres;

--
-- Name: FUNCTION if_modified(); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION if_modified() IS '
Track changes TO a TABLE or a VIEW at the row level.
Optional parameters TO TRIGGER IN CREATE TRIGGER call:
param 0: BOOLEAN, whether TO log the query text. DEFAULT ''t''.
param 1: text[], COLUMNS TO IGNORE IN updates. DEFAULT [].

         Note: Updates TO ignored cols are included in new_record.
         Updates WITH only ignored cols changed are NOT inserted
         INTO the history log.
         There IS no parameter TO disable logging of VALUES. ADD this TRIGGER AS
         a ''FOR EACH STATEMENT'' rather than ''FOR EACH ROW'' TRIGGER IF you do NOT
         want TO log row VALUES.
';


--
-- Name: if_modified_view(); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION if_modified_view() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    tbl regclass;
BEGIN
    IF NEW.transaction_type = 'I' THEN
	FOR tbl IN
	    --get table name
	    SELECT schema_name::text || '.' || table_name::text FROM history.logged_actions WHERE gid=(SELECT max(gid) FROM history.logged_actions)
	LOOP
	    EXECUTE '
	    UPDATE history.logged_actions SET 
		new_record = (SELECT hstore('|| tbl ||'.*) FROM '|| tbl ||' WHERE gid=(SELECT max(gid) FROM '|| tbl ||' ))
		WHERE gid=(SELECT max(gid) FROM history.logged_actions);
	    ';
	END LOOP;
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION history.if_modified_view() OWNER TO postgres;

--
-- Name: FUNCTION if_modified_view(); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION if_modified_view() IS '
This function updates the gid of a view in the logged actions table for the INSERT statement.
';


--
-- Name: ttime_gethistory(character varying); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION ttime_gethistory(tbl character varying) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE '
	--query1: query new_record column to get the UPDATE and INSERT records
	(SELECT (populate_record(null::' ||tbl|| ', b.new_record)).*, b.transaction_time, b.transaction_type FROM history.logged_actions AS b 
		WHERE b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND b.transaction_type=''U''
		OR b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND b.transaction_type=''I''
	ORDER BY b.transaction_time DESC)	

	UNION ALL

	--query2: query old_record column to get the DELETE records
	(SELECT (populate_record(null::' ||tbl|| ', b.old_record)).*, b.transaction_time, b.transaction_type FROM history.logged_actions AS b 
		WHERE b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND b.transaction_type=''D''
	ORDER BY b.transaction_time DESC);
	';
END;
$$;


ALTER FUNCTION history.ttime_gethistory(tbl character varying) OWNER TO postgres;

--
-- Name: FUNCTION ttime_gethistory(tbl character varying); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION ttime_gethistory(tbl character varying) IS '
This function searches history.logged_actions to get all transactions of object primitives. Results table structure needs to be defined manually. Returns set of records.
Arguments:
   tbl:		schema.table character varying
';


--
-- Name: ttime_gethistory(character varying, character varying); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION ttime_gethistory(tbl_in character varying, tbl_out character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
  tbl_struct text;
BEGIN
tbl_struct := string_agg(column_name || ' ' || udt_name, ',') FROM information_schema.columns WHERE table_name = split_part(tbl_in, '.', 2);
EXECUTE '
	CREATE OR REPLACE VIEW '|| tbl_out ||' AS
		SELECT ROW_NUMBER() OVER (ORDER BY transaction_timestamp ASC) AS rowid, * 
		FROM history.ttime_gethistory('''|| tbl_in ||''') 
			main ('|| tbl_struct ||', transaction_timestamp timestamptz, transaction_type text);
	';
END;
$$;


ALTER FUNCTION history.ttime_gethistory(tbl_in character varying, tbl_out character varying) OWNER TO postgres;

--
-- Name: FUNCTION ttime_gethistory(tbl_in character varying, tbl_out character varying); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION ttime_gethistory(tbl_in character varying, tbl_out character varying) IS '
This function searches history.logged_actions to get all transactions of object primitives. Results table structure is defined dynamically from input table/view. Returns view.
Arguments:
   tbl_in:		schema.table character varying
   tbl_out:		schema.table character varying
';


--
-- Name: vtime_gethistory(character varying, character varying, character varying); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION vtime_gethistory(tbl character varying, col_value character varying, col_vtime character varying) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY EXECUTE '
	--query1: query new_record column to get the INSERT records
	(SELECT DISTINCT ON (b.new_record->''gid'') (populate_record(null::' ||tbl|| ', b.new_record)).*, b.transaction_time, b.transaction_type FROM history.logged_actions AS b 
		WHERE b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND (populate_record(null::' ||tbl|| ', b.new_record)).'||col_value||'=''BUILT'' 
	ORDER BY b.new_record->''gid'', b.transaction_time DESC)

	UNION ALL

	--query2: query new_record column to get the UPDATE records
	(SELECT DISTINCT ON (b.new_record->''gid'', b.new_record->'''||col_vtime||''') (populate_record(null::' ||tbl|| ', b.new_record)).*, b.transaction_time, b.transaction_type FROM history.logged_actions AS b 
		WHERE b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND (populate_record(null::' ||tbl|| ', b.new_record)).'||col_value||'=''MODIF''
	ORDER BY b.new_record->''gid'', b.new_record->'''||col_vtime||''', b.transaction_time DESC)

	UNION ALL
	
	--query3: query old_record column to get the DELETE records
	(SELECT DISTINCT ON (b.old_record->''gid'') (populate_record(null::' ||tbl|| ', b.old_record)).*, b.transaction_time, b.transaction_type FROM history.logged_actions AS b 
		WHERE b.table_name = split_part('''||tbl||''', ''.'', 2) 
		AND (populate_record(null::' ||tbl|| ', b.old_record)).'||col_value||'=''DESTR'' 
	ORDER BY b.old_record->''gid'', b.transaction_time DESC)
	';
END;
$$;


ALTER FUNCTION history.vtime_gethistory(tbl character varying, col_value character varying, col_vtime character varying) OWNER TO postgres;

--
-- Name: FUNCTION vtime_gethistory(tbl character varying, col_value character varying, col_vtime character varying); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION vtime_gethistory(tbl character varying, col_value character varying, col_vtime character varying) IS '
This function searches history.logged_actions to get all real world changes with the corresponding latest version for each object primitive at each valid time.
Results table structure needs to be defined manually. Returns set of records.

Arguments:
   tbl:			table/view that holds the valid time columns character varying
   col_value:		column that holds the qualifier values (BUILT, MODIF, DESTR) character varying
   col_vtime:		column that holds the actual valid time character varying
';


--
-- Name: vtime_gethistory(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: history; Owner: postgres
--

CREATE FUNCTION vtime_gethistory(tbl_in character varying, tbl_out character varying, col_value character varying, col_vtime character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
  tbl_struct text;
BEGIN
tbl_struct := string_agg(column_name || ' ' || udt_name, ',') FROM information_schema.columns WHERE table_name = split_part(tbl_in, '.', 2);
EXECUTE '
	CREATE OR REPLACE VIEW '|| tbl_out ||' AS
		SELECT ROW_NUMBER() OVER (ORDER BY transaction_timestamp ASC) AS rowid, * 
		FROM history.vtime_gethistory('''|| tbl_in ||''', '''|| col_value ||''', '''|| col_vtime ||''') 
			main ('|| tbl_struct ||', transaction_timestamp timestamptz, transaction_type text);
	';
END;
$$;


ALTER FUNCTION history.vtime_gethistory(tbl_in character varying, tbl_out character varying, col_value character varying, col_vtime character varying) OWNER TO postgres;

--
-- Name: FUNCTION vtime_gethistory(tbl_in character varying, tbl_out character varying, col_value character varying, col_vtime character varying); Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON FUNCTION vtime_gethistory(tbl_in character varying, tbl_out character varying, col_value character varying, col_vtime character varying) IS '
This function searches history.logged_actions to get all real world changes with the corresponding latest version for each object primitive at each valid time.
Results table structure is defined dynamically from input table/view. Returns view.
Arguments:
   tbl_in:		schema.table character varying
   tbl_out:		schema.table character varying
   col_value:		column that holds the qualifier values (BUILT, MODIF, DESTR) character varying
   col_vtime:		column that holds the actual valid time character varying
';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: logged_actions; Type: TABLE; Schema: history; Owner: postgres; Tablespace: 
--

CREATE TABLE logged_actions (
    gid bigint NOT NULL,
    schema_name text NOT NULL,
    table_name text NOT NULL,
    table_id oid NOT NULL,
    transaction_id bigint,
    transaction_user text,
    transaction_time timestamp with time zone NOT NULL,
    transaction_query text,
    transaction_type text NOT NULL,
    old_record public.hstore,
    new_record public.hstore,
    changed_fields public.hstore,
    CONSTRAINT logged_actions_transaction_type_check CHECK ((transaction_type = ANY (ARRAY['I'::text, 'D'::text, 'U'::text, 'T'::text])))
);


ALTER TABLE history.logged_actions OWNER TO postgres;

--
-- Name: TABLE logged_actions; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON TABLE logged_actions IS 'History of transactions on activated tables, from history.if_modified_func().';


--
-- Name: COLUMN logged_actions.gid; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.gid IS 'Unique log identifier';


--
-- Name: COLUMN logged_actions.schema_name; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.schema_name IS 'Textual reference to the database schema which contains the modified table';


--
-- Name: COLUMN logged_actions.table_name; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.table_name IS 'Name of the modified table';


--
-- Name: COLUMN logged_actions.table_id; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.table_id IS 'OID of the modified table';


--
-- Name: COLUMN logged_actions.transaction_id; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.transaction_id IS 'Identifier of the transaction (may differ from gid when more than one row is affected by a transaction query)';


--
-- Name: COLUMN logged_actions.transaction_user; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.transaction_user IS 'Session user name who caused the transaction';


--
-- Name: COLUMN logged_actions.transaction_time; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.transaction_time IS 'Timestamp when transaction was started (current_timestamp)';


--
-- Name: COLUMN logged_actions.transaction_query; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.transaction_query IS 'Transaction query';


--
-- Name: COLUMN logged_actions.transaction_type; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.transaction_type IS 'Transaction type (I = insert, D = delete, U = update, T = truncate)';


--
-- Name: COLUMN logged_actions.old_record; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.old_record IS 'The old record before the modification containing all the values as hstore (for DELETE and UPDATE statements)';


--
-- Name: COLUMN logged_actions.new_record; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.new_record IS 'The new record after the modification containing all the values as hstore (for INSERT and UPDATE statements)';


--
-- Name: COLUMN logged_actions.changed_fields; Type: COMMENT; Schema: history; Owner: postgres
--

COMMENT ON COLUMN logged_actions.changed_fields IS 'The modified fields only, including the new values, stored as hstore';


--
-- Name: logged_actions_gid_seq; Type: SEQUENCE; Schema: history; Owner: postgres
--

CREATE SEQUENCE logged_actions_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE history.logged_actions_gid_seq OWNER TO postgres;

--
-- Name: logged_actions_gid_seq; Type: SEQUENCE OWNED BY; Schema: history; Owner: postgres
--

ALTER SEQUENCE logged_actions_gid_seq OWNED BY logged_actions.gid;


--
-- Name: gid; Type: DEFAULT; Schema: history; Owner: postgres
--

ALTER TABLE ONLY logged_actions ALTER COLUMN gid SET DEFAULT nextval('logged_actions_gid_seq'::regclass);


--
-- Data for Name: logged_actions; Type: TABLE DATA; Schema: history; Owner: postgres
--

COPY logged_actions (gid, schema_name, table_name, table_id, transaction_id, transaction_user, transaction_time, transaction_query, transaction_type, old_record, new_record, changed_fields) FROM stdin;
\.


--
-- Name: logged_actions_gid_seq; Type: SEQUENCE SET; Schema: history; Owner: postgres
--

SELECT pg_catalog.setval('logged_actions_gid_seq', 1, false);


--
-- Name: logged_actions_pkey; Type: CONSTRAINT; Schema: history; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logged_actions
    ADD CONSTRAINT logged_actions_pkey PRIMARY KEY (gid);


--
-- Name: logged_changes_action_idx; Type: INDEX; Schema: history; Owner: postgres; Tablespace: 
--

CREATE INDEX logged_changes_action_idx ON logged_actions USING btree (transaction_type);


--
-- Name: logged_changes_table_id_idx; Type: INDEX; Schema: history; Owner: postgres; Tablespace: 
--

CREATE INDEX logged_changes_table_id_idx ON logged_actions USING btree (table_id);


--
-- PostgreSQL database dump complete
--

