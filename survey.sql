--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: survey; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA survey;


ALTER SCHEMA survey OWNER TO postgres;

SET search_path = survey, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: survey; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey (
    gid integer NOT NULL,
    name character varying(100),
    description character varying(255),
    type character varying(100),
    resp character varying(255)
);


ALTER TABLE survey.survey OWNER TO postgres;

--
-- Name: TABLE survey; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON TABLE survey IS 'main description of the survey';


--
-- Name: COLUMN survey.gid; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey.gid IS 'unique id';


--
-- Name: COLUMN survey.name; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey.name IS 'survey (short) name ';


--
-- Name: COLUMN survey.description; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey.description IS 'short description of the survey';


--
-- Name: COLUMN survey.type; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey.type IS 'survey type';


--
-- Name: COLUMN survey.resp; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey.resp IS 'name of survey responsible';


--
-- Name: survey_gid_seq; Type: SEQUENCE; Schema: survey; Owner: postgres
--

CREATE SEQUENCE survey_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey.survey_gid_seq OWNER TO postgres;

--
-- Name: survey_gid_seq; Type: SEQUENCE OWNED BY; Schema: survey; Owner: postgres
--

ALTER SEQUENCE survey_gid_seq OWNED BY survey.gid;


--
-- Name: survey_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_type (
    gid integer NOT NULL,
    code character varying(100),
    description character varying(255)
);


ALTER TABLE survey.survey_type OWNER TO postgres;

--
-- Name: TABLE survey_type; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON TABLE survey_type IS 'list the different types of surveys which can generate or modify assset contents';


--
-- Name: COLUMN survey_type.gid; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey_type.gid IS 'unique id';


--
-- Name: COLUMN survey_type.code; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey_type.code IS 'alfanumeric identifier of the survey type';


--
-- Name: COLUMN survey_type.description; Type: COMMENT; Schema: survey; Owner: postgres
--

COMMENT ON COLUMN survey_type.description IS 'short textual description of the type';


--
-- Name: survey_type_gid_seq; Type: SEQUENCE; Schema: survey; Owner: postgres
--

CREATE SEQUENCE survey_type_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey.survey_type_gid_seq OWNER TO postgres;

--
-- Name: survey_type_gid_seq; Type: SEQUENCE OWNED BY; Schema: survey; Owner: postgres
--

ALTER SEQUENCE survey_type_gid_seq OWNED BY survey_type.gid;


--
-- Name: gid; Type: DEFAULT; Schema: survey; Owner: postgres
--

ALTER TABLE ONLY survey ALTER COLUMN gid SET DEFAULT nextval('survey_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: survey; Owner: postgres
--

ALTER TABLE ONLY survey_type ALTER COLUMN gid SET DEFAULT nextval('survey_type_gid_seq'::regclass);


--
-- Data for Name: survey; Type: TABLE DATA; Schema: survey; Owner: postgres
--

COPY survey (gid, name, description, type, resp) FROM stdin;
\.


--
-- Name: survey_gid_seq; Type: SEQUENCE SET; Schema: survey; Owner: postgres
--

SELECT pg_catalog.setval('survey_gid_seq', 1, false);


--
-- Data for Name: survey_type; Type: TABLE DATA; Schema: survey; Owner: postgres
--

COPY survey_type (gid, code, description) FROM stdin;
1	RRVS	Remote Rapid Visual Survey
3	OTH	Other (unspecified)
2	IDCT	Inventory Data Capture Tool
\.


--
-- Name: survey_type_gid_seq; Type: SEQUENCE SET; Schema: survey; Owner: postgres
--

SELECT pg_catalog.setval('survey_type_gid_seq', 1, false);


--
-- Name: pk_survey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT pk_survey PRIMARY KEY (gid);


--
-- Name: pk_survey_type; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_type
    ADD CONSTRAINT pk_survey_type PRIMARY KEY (gid);


--
-- Name: pk_survey_type_0; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_type
    ADD CONSTRAINT pk_survey_type_0 UNIQUE (code);


--
-- Name: idx_survey; Type: INDEX; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_survey ON survey USING btree (type);


--
-- Name: fk_survey_survey_type; Type: FK CONSTRAINT; Schema: survey; Owner: postgres
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT fk_survey_survey_type FOREIGN KEY (type) REFERENCES survey_type(code);


--
-- PostgreSQL database dump complete
--

