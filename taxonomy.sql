--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: taxonomy; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA taxonomy;


ALTER SCHEMA taxonomy OWNER TO postgres;

--
-- Name: SCHEMA taxonomy; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA taxonomy IS 'includes attribute and qualifiers of possibly different taxonomies';


SET search_path = taxonomy, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dic_attribute_type; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_attribute_type (
    gid integer NOT NULL,
    code character varying(254),
    description character varying(254),
    extended_description character varying(1024),
    taxonomy_code character varying(254),
    attribute_level smallint,
    attribute_order smallint
);


ALTER TABLE taxonomy.dic_attribute_type OWNER TO postgres;

--
-- Name: TABLE dic_attribute_type; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_attribute_type IS 'The attribute type dictionary table. Contains information about the attribute types.';


--
-- Name: COLUMN dic_attribute_type.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.gid IS 'Unique attribute type identifier';


--
-- Name: COLUMN dic_attribute_type.code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.code IS 'Code of the attribute type';


--
-- Name: COLUMN dic_attribute_type.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.description IS 'Short textual description of the attribute type';


--
-- Name: COLUMN dic_attribute_type.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.extended_description IS 'Extended textual description of the attribute type';


--
-- Name: COLUMN dic_attribute_type.taxonomy_code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.taxonomy_code IS 'Code of the taxonomy';


--
-- Name: COLUMN dic_attribute_type.attribute_level; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.attribute_level IS 'Identifier of the attribute level (e.g. GEM taxonomy: 1 = main attribute, 2 = secondary attribute, 3 = tertiary attribute)';


--
-- Name: COLUMN dic_attribute_type.attribute_order; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_type.attribute_order IS 'Order of the attribute type. To be used for compiling a textual representation of the taxonomy attributes and their values which follows a predefined order (e.g. GEM Taxonomy TaxT strings)';


--
-- Name: dic_attribute_type_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_attribute_type_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_attribute_type_gid_seq OWNER TO postgres;

--
-- Name: dic_attribute_type_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_attribute_type_gid_seq OWNED BY dic_attribute_type.gid;


--
-- Name: dic_attribute_value; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_attribute_value (
    gid integer NOT NULL,
    attribute_type_code character varying(254),
    attribute_value character varying(254),
    description character varying(254),
    extended_description character varying(1024)
);


ALTER TABLE taxonomy.dic_attribute_value OWNER TO postgres;

--
-- Name: TABLE dic_attribute_value; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_attribute_value IS 'The attribute value dictionary table. Contains information about the attribute values.';


--
-- Name: COLUMN dic_attribute_value.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_value.gid IS 'Unique attribute value identifier';


--
-- Name: COLUMN dic_attribute_value.attribute_type_code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_value.attribute_type_code IS 'Code of the attribute type to which the value refers to';


--
-- Name: COLUMN dic_attribute_value.attribute_value; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_value.attribute_value IS 'Value of the attribute';


--
-- Name: COLUMN dic_attribute_value.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_value.description IS 'Short textual description of the attribute value';


--
-- Name: COLUMN dic_attribute_value.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_attribute_value.extended_description IS 'Extended textual description of the attribute value';


--
-- Name: dic_attribute_value_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_attribute_value_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_attribute_value_gid_seq OWNER TO postgres;

--
-- Name: dic_attribute_value_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_attribute_value_gid_seq OWNED BY dic_attribute_value.gid;


--
-- Name: dic_hazard; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_hazard (
    gid integer NOT NULL,
    code character varying(254),
    description character varying(254),
    extended_description character varying(1024),
    attribute_type_code character varying(254)
);


ALTER TABLE taxonomy.dic_hazard OWNER TO postgres;

--
-- Name: TABLE dic_hazard; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_hazard IS 'The hazard dictionary table. Contains information about the hazard type to which the taxonomy attribute type is linked to.';


--
-- Name: COLUMN dic_hazard.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_hazard.gid IS 'Unique hazard identifier';


--
-- Name: COLUMN dic_hazard.code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_hazard.code IS 'Identifier for the hazard type';


--
-- Name: COLUMN dic_hazard.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_hazard.description IS 'Short textual description of the hazard type';


--
-- Name: COLUMN dic_hazard.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_hazard.extended_description IS 'Extended textual description of the hazard type';


--
-- Name: COLUMN dic_hazard.attribute_type_code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_hazard.attribute_type_code IS 'Code of the taxonomy attribute type to which the hazard type is linked to';


--
-- Name: dic_hazard_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_hazard_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_hazard_gid_seq OWNER TO postgres;

--
-- Name: dic_hazard_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_hazard_gid_seq OWNED BY dic_hazard.gid;


--
-- Name: dic_qualifier_type; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_qualifier_type (
    gid integer NOT NULL,
    code character varying(254),
    description character varying(254),
    extended_description character varying(1024)
);


ALTER TABLE taxonomy.dic_qualifier_type OWNER TO postgres;

--
-- Name: TABLE dic_qualifier_type; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_qualifier_type IS 'The qualifier type dictionary table. Contains information about the qualifier types.';


--
-- Name: COLUMN dic_qualifier_type.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_type.gid IS 'Unique qualifier type identifier';


--
-- Name: COLUMN dic_qualifier_type.code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_type.code IS 'Code of the qualifier type';


--
-- Name: COLUMN dic_qualifier_type.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_type.description IS 'Short textual description of the qualifier type';


--
-- Name: COLUMN dic_qualifier_type.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_type.extended_description IS 'Extended textual description of the qualifier type';


--
-- Name: dic_qualifier_type_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_qualifier_type_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_qualifier_type_gid_seq OWNER TO postgres;

--
-- Name: dic_qualifier_type_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_qualifier_type_gid_seq OWNED BY dic_qualifier_type.gid;


--
-- Name: dic_qualifier_value; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_qualifier_value (
    gid integer NOT NULL,
    qualifier_type_code character varying(254),
    qualifier_value character varying(254),
    description character varying(254),
    extended_description character varying(1024)
);


ALTER TABLE taxonomy.dic_qualifier_value OWNER TO postgres;

--
-- Name: TABLE dic_qualifier_value; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_qualifier_value IS 'The qualifier value dictionary table. Contains information about the qualifier values.';


--
-- Name: COLUMN dic_qualifier_value.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_value.gid IS 'Unique qualifier value identifier';


--
-- Name: COLUMN dic_qualifier_value.qualifier_type_code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_value.qualifier_type_code IS 'Code of the qualifier type to which the value refers to';


--
-- Name: COLUMN dic_qualifier_value.qualifier_value; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_value.qualifier_value IS 'Value of the qualifier';


--
-- Name: COLUMN dic_qualifier_value.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_value.description IS 'Short textual description of the qualifier value';


--
-- Name: COLUMN dic_qualifier_value.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_qualifier_value.extended_description IS 'Extended textual description of the qualifier value';


--
-- Name: dic_qualifier_value_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_qualifier_value_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_qualifier_value_gid_seq OWNER TO postgres;

--
-- Name: dic_qualifier_value_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_qualifier_value_gid_seq OWNED BY dic_qualifier_value.gid;


--
-- Name: dic_taxonomy; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_taxonomy (
    gid integer NOT NULL,
    code character varying(254),
    description character varying(254),
    extended_description character varying(1024),
    version_date date
);


ALTER TABLE taxonomy.dic_taxonomy OWNER TO postgres;

--
-- Name: TABLE dic_taxonomy; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON TABLE dic_taxonomy IS 'The taxonomy dictionary table. Contains information about the taxonomy to which the attribute type is linked to.';


--
-- Name: COLUMN dic_taxonomy.gid; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_taxonomy.gid IS 'Unique taxonomy identifier';


--
-- Name: COLUMN dic_taxonomy.code; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_taxonomy.code IS 'Code of the taxonomy';


--
-- Name: COLUMN dic_taxonomy.description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_taxonomy.description IS 'Short textual description of the taxonomy';


--
-- Name: COLUMN dic_taxonomy.extended_description; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_taxonomy.extended_description IS 'Extended textual description of the taxonomy';


--
-- Name: COLUMN dic_taxonomy.version_date; Type: COMMENT; Schema: taxonomy; Owner: postgres
--

COMMENT ON COLUMN dic_taxonomy.version_date IS 'Version of the taxonomy (date of the version)';


--
-- Name: dic_taxonomy_gid_seq; Type: SEQUENCE; Schema: taxonomy; Owner: postgres
--

CREATE SEQUENCE dic_taxonomy_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxonomy.dic_taxonomy_gid_seq OWNER TO postgres;

--
-- Name: dic_taxonomy_gid_seq; Type: SEQUENCE OWNED BY; Schema: taxonomy; Owner: postgres
--

ALTER SEQUENCE dic_taxonomy_gid_seq OWNED BY dic_taxonomy.gid;


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_attribute_type ALTER COLUMN gid SET DEFAULT nextval('dic_attribute_type_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_attribute_value ALTER COLUMN gid SET DEFAULT nextval('dic_attribute_value_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_hazard ALTER COLUMN gid SET DEFAULT nextval('dic_hazard_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_qualifier_type ALTER COLUMN gid SET DEFAULT nextval('dic_qualifier_type_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_qualifier_value ALTER COLUMN gid SET DEFAULT nextval('dic_qualifier_value_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_taxonomy ALTER COLUMN gid SET DEFAULT nextval('dic_taxonomy_gid_seq'::regclass);


--
-- Data for Name: dic_attribute_type; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_attribute_type (gid, code, description, extended_description, taxonomy_code, attribute_level, attribute_order) FROM stdin;
19	ROOFSYSTYP	Roof System Type	\N	GEM20	4	\N
20	ROOF_CONN	Roof Connections	\N	GEM20	5	\N
1	MAT_TYPE	Material Type	\N	GEM20	1	\N
2	MAT_TECH	Material Technology	\N	GEM20	2	\N
3	MAT_PROP	Material Property	\N	GEM20	3	\N
21	FLOOR_MAT	Floor Material	\N	GEM20	1	\N
4	LLRS	Type of Lateral Load-Resisting System	\N	GEM20	1	\N
5	LLRS_DUCT	System Ductility	\N	GEM20	2	\N
22	FLOOR_TYPE	Floor System Type	\N	GEM20	2	\N
6	HEIGHT	Height	\N	GEM20	1	\N
23	FLOOR_CONN	Floor Connections	\N	GEM20	3	\N
7	YR_BUILT	Date of Construction or Retrofit	\N	GEM20	1	\N
24	FOUNDN_SYS	Foundation System	\N	GEM20	1	\N
8	OCCUPY	Building Occupancy Class - General	\N	GEM20	1	\N
9	OCCUPY_DT	Building Occupancy Class - Detail	\N	GEM20	2	\N
10	POSITION	Building Position within a Block	\N	GEM20	1	\N
11	PLAN_SHAPE	Shape of the Building Plan	\N	GEM20	1	\N
12	STR_IRREG	Regular or Irregular	\N	GEM20	1	\N
13	STR_IRREG_DT	Plan Irregularity or Vertical Irregularity	\N	GEM20	2	\N
14	STR_IRREG_TYPE	Type of Irregularity	\N	GEM20	3	\N
15	NONSTRCEXW	Exterior walls	\N	GEM20	1	\N
16	ROOF_SHAPE	Roof Shape	\N	GEM20	1	\N
17	ROOFCOVMAT	Roof Covering	\N	GEM20	2	\N
18	ROOFSYSMAT	Roof System Material	\N	GEM20	3	\N
25	BUILD_TYPE	Building Type	\N	EMCA	1	\N
26	BUILD_SUBTYPE	Building Subtype	\N	EMCA	2	\N
27	VULN	Structural Vulnerability Class	\N	EMS98	1	\N
\.


--
-- Name: dic_attribute_type_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_attribute_type_gid_seq', 1, false);


--
-- Data for Name: dic_attribute_value; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_attribute_value (gid, attribute_type_code, attribute_value, description, extended_description) FROM stdin;
92	LLRS	LH	LH - Hybrid lateral load-resisting system	\N
93	LLRS	LO	LO - Other lateral load-resisting system	\N
94	LLRS_DUCT	DU99	DU99 - Ductility unknown	\N
95	LLRS_DUCT	DUC	DUC - Ductile	\N
96	LLRS_DUCT	DNO	DNO - Non-ductile	\N
97	LLRS_DUCT	DBD	DBD - Equipped with base isolation and/or energy dissipation devices	\N
1	MAT_TYPE	MAT99	MAT99 - Unknown material	\N
2	MAT_TYPE	C99	C99 - Concrete, unknown reinforcement	\N
3	MAT_TYPE	CU	CU - Concrete, unreinforced	\N
4	MAT_TYPE	CR	CR - Concrete, reinforced	\N
5	MAT_TYPE	SRC	SRC - Concrete, composite with steel section	\N
6	MAT_TYPE	S	S - Steel	\N
7	MAT_TYPE	ME	ME - Metal (except steel)	\N
8	MAT_TYPE	M99	M99 - Masonry, unknown reinforcement	\N
9	MAT_TYPE	MUR	MUR - Masonry, unreinforced	\N
10	MAT_TYPE	MCF	MCF - Masonry, confined	\N
11	MAT_TYPE	MR	MR - Masonry, reinforced	\N
12	MAT_TYPE	E99	E99 - Earth, unknown reinforcement	\N
13	MAT_TYPE	EU	EU - Earth, unreinforced	\N
14	MAT_TYPE	ER	ER - Earth, reinforced	\N
15	MAT_TYPE	W	W - Wood	\N
32	MAT_TECH	STRUB	STRUB - Rubble (field stone) or semi-dressed stone	\N
16	MAT_TYPE	MATO	MATO - Other material	\N
31	MAT_TECH	ST99	ST99 - Stone, unknown technology	\N
30	MAT_TECH	ADO	ADO - Adobe blocks	\N
29	MAT_TECH	MUN99	MUN99 - Masonry unit, unknown	\N
33	MAT_TECH	STDRE	STDRE - Dressed stone	\N
34	MAT_TECH	CL99	CL99 - Fired clay unit, unknown type	\N
35	MAT_TECH	CLBRS	CLBRS - Fired clay solid bricks	\N
36	MAT_TECH	CLBRH	CLBRH - Fired clay hollow bricks	\N
37	MAT_TECH	CLBLH	CLBLH - Fired clay hollow blocks or tiles	\N
38	MAT_TECH	CB99	CB99 - Concrete blocks, unknown type	\N
98	HEIGHT	H99	H99 - Number of storeys unknown	\N
17	MAT_TECH	CT99	CT99 - Unknown concrete technology	\N
18	MAT_TECH	CIP	CIP - Cast-in-place concrete	\N
19	MAT_TECH	PC	PC - Precast concrete	\N
20	MAT_TECH	CIPPS	CIPPS - Cast-in-place prestressed concrete	\N
21	MAT_TECH	PCPS	PCPS - Precast prestressed concrete	\N
22	MAT_TECH	S99	S99 - Steel, unknown	\N
23	MAT_TECH	SL	SL - Cold-formed steel members	\N
24	MAT_TECH	SR	SR - Hot-rolled steel members	\N
25	MAT_TECH	SO	SO - Steel, other	\N
26	MAT_TECH	ME99	ME99 - Metal, unknown	\N
27	MAT_TECH	MEIR	MEIR - Iron	\N
28	MAT_TECH	MEO	MEO - Metal, other	\N
39	MAT_TECH	CBS	CBS - Concrete blocks, solid	\N
40	MAT_TECH	CBH	CBH - Concrete blocks, hollow	\N
41	MAT_TECH	MO	MO - Masonry unit, other	\N
42	MAT_TECH	MR99	MR99 - Masonry reinforcement, unknown	\N
43	MAT_TECH	RS	RS - Steel reinforced	\N
99	HEIGHT	H	H - Number of storeys above ground	\N
44	MAT_TECH	RW	RW - Wood-reinforced	\N
45	MAT_TECH	RB	RB - Bamboo-, cane- or rope-reinforcement	\N
46	MAT_TECH	RCM	RCM - Fibre reinforcing mesh	\N
100	HEIGHT	HB	HB - Number of storeys below ground	\N
47	MAT_TECH	RCB	RCB - Reinforced concrete bands	\N
48	MAT_TECH	ET99	ET99 - Unknown earth technology	\N
49	MAT_TECH	ETR	ETR - Rammed earth	\N
101	HEIGHT	HF	HF - Height of ground floor level above grade	\N
50	MAT_TECH	ETC	ETC - Cob or wet construction	\N
51	MAT_TECH	ETO	ETO - Earth technology, other	\N
52	MAT_TECH	W99	W99 - Wood, unknown	\N
53	MAT_TECH	WHE	WHE - Heavy wood	\N
54	MAT_TECH	WLI	WLI - Light wood members	\N
55	MAT_TECH	WS	WS - Solid wood	\N
56	MAT_TECH	WWD	WWD - Wattle and daub	\N
57	MAT_TECH	WBB	WBB - Bamboo	\N
58	MAT_TECH	WO	WO - Wood, other	\N
103	YR_BUILT	Y99	Y99 - Year unknown	\N
104	YR_BUILT	YEX	YEX - Exact  date of construction or retrofit	\N
106	YR_BUILT	YPRE	YPRE - Latest possible date of construction or retrofit	\N
60	MAT_PROP	SC99	SC99 - Steel connections, unknown	\N
62	MAT_PROP	WEL	WEL - Welded connections	\N
63	MAT_PROP	RIV	RIV - Riveted connections	\N
64	MAT_PROP	BOL	BOL - Bolted connections	\N
65	MAT_PROP	MO99	MO99 - Mortar type unknown	\N
66	MAT_PROP	MON	MON - No mortar	\N
67	MAT_PROP	MOM	MOM - Mud mortar	\N
68	MAT_PROP	MOL	MOL - Lime mortar	\N
69	MAT_PROP	MOC	MOC - Cement mortar	\N
70	MAT_PROP	MOCL	MOCL - Cement: lime mortar	\N
71	MAT_PROP	SP99	SP99 - Stone, unknown type	\N
109	OCCUPY	RES	RES - Residential	\N
72	MAT_PROP	SPLI	SPLI - Limestone	\N
73	MAT_PROP	SPSA	SPSA - Sandstone	\N
74	MAT_PROP	SPTU	SPTU - Tuff	\N
75	MAT_PROP	SPSL	SPSL - Slate	\N
76	MAT_PROP	SPGR	SPGR - Granite	\N
77	MAT_PROP	SPBA	SPBA - Basalt	\N
78	MAT_PROP	SPO	SPO - Stone, other type	\N
80	MAT_TECH	MATT99	MATT99 - Unknown material technology	\N
81	MAT_PROP	MATP99	MATP99 - Unknown material property	\N
84	LLRS	LFM	LFM - Moment frame	\N
82	LLRS	L99	L99 - Unknown lateral load-resisting system	\N
83	LLRS	LN	LN - No lateral load-resisting system	\N
85	LLRS	LFINF	LFINF - Infilled frame	\N
86	LLRS	LFBR	LFBR - Braced frame	\N
87	LLRS	LPB	LPN - Post and beam	\N
88	LLRS	LWAL	LWAL - Wall	\N
89	LLRS	LDUAL	LDUAL - Dual frame-wall system	\N
90	LLRS	LFLS	LFLS - Flat slab/plate or infilled waffle slab	\N
91	LLRS	LFLSINF	LFLSINF - Infilled flat slab/plate or infilled waffle slab	\N
105	YR_BUILT	YBET	YBET - Upper and lower bound for the date of construction or retrofit	\N
107	YR_BUILT	YAPP	YAPP - Approximate date of construction or retrofit	\N
235	ROOFCOVMAT	RMT99	RMT99 - Unknown roof covering	\N
147	OCCUPY_DT	MIX4	MIX4 - Mostly residential and industrial	\N
148	OCCUPY_DT	MIX5	MIX5 - Mostly industrial and commercial	\N
149	OCCUPY_DT	MIX6	MIX6 - Mostly industrial and residential	\N
150	OCCUPY_DT	IND99	IND99 - Industiral, unknown type	\N
236	ROOFCOVMAT	RMN	RMN - Concrete rood without additional covering	\N
151	OCCUPY_DT	IND1	IND1 - Heavy industrial	\N
152	OCCUPY_DT	IND2	IND2 - Light industrial	\N
153	OCCUPY_DT	AGR99	AGR99 - Agriculture, unknown type	\N
154	OCCUPY_DT	AGR1	AGR1 - Produce storage	\N
155	OCCUPY_DT	AGR2	AGR2 - Animal shelter	\N
156	OCCUPY_DT	AGR3	AGR3 - Agricultural processing	\N
157	OCCUPY_DT	ASS99	ASS99 - Assembly, unknown type	\N
158	OCCUPY_DT	ASS1	ASS1 - Religious gathering	\N
159	OCCUPY_DT	ASS2	ASS2 - Arena	\N
160	OCCUPY_DT	ASS3	ASS3 - Cinema or concert hall	\N
161	OCCUPY_DT	ASS4	ASS4 - Other gatherings	\N
162	OCCUPY_DT	GOV99	GOV99 - Government, unknown type	\N
163	OCCUPY_DT	GOV1	GOV1 - Government, general services	\N
164	OCCUPY_DT	GOV2	GOV2 - Government, emergency services	\N
165	OCCUPY_DT	EDU99	EDU99 - Education, unknown type	\N
166	OCCUPY_DT	EDU1	EDU1 - Pre-school facility	\N
167	OCCUPY_DT	EDU2	EDU2 - School	\N
196	STR_IRREG	IRIR	IRIR - Irregular structure	\N
170	POSITION	BPD	BPD - Detached building	\N
171	POSITION	BP1	BP1 - Adjoining building(s) on one side	\N
197	STR_IRREG_DT	IRPP	IRPP - Plan irregularity - primary	\N
172	POSITION	BP2	BP2 - Adjoining building(s) on two sides	\N
173	POSITION	BP3	BP3 - Adjoining building(s) on three sides	\N
198	STR_IRREG_DT	IRPS	IRPS - Plan irregularity - secondary	\N
199	STR_IRREG_DT	IRVP	IRVP - Vertical irregularity - primary	\N
200	STR_IRREG_DT	IRVS	IRVS - Vertical irregularity - secondary	\N
201	STR_IRREG_TYPE	IRN	INR - No irregularity	\N
202	STR_IRREG_TYPE	TOR	TOR - Torsion eccentricity	\N
203	STR_IRREG_TYPE	REC	REC - Re-entrant corner	\N
204	STR_IRREG_TYPE	IRHO	IRHO - Other plan irregularity	\N
237	ROOFCOVMAT	RMT1	RMT1 - Clay or concrete tile roof covering	\N
205	STR_IRREG_TYPE	SOS	SOS - Soft storey	\N
206	STR_IRREG_TYPE	CRW	CRW - Cripple wall	\N
207	STR_IRREG_TYPE	SHC	SHC - Short column	\N
208	STR_IRREG_TYPE	POP	POP - Pounding potential	\N
209	STR_IRREG_TYPE	SET	SET - Setback	\N
210	STR_IRREG_TYPE	CHV	CHV - Change in vertical structure (includes large overhangs)	\N
211	STR_IRREG_TYPE	IRVO	IRVO - Other vertical irregularity	\N
238	ROOFCOVMAT	RMT2	RMT2 - Fibre cement or metal tile roof covering	\N
239	ROOFCOVMAT	RMT3	RMT3 - Membrane roof covering	\N
240	ROOFCOVMAT	RMT4	RMT4 - Slate roof covering	\N
212	NONSTRCEXW	EW99	EW99 - Unknown material of exterior walls	\N
213	NONSTRCEXW	EWC	EWC - Concrete exterior walls	\N
214	NONSTRCEXW	EWG	EWG - Glass exterior walls	\N
215	NONSTRCEXW	EWE	EWE - Earthen exterior walls	\N
216	NONSTRCEXW	EWMA	EWMA - Masonry exterior walls	\N
241	ROOFCOVMAT	RMT5	RMT5 - Stone slab roof covering	\N
242	ROOFCOVMAT	RMT6	RMT6 - Metal or asbestos sheet roof covering	\N
243	ROOFCOVMAT	RMT7	RMT7 - Wooden or asphalt shingle roof covering	\N
244	ROOFCOVMAT	RMT8	RMT8 - Vegetative roof covering	\N
245	ROOFCOVMAT	RMT9	RMT9 - Earthen roof covering	\N
228	ROOF_SHAPE	RSH4	RSH4 - Pitched with dormers	\N
229	ROOF_SHAPE	RSH5	RSH5 - Monopitch	\N
230	ROOF_SHAPE	RSH6	RSH6 - Sawtooth	\N
231	ROOF_SHAPE	RSH7	RSH7 - Curved	\N
232	ROOF_SHAPE	RSH8	RSH8 - Complex regular	\N
233	ROOF_SHAPE	RSH9	RSH9 - Complex irregular	\N
234	ROOF_SHAPE	RSHO	RSHO - Roof shape, other	\N
246	ROOFCOVMAT	RMT10	RMT10 - Solar panelled roofs	\N
247	ROOFCOVMAT	RMT11	RMT11 - Tensile membrane or fabric roof	\N
248	ROOFCOVMAT	RMTO	RMTO - Roof covering, other	\N
249	ROOFSYSMAT	RM	RM - Masonry roof	\N
250	ROOFSYSMAT	RE	RE - Earthen roof	\N
251	ROOFSYSMAT	RC	RC - Concrete roof	\N
252	ROOFSYSMAT	RME	RME - Metal roof	\N
253	ROOFSYSMAT	RWO	RWO - Wooden roof	\N
254	ROOFSYSMAT	RFA	RFA - Fabric roof	\N
255	ROOFSYSMAT	RO	RO - Roof material, other	\N
256	ROOFSYSTYP	RM99	RM99 - Masonry roof, unknown	\N
257	ROOFSYSTYP	RM1	RM1 - Vaulted masonry roof	\N
258	ROOFSYSTYP	RM2	RM2 - Shallow-arched masonry roof	\N
259	ROOFSYSTYP	RM3	RM3 - Composite masonry and concrete roof system	\N
260	ROOFSYSTYP	RE99	RE99 - Earthen roof, unknown	\N
261	ROOFSYSTYP	RE1	RE1 - Vaulted earthen roof, unknown	\N
281	ROOF_CONN	RWCP	RWCP - Roof-wall diaphragm connection present	\N
283	ROOF_CONN	RTDN	RTDN - Roof tie-down not provided	\N
282	ROOF_CONN	RTD99	RTD99 - Roof tie-down unknown	\N
284	ROOF_CONN	RTDP	RTDP - Roof tie-down present	\N
285	FLOOR_MAT	FN	FN - No elevated or suspended floor	\N
286	FLOOR_MAT	F99	F99 - Floor material, unknown	\N
288	FLOOR_MAT	FE	FE - Earthen floor	\N
290	FLOOR_MAT	FME	FME - Metal floor	\N
294	FLOOR_TYPE	FM1	FM1 - Vaulted masonry floor	\N
297	FLOOR_TYPE	FE99	FE99 - Earthen floor, unknown	\N
298	FLOOR_TYPE	FC99	FC99 - Concrete floor, unknown	\N
134	OCCUPY_DT	COM3	COM3 - Offices, professional/technical services	\N
135	OCCUPY_DT	COM4	COM4 - Hospital/medical clinic	\N
136	OCCUPY_DT	COM5	COM5 - Entertainment	\N
137	OCCUPY_DT	COM6	COM6 - Public building	\N
138	OCCUPY_DT	COM7	COM7 - Covered parking garage	\N
139	OCCUPY_DT	COM8	COM8 - Bus station	\N
108	OCCUPY	OC99	OC99 - Unknown occupancy	\N
110	OCCUPY	COM	COM - Commercial and public	\N
111	OCCUPY	MIX	MIX - Mixed use	\N
112	OCCUPY	IND	IND - Industrial	\N
113	OCCUPY	AGR	AGR - Agriculture	\N
114	OCCUPY	ASS	ASS - Assembly	\N
115	OCCUPY	GOV	GOV - Government	\N
116	OCCUPY	EDU	EDU - Education	\N
117	OCCUPY	OCO	OCO - Other occupancy type	\N
140	OCCUPY_DT	COM9	COM9 - Railway station	\N
141	OCCUPY_DT	COM10	COM10 - Airport	\N
142	OCCUPY_DT	COM11	COM11 - Recreation and leisure	\N
143	OCCUPY_DT	MIX99	MIX99 - Mixed, unknown type	\N
144	OCCUPY_DT	MIX1	MIX1 - Mostly residential and commercial	\N
145	OCCUPY_DT	MIX2	MIX2 - Mostly commercial and residential	\N
146	OCCUPY_DT	MIX3	MIX3 - Mostly commercial and industrial	\N
176	PLAN_SHAPE	PLFSQO	PLFSQO - Square, with an opening in plan	\N
177	PLAN_SHAPE	PLFR	PLFR - Rectangular, solid	\N
178	PLAN_SHAPE	PLFRO	PLFRO - Rectangular, with an opening in plan	\N
179	PLAN_SHAPE	PLFL	PLFL - L-shape	\N
180	PLAN_SHAPE	PLFC	PLFC - Curved, solid	\N
181	PLAN_SHAPE	PLFCO	PLFCO - Curved, with an opening in plan	\N
182	PLAN_SHAPE	PLFD	PLFD - Triangular, solid	\N
118	OCCUPY_DT	RES99	RES99 - Residential, unknown type	\N
119	OCCUPY_DT	RES1	RES1 - Single dwelling	\N
120	OCCUPY_DT	RES2	RES2 - Multi-unit, unknown type	\N
121	OCCUPY_DT	RES2A	RES2A - 2 Units (duplex)	\N
122	OCCUPY_DT	RES2B	RES2B - 3-4 Units	\N
123	OCCUPY_DT	RES2C	RES2C - 5-9 Units	\N
124	OCCUPY_DT	RES2D	RES2D - 10-19 Units	\N
168	OCCUPY_DT	EDU3	EDU3 - College/university offices and/or classrooms	\N
125	OCCUPY_DT	RES2E	RES2E - 20-49 Units	\N
126	OCCUPY_DT	RES2F	RES2F - 50+ Units	\N
127	OCCUPY_DT	RES3	RES3 - Temporary lodging	\N
128	OCCUPY_DT	RES4	RES4 - Institutional housing	\N
129	OCCUPY_DT	RES5	RES5 - Mobile home	\N
130	OCCUPY_DT	RES6	RES6 - Informal housing	\N
131	OCCUPY_DT	COM99	COM99 - Commercial and public, unknown type	\N
132	OCCUPY_DT	COM1	COM1 - Retail trade	\N
133	OCCUPY_DT	COM2	COM2 - Wholesale trade and storage (warehouse)	\N
169	OCCUPY_DT	EDU4	EDU4 - College/university research facilities and/or labs	\N
183	PLAN_SHAPE	PLFDO	PLFDO - Triangular, with an opening in plan	\N
184	PLAN_SHAPE	PLFP	PLFP - Polygonal, solid (e.g. trapezoid, pentagon, hexagon)	\N
262	ROOFSYSTYP	RC99	RC99 - Concrete roof, unknown	\N
263	ROOFSYSTYP	RC1	RC1 - Cast-in-place beamless reinforced concrete roof	\N
174	PLAN_SHAPE	PLF99	PLF99 - Unknown plan shape	\N
175	PLAN_SHAPE	PLFSQ	PLFSQ - Square, solid	\N
185	PLAN_SHAPE	PLFPO	PLFPO - Polygonal, with an opening in plan	\N
217	NONSTRCEXW	EWME	EWME - Metal exterior walls	\N
186	PLAN_SHAPE	PLFE	PLFE - E-shape	\N
187	PLAN_SHAPE	PLFH	PLFH - H-shape	\N
188	PLAN_SHAPE	PLFS	PLFS - S-shape	\N
189	PLAN_SHAPE	PLFT	PLFT - T-shape	\N
190	PLAN_SHAPE	PLFU	PLFU - U- or C-shape	\N
191	PLAN_SHAPE	PLFX	PLFX - X-shape	\N
192	PLAN_SHAPE	PLFY	PLFY - Y-shape	\N
193	PLAN_SHAPE	PLFI	PLFI - Irregular plan shape	\N
264	ROOFSYSTYP	RC2	RC2 - Cast-in-place beam-supported reinforced concrete roof	\N
265	ROOFSYSTYP	RC3	RC3 - Precast concrete roof with reinforced concrete topping	\N
194	STR_IRREG	IR99	IR99 - Unknown structural irregularity	\N
195	STR_IRREG	IRRE	IRRE - Regular structure	\N
266	ROOFSYSTYP	RC4	RC4 - Precast concrete roof without reinforced concrete topping	\N
267	ROOFSYSTYP	RME99	RME99 - Metal roof, unknown	\N
268	ROOFSYSTYP	RME1	RME1 - Metal beams or trusses supporting light roofing	\N
269	ROOFSYSTYP	RME2	RME2 - Metal roof beams supporting precast concrete slabs	\N
270	ROOFSYSTYP	RME3	RME3 - Composite steel roof deck and concrete slab	\N
271	ROOFSYSTYP	RWO99	RWO99 - Wooden roof, unknown	\N
218	NONSTRCEXW	EWV	EWV - Vegetative exterior walls	\N
219	NONSTRCEXW	EWW	EWW - Wooden exterior walls	\N
220	NONSTRCEXW	EWSL	EWSL - Stucco finish on light framing for exterior walls	\N
221	NONSTRCEXW	EWPL	EWPL - Plastic/vinyl exterior walls, various	\N
222	NONSTRCEXW	EWCB	EWCB - Cement-based boards for exterior walls	\N
223	NONSTRCEXW	EWO	EWO - Material of exterior walls, other	\N
272	ROOFSYSTYP	RWO1	RWO1 - Wooden structure with roof covering	\N
273	ROOFSYSTYP	RWO2	RWO2 - Wooden beams or trusses with heavy roof covering	\N
274	ROOFSYSTYP	RWO3	RWO3 - Wood-based sheets on rafters or purlins	\N
224	ROOF_SHAPE	R99	R99 - Unknown roof shape	\N
225	ROOF_SHAPE	RSH1	RSH1 - Flat	\N
226	ROOF_SHAPE	RSH2	RSH2 - Pitched with gable ends	\N
227	ROOF_SHAPE	RSH3	RSH3 - Pitched and hipped	\N
275	ROOFSYSTYP	RWO4	RWO4 - Plywood panels or other light-weight panels for roof	\N
276	ROOFSYSTYP	RWO5	RWO5 - Bamboo, straw or thatch roof	\N
277	ROOFSYSTYP	RFA1	RFA1 - Inflatable or tensile membrane roof	\N
278	ROOFSYSTYP	RFAO	RFAO - Fabric roof, other	\N
279	ROOF_CONN	RWC99	RWC99 - Roof-wall diaphragm connection unknown	\N
280	ROOF_CONN	RWCN	RWCN - Roof-wall diaphragm connection not provided	\N
287	FLOOR_MAT	FM	FM - Masonry floor	\N
289	FLOOR_MAT	FC	FC - Concrete floor	\N
291	FLOOR_MAT	FW	FW - Wooden floor	\N
292	FLOOR_MAT	FO	FO - Floor material, other	\N
304	FLOOR_TYPE	FME1	FME1 - Metal beams, trusses or joists supporting light flooring	\N
305	FLOOR_TYPE	FME2	FME2 - Metal floor beams supporting precast concrete slabs	\N
306	FLOOR_TYPE	FME3	FME3 - Composite steel deck and concrete slab	\N
293	FLOOR_TYPE	FM99	FM99 - Masonry floor, unknown	\N
295	FLOOR_TYPE	FM2	FM2 - Shallow-arched masonry floor	\N
296	FLOOR_TYPE	FM3	FM3 - Composite cast-in-place reinforced concrete and masonry floor system	\N
299	FLOOR_TYPE	FC1	FC1 - Cast-in-place beamless reinforced concrete floor	\N
300	FLOOR_TYPE	FC2	FC2 - Cast-in-place beam-supported reinforced concrete floor	\N
301	FLOOR_TYPE	FC3	FC3 - Precast concrete flor with reinforced concrete topping	\N
302	FLOOR_TYPE	FC4	FC4 - Precast concrete floor without reinforced concrete topping	\N
303	FLOOR_TYPE	FME99	FME99 - Metal floor, unknown	\N
307	FLOOR_TYPE	FW99	FW99 - Wooden floor, unknown	\N
308	FLOOR_TYPE	FW1	FW1 - Wooden beams or trusses and joists supporting light flooring	\N
309	FLOOR_TYPE	FW2	FW2 - Wooden beams or trusses and joists supporting heavy flooring	\N
310	FLOOR_TYPE	FW3	FW3 - Wood-based sheets on joists or beams	\N
311	FLOOR_TYPE	FW4	FW4 - Plywood panels or other light-weight panels for floor	\N
312	FLOOR_CONN	FWC99	FWC99 - Floor-wall diaphragm connection unknown	\N
313	FLOOR_CONN	FWCN	FWCN - Floor-wall diaphragm connection not provided	\N
314	FLOOR_CONN	FWCP	FWCP - Floor-wall diaphragm connection present	\N
315	FOUNDN_SYS	FOS99	FOS99 - Unknown foundation system	\N
316	FOUNDN_SYS	FOSSL	FOSSL - Shallow foundation, with lateral capacity	\N
317	FOUNDN_SYS	FOSN	FOSN - Shallow foundation, no lateral capacity	\N
318	FOUNDN_SYS	FOSDL	FOSDL - Deep foundation, with lateral capacity	\N
319	FOUNDN_SYS	FOSDN	FOSDN - Deep foundation, no lateral capacity	\N
320	FOUNDN_SYS	FOSO	FOSO - Foundation, other	\N
321	OCCUPY_DT	OCCDT99	OCCDT99 - Occupancy detail, unknown	\N
322	POSITION	BP99	BP99 - Position, unknown	\N
324	STR_IRREG_TYPE	IRT99	IRT99 - Structural irregularity type, unknown	\N
323	STR_IRREG_DT	IRP99	IRP99 - Structural irregularity detail, unknown	\N
357	ROOFSYSMAT	RSM99	RSM99 - Roof system material, unknown	\N
358	ROOFSYSTYP	RST99	RST99 - Roof system type, unknown	\N
360	ROOF_CONN	RCN99	RCN99 - Roof connection, unknown	\N
361	FLOOR_TYPE	FT99	FT99 - Floor type, unknown	\N
362	BUILD_TYPE	EMCA1	EMCA1 - Load bearing masonry wall buildings	\N
363	BUILD_TYPE	EMCA2	EMCA2 - Monolithic reinforced concrete buildings	\N
364	BUILD_TYPE	EMCA3	EMCA3 - Precast concrete buildings	\N
365	BUILD_TYPE	EMCA4	EMCA4 - Non-engineered earthen buildings	\N
366	BUILD_TYPE	EMCA5	EMCA5 - Wooden buildings	\N
367	BUILD_TYPE	EMCA6	EMCA6 - Steel buildings	\N
368	BUILD_SUBTYPE	EMCA1_1	EMCA1.1 - Unreinforced masonry buildings with walls of brick masonry, stone, or blocks in cement or mixed mortar (no seismic design) - wooden floors	DX /MUR+CLBRS+MOC /LWAL+DNO /DY /MUR+CLBRS+MOC /LWAL+DNO /YAPP:1940-1955 /HBET:2,3 /RES+RES2E /BP3 /PLFR /IRRE /EWMA /RSH3+RMT4+RO+RWCP /FW /FOSS
369	BUILD_SUBTYPE	EMCA1_2	EMCA1.2 - Unreinforced masonry - buildings with walls of brick masonry, stone, or blocks in cement or mixed mortar (no seismic design) - precast concrete floors	DX /MUR+MOCL /LWAL+DNO /DY /MUR+MOCL /LWAL+DNO /YBET:1975,1990 /HBET:1,2+HBEX:0+HFBET:0.5,1.0+HD:0 /RES+RES2A / /PLFR /IRRE /EWMA /RSH3+RMT4+RWO+RWO3+RTDP /FC+FC3+FWCP /FOSS 
370	BUILD_SUBTYPE	EMCA1_3	EMCA1.3 - Confined masonry	DX /MCF+MOC /LWAL+DNO /DY /MCF+MOC /LWAL+DNO /YBET:1961,2012 /HBET:1,5+HBEX:0+HFBET:0.5,1.5+HD:0 /RES+RES2E / /PLFR /IRIR+IRVP:SOS /EWMA /RSH3+RMT4+RWO+RWO3+RTDP /FC+FC3+FWCP /FOSSL
371	BUILD_SUBTYPE	EMCA1_4	EMCA1.4 - Masonry with seismic provisions (e.g. seismic belts)	DX /MR+CLBRS+RCB+MOCL /LWAL+DNO /DY /MR+CLBRS+RCB+MOCL /LWAL+DNO /YBET:1948,1959 /HBET:1,3+HBEX:0+HFBET:0.3,0.8+HD:0 /RES+RES2D /BPD /PLFR /IRRE /EWMA /RSH3+RMT4+RWO+RWO3+RTDP /FW+FW3+FWCP /FOSSL
372	BUILD_SUBTYPE	EMCA2_1	EMCA2.1 - Buildings with monolithic concrete moment frames	DX /CR+CIP /LFM+DUC /DY /CR+CIP /LFM+DUC /YBET:1950,2012 /HBET:3,7+HBEX:0+HFBET:0.8,1.2+HD:0 /RES+RES2E /BPD /PLFR /IRRE /EWCB /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCN /FOSDL
373	BUILD_SUBTYPE	EMCA2_2	EMCA2.2 - Buildings with monolithic concrete frame and shear walls (dual system)	DX /CR+CIP /LDUAL+DNO /DY /CR+CIP /LDUAL+DNO /YBET:1987,2012 /HBET:7,25+HBBET:1,3+HFBET:1.2,2.0+HD:0 /RES+RES2F /BPD /PLFR /IRIR+IRVP:CHV /EWMA /RSH1+RMN+RC+RC2+RTDP /FC+FC2+FWCP /FOSDL
374	BUILD_SUBTYPE	EMCA2_3	EMCA2.3 - Buildings with monolithic concrete frames and brick infill walls	DX /CR+CIP /LFINF+DNO /DY /CR+CIP /LFINF+DNO /YBET:1975,1995 /HBET:3,7+HBEX:0+HFBET:1,1.5+HD:0 /RES+RES2E /BPD /PLFR /IRRE /EWMA /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCN /FOSDL
375	BUILD_SUBTYPE	EMCA2_4	EMCA2.4 - Buildings with monolithic reinforced concrete walls	DX /CR+CIP /LWAL+DNO /DY /CR+CIP /LWAL+DNO /YBET:1980,2012 /HBET:8,16+HBEX:1+HFBET:1,1.5+HD:0 /RES+RES2F /BPD /PLFR /IRIR+IRVP:SOS /EWC /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCN /FOSDL
376	BUILD_SUBTYPE	EMCA3_1	EMCA3.1 - Precast concrete large panel buildings with monolithic panel joints - Seria 105	DX /CR+PC /LWAL+DUC /DY /CR+PC /LWAL+DUC /YBET:1964,2012 /HBET:1,16+HBEX:1+HFBET:1,1.8+HD:0 /RES+RES2F /BPD /PLFR /IRRE /EWC /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCP /FOSDL
377	BUILD_SUBTYPE	EMCA3_2	EMCA3.2 - Precast concrete large panel buildings with panel connections achieved by welding of embedment plates - Seria 464	
378	BUILD_SUBTYPE	EMCA3_3	EMCA3.3 - Precast concrete flat slab buildings (consisting of columns and slabs) - Seria KUB	DX /CR+PC /LFLS+DUC /DY /CR+PC /LFLS+DUC /YBET:1980,1990 /HBET:5,9+HBEX:1+HFBET:0.8,1.5+HD:0 /RES+RES2F /BPD /PLFR /IRRE /EWC /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCP /FOSDL
379	BUILD_SUBTYPE	EMCA3_4	EMCA3.4 - Prefabricated RC frame with linear elements with welded joints in the zone of maximum loads or with rigid walls in one direction - Seria 111, IIS-04	DX /CR+PC /LFLS+DUC /DY /CR+PC /LFLS+DUC /YBET:1966,1970 /HBET:6,7+HBEX:1+HFBET:1,1.5+HD:0 /RES+RES2E /BPD /PLFR /IRRE /EWC /RSH1+RMN+RC+RC3+RTDP /FC+FC3+FWCP /FOSDL
380	BUILD_SUBTYPE	EMCA4_1	EMCA4.1 - Buildings with adobe or earthen walls	DX /MUR+ADO+MOM /LWAL+DNO /DY /MUR+ADO+MOM /LWAL+DNO /YBET:1850,2012 /HEX:1+HBEX:0+HFBET:0.3,0.5+HD:0 /RES+RES1 /BPD /PLFR /IRIR+IRPP:TOR /EWE /RSH2+RMT4+RWO+RWO3+RTDN /FW+FW3+FWCN /FOSSL
381	BUILD_SUBTYPE	EMCA5_1	EMCA5.1 - Buildings with load-bearing braced wooden frames	DX /W /LWAL+DUC /DY /W /LWAL+DUC /YBET:1950,1970 /HBET:1,2+HBEX:0+HFBET:0.3,0.5+HD:0 /RES+RES2C /BPD /PLFR /IRRE /EWW /RSH2+RMT4+RWO+RWO3+RTDP /FW+FW3+FWCP /FOSSL
382	BUILD_SUBTYPE	EMCA5_2	EMCA5.2 - Building with a wooden frame and mud infill	DX /W+WLI /LO+DUC /DY /W+WLI /LO+DUC /YBET:0,2012 /HBET:1,2+HBEX:0+HFBET:0.3,0.5+HD:0 /RES+RES1 /BPD /PLFR /IRRE /EWE /RSH2+RMT4+RWO+RWO3+RTDP /FW+FW3+FWCP /FOSSL
383	BUILD_SUBTYPE	EMCA6_1	EMCA6.1 - Steel buildings	DX /S+SL+RIV /LFM+DNO /DY /S+SL+RIV /LFM+DNO /YAPP:2008 /HEX:1+HFEX:3+HD:15 /RES+RES1 /BPD /PLFR /IRRE /EWPL /RSH3+RMT6+RME+RME1+RWCP /FME+FME3 /FOSSL
384	VULN	VULN_EX	Exact vulnerability class	\N
385	VULN	VULN_BET	Lower and upper class of vulnerability	\N
\.


--
-- Name: dic_attribute_value_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_attribute_value_gid_seq', 1, false);


--
-- Data for Name: dic_hazard; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_hazard (gid, code, description, extended_description, attribute_type_code) FROM stdin;
1	EQ	EQ - Earthquake	\N	MAT_TYPE
2	EQ	EQ - Earthquake	\N	MAT_TECH
3	EQ	EQ - Earthquake	\N	MAT_PROP
4	EQ	EQ - Earthquake	\N	LLRS
5	EQ	EQ - Earthquake	\N	LLRS_DUCT
6	EQ	EQ - Earthquake	\N	HEIGHT
7	EQ	EQ - Earthquake	\N	YR_BUILT
8	EQ	EQ - Earthquake	\N	OCCUPY
9	EQ	EQ - Earthquake	\N	OCCUPY_DT
10	EQ	EQ - Earthquake	\N	POSITION
11	EQ	EQ - Earthquake	\N	PLAN_SHAPE
12	EQ	EQ - Earthquake	\N	STR_IRREG
13	EQ	EQ - Earthquake	\N	STR_IRREG_DT
14	EQ	EQ - Earthquake	\N	STR_IRREG_TYPE
15	EQ	EQ - Earthquake	\N	NONSTRCEXW
16	EQ	EQ - Earthquake	\N	ROOF_SHAPE
17	EQ	EQ - Earthquake	\N	ROOFCOVMAT
18	EQ	EQ - Earthquake	\N	ROOFSYSMAT
19	EQ	EQ - Earthquake	\N	ROOFSYSTYP
20	EQ	EQ - Earthquake	\N	ROOF_CONN
21	EQ	EQ - Earthquake	\N	FLOOR_MAT
22	EQ	EQ - Earthquake	\N	FLOOR_TYPE
23	EQ	EQ - Earthquake	\N	FLOOR_CONN
24	EQ	EQ - Earthquake	\N	FOUNDN_SYS
25	EQ	EQ - Earthquake	\N	BUILD_TYPE
26	EQ	EQ - Earthquake	\N	BUILD_SUBTYPE
27	EQ	EQ - Earthquake	\N	VULN
\.


--
-- Name: dic_hazard_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_hazard_gid_seq', 1, false);


--
-- Data for Name: dic_qualifier_type; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_qualifier_type (gid, code, description, extended_description) FROM stdin;
1	BELIEF	Uncertainty measured as subjective degree of belief	\N
2	QUALITY	Assessment of quality of attribute information	\N
3	SOURCE	Source of information	\N
4	VALIDTIME	Valid time of real-world object (e.g., construction period)	\N
\.


--
-- Name: dic_qualifier_type_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_qualifier_type_gid_seq', 1, false);


--
-- Data for Name: dic_qualifier_value; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_qualifier_value (gid, qualifier_type_code, qualifier_value, description, extended_description) FROM stdin;
1	BELIEF	BLOW	\N	\N
2	BELIEF	BHIGH	\N	\N
3	BELIEF	BP	Percentage 1-100 - use add_numeric_1 to enter belief value	\N
4	BELIEF	B99	Unknown	\N
5	QUALITY	QLOW	\N	\N
6	QUALITY	QMEDIUM	\N	\N
7	QUALITY	QHIGH	\N	\N
8	SOURCE	OSM	OpenStreetMap	\N
9	SOURCE	RS	Remote Sensing	\N
10	SOURCE	RVS	Rapid Visual Screening	\N
11	SOURCE	RRVS	Remote Rapid Visual Screening	\N
12	SOURCE	OF	Official Source (e.g. cadastral data or census)	\N
13	VALIDTIME	BUILT	Start timestamp of lifetime	\N
14	VALIDTIME	MODIF	Modification timestamp of lifetime	\N
15	VALIDTIME	DESTR	End timestamp of lifetime	\N
\.


--
-- Name: dic_qualifier_value_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_qualifier_value_gid_seq', 1, false);


--
-- Data for Name: dic_taxonomy; Type: TABLE DATA; Schema: taxonomy; Owner: postgres
--

COPY dic_taxonomy (gid, code, description, extended_description, version_date) FROM stdin;
1	GEM20	GEM Building Taxonomy V2.0	\N	2013-03-12
2	SENSUM	SENSUM Indicators	\N	2013-11-12
3	EMCA	EMCA Building Typology	\N	2013-04-16
4	EMS98	European Macroseismic Scale 1998	\N	1998-01-01
\.


--
-- Name: dic_taxonomy_gid_seq; Type: SEQUENCE SET; Schema: taxonomy; Owner: postgres
--

SELECT pg_catalog.setval('dic_taxonomy_gid_seq', 1, false);


--
-- Name: idx_dic_attribute_type; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_attribute_type
    ADD CONSTRAINT idx_dic_attribute_type UNIQUE (code);


--
-- Name: pk_dic_attribute_type; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_attribute_type
    ADD CONSTRAINT pk_dic_attribute_type PRIMARY KEY (gid);


--
-- Name: pk_dic_attribute_value; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_attribute_value
    ADD CONSTRAINT pk_dic_attribute_value PRIMARY KEY (gid);


--
-- Name: pk_dic_attribute_value_0; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_attribute_value
    ADD CONSTRAINT pk_dic_attribute_value_0 UNIQUE (attribute_value);


--
-- Name: pk_dic_qualifier_type; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_qualifier_type
    ADD CONSTRAINT pk_dic_qualifier_type UNIQUE (code);


--
-- Name: pk_dic_qualifier_value; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_qualifier_value
    ADD CONSTRAINT pk_dic_qualifier_value PRIMARY KEY (gid);


--
-- Name: pk_dic_qualifier_value_0; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_qualifier_value
    ADD CONSTRAINT pk_dic_qualifier_value_0 UNIQUE (qualifier_value);


--
-- Name: pk_dic_taxonomy; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_taxonomy
    ADD CONSTRAINT pk_dic_taxonomy PRIMARY KEY (gid);


--
-- Name: pk_dic_taxonomy_0; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_taxonomy
    ADD CONSTRAINT pk_dic_taxonomy_0 UNIQUE (code);


--
-- Name: pk_hazard; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_hazard
    ADD CONSTRAINT pk_hazard PRIMARY KEY (gid);


--
-- Name: pk_qualifier_type; Type: CONSTRAINT; Schema: taxonomy; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dic_qualifier_type
    ADD CONSTRAINT pk_qualifier_type PRIMARY KEY (gid);


--
-- Name: idx_dic_attribute_type_0; Type: INDEX; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dic_attribute_type_0 ON dic_attribute_type USING btree (taxonomy_code);


--
-- Name: idx_dic_attribute_value; Type: INDEX; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dic_attribute_value ON dic_attribute_value USING btree (attribute_type_code);


--
-- Name: idx_dic_qualifier_value; Type: INDEX; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dic_qualifier_value ON dic_qualifier_value USING btree (qualifier_type_code);


--
-- Name: idx_hazard; Type: INDEX; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_hazard ON dic_hazard USING btree (attribute_type_code);


--
-- Name: fk_attribute_type_code; Type: FK CONSTRAINT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_attribute_value
    ADD CONSTRAINT fk_attribute_type_code FOREIGN KEY (attribute_type_code) REFERENCES dic_attribute_type(code);


--
-- Name: fk_attribute_type_code; Type: FK CONSTRAINT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_hazard
    ADD CONSTRAINT fk_attribute_type_code FOREIGN KEY (attribute_type_code) REFERENCES dic_attribute_type(code);


--
-- Name: fk_dic_attribute_type; Type: FK CONSTRAINT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_attribute_type
    ADD CONSTRAINT fk_dic_attribute_type FOREIGN KEY (taxonomy_code) REFERENCES dic_taxonomy(code);


--
-- Name: fk_dic_qualifier_value; Type: FK CONSTRAINT; Schema: taxonomy; Owner: postgres
--

ALTER TABLE ONLY dic_qualifier_value
    ADD CONSTRAINT fk_dic_qualifier_value FOREIGN KEY (qualifier_type_code) REFERENCES dic_qualifier_type(code);


--
-- PostgreSQL database dump complete
--

