--------------------------------------------------------------
-- PostgreSQL script to create REM DB templates in a database
--------------------------------------------------------------

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Create extensions
--

CREATE EXTENSION IF NOT EXISTS postgis; 
CREATE EXTENSION IF NOT EXISTS postgis_topology; 
CREATE EXTENSION IF NOT EXISTS hstore; 
CREATE EXTENSION IF NOT EXISTS tablefunc; 

-----------------------------------------------------------
--
-- Name: taxonomy; Type: SCHEMA; Schema: -; Owner: postgres
--
-----------------------------------------------------------

CREATE SCHEMA taxonomy;
ALTER SCHEMA taxonomy OWNER TO postgres;

COMMENT ON SCHEMA taxonomy IS 'includes attribute and qualifiers of possibly different taxonomies';

SET search_path = taxonomy, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: dic_taxonomy; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_taxonomy (
    gid serial PRIMARY KEY,
    code character varying(254) UNIQUE,
    description character varying(254),
    extended_description character varying(1024),
    version_date date
);

ALTER TABLE taxonomy.dic_taxonomy OWNER TO postgres;

COMMENT ON TABLE dic_taxonomy IS 'The taxonomy dictionary table. Contains information about the taxonomy to which the attribute type is linked to.';
COMMENT ON COLUMN dic_taxonomy.gid IS 'Unique taxonomy identifier';
COMMENT ON COLUMN dic_taxonomy.code IS 'Code of the taxonomy';
COMMENT ON COLUMN dic_taxonomy.description IS 'Short textual description of the taxonomy';
COMMENT ON COLUMN dic_taxonomy.extended_description IS 'Extended textual description of the taxonomy';
COMMENT ON COLUMN dic_taxonomy.version_date IS 'Version of the taxonomy (date of the version)';

COPY dic_taxonomy (gid, code, description, extended_description, version_date) FROM stdin;
1	GEM20	GEM Building Taxonomy V2.0	\N	2013-03-12
2	SENSUM	SENSUM Indicators	\N	2013-11-12
3	EMCA	EMCA Building Typology	\N	2013-04-16
4	EMS98	European Macroseismic Scale 1998	\N	1998-01-01
\.

--
-- Name: dic_attribute_type; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_attribute_type (
    gid serial PRIMARY KEY,
    code character varying(254) UNIQUE,
    description character varying(254),
    extended_description character varying(1024),
    taxonomy_code character varying(254),
    attribute_level smallint,
    attribute_order smallint
);

ALTER TABLE taxonomy.dic_attribute_type OWNER TO postgres;

COMMENT ON TABLE dic_attribute_type IS 'The attribute type dictionary table. Contains information about the attribute types.';
COMMENT ON COLUMN dic_attribute_type.gid IS 'Unique attribute type identifier';
COMMENT ON COLUMN dic_attribute_type.code IS 'Code of the attribute type';
COMMENT ON COLUMN dic_attribute_type.description IS 'Short textual description of the attribute type';
COMMENT ON COLUMN dic_attribute_type.extended_description IS 'Extended textual description of the attribute type';
COMMENT ON COLUMN dic_attribute_type.taxonomy_code IS 'Code of the taxonomy';
COMMENT ON COLUMN dic_attribute_type.attribute_level IS 'Identifier of the attribute level (e.g. GEM taxonomy: 1 = main attribute, 2 = secondary attribute, 3 = tertiary attribute)';
COMMENT ON COLUMN dic_attribute_type.attribute_order IS 'Order of the attribute type. To be used for compiling a textual representation of the taxonomy attributes and their values which follows a predefined order (e.g. GEM Taxonomy TaxT strings)';

COPY dic_attribute_type (gid, code, description, extended_description, taxonomy_code, attribute_level, attribute_order) FROM stdin;
1	MAT_TYPE	Material Type	\N	GEM20	1	\N
2	MAT_TECH	Material Technology	\N	GEM20	2	\N
3	MAT_PROP	Material Property	\N	GEM20	3	\N
4	LLRS	Type of Lateral Load-Resisting System	\N	GEM20	1	\N
5	LLRS_DUCT	System Ductility	\N	GEM20	2	\N
6	HEIGHT	Height	\N	GEM20	1	\N
7	YR_BUILT	Date of Construction or Retrofit	\N	GEM20	1	\N
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
19	ROOFSYSTYP	Roof System Type	\N	GEM20	4	\N
20	ROOF_CONN	Roof Connections	\N	GEM20	5	\N
21	FLOOR_MAT	Floor Material	\N	GEM20	1	\N
22	FLOOR_TYPE	Floor System Type	\N	GEM20	2	\N
23	FLOOR_CONN	Floor Connections	\N	GEM20	3	\N
24	FOUNDN_SYS	Foundation System	\N	GEM20	1	\N
25	BUILD_TYPE	Building Type	\N	EMCA	1	\N
26	BUILD_SUBTYPE	Building Subtype	\N	EMCA	2	\N
27	VULN	Structural Vulnerability Class	\N	EMS98	1	\N
\.

ALTER TABLE ONLY dic_attribute_type
    ADD CONSTRAINT fk_dic_attribute_type FOREIGN KEY (taxonomy_code) REFERENCES dic_taxonomy(code);

--
-- Name: dic_attribute_value; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_attribute_value (
    gid serial PRIMARY KEY,
    attribute_type_code character varying(254),
    attribute_value character varying(254),
    description character varying(254),
    extended_description character varying(1024)
);


ALTER TABLE taxonomy.dic_attribute_value OWNER TO postgres;

COMMENT ON TABLE dic_attribute_value IS 'The attribute value dictionary table. Contains information about the attribute values.';
COMMENT ON COLUMN dic_attribute_value.gid IS 'Unique attribute value identifier';
COMMENT ON COLUMN dic_attribute_value.attribute_type_code IS 'Code of the attribute type to which the value refers to';
COMMENT ON COLUMN dic_attribute_value.attribute_value IS 'Value of the attribute';
COMMENT ON COLUMN dic_attribute_value.description IS 'Short textual description of the attribute value';
COMMENT ON COLUMN dic_attribute_value.extended_description IS 'Extended textual description of the attribute value';

COPY dic_attribute_value (gid, attribute_type_code, attribute_value, description, extended_description) FROM stdin;
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
16	MAT_TYPE	MATO	MATO - Other material	\N
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
29	MAT_TECH	MUN99	MUN99 - Masonry unit, unknown	\N
30	MAT_TECH	ADO	ADO - Adobe blocks	\N
31	MAT_TECH	ST99	ST99 - Stone, unknown technology	\N
32	MAT_TECH	STRUB	STRUB - Rubble (field stone) or semi-dressed stone	\N
33	MAT_TECH	STDRE	STDRE - Dressed stone	\N
34	MAT_TECH	CL99	CL99 - Fired clay unit, unknown type	\N
35	MAT_TECH	CLBRS	CLBRS - Fired clay solid bricks	\N
36	MAT_TECH	CLBRH	CLBRH - Fired clay hollow bricks	\N
37	MAT_TECH	CLBLH	CLBLH - Fired clay hollow blocks or tiles	\N
38	MAT_TECH	CB99	CB99 - Concrete blocks, unknown type	\N
39	MAT_TECH	CBS	CBS - Concrete blocks, solid	\N
40	MAT_TECH	CBH	CBH - Concrete blocks, hollow	\N
41	MAT_TECH	MO	MO - Masonry unit, other	\N
42	MAT_TECH	MR99	MR99 - Masonry reinforcement, unknown	\N
43	MAT_TECH	RS	RS - Steel reinforced	\N
44	MAT_TECH	RW	RW - Wood-reinforced	\N
45	MAT_TECH	RB	RB - Bamboo-, cane- or rope-reinforcement	\N
46	MAT_TECH	RCM	RCM - Fibre reinforcing mesh	\N
47	MAT_TECH	RCB	RCB - Reinforced concrete bands	\N
48	MAT_TECH	ET99	ET99 - Unknown earth technology	\N
49	MAT_TECH	ETR	ETR - Rammed earth	\N
50	MAT_TECH	ETC	ETC - Cob or wet construction	\N
51	MAT_TECH	ETO	ETO - Earth technology, other	\N
52	MAT_TECH	W99	W99 - Wood, unknown	\N
53	MAT_TECH	WHE	WHE - Heavy wood	\N
54	MAT_TECH	WLI	WLI - Light wood members	\N
55	MAT_TECH	WS	WS - Solid wood	\N
56	MAT_TECH	WWD	WWD - Wattle and daub	\N
57	MAT_TECH	WBB	WBB - Bamboo	\N
58	MAT_TECH	WO	WO - Wood, other	\N
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
92	LLRS	LH	LH - Hybrid lateral load-resisting system	\N
93	LLRS	LO	LO - Other lateral load-resisting system	\N
94	LLRS_DUCT	DU99	DU99 - Ductility unknown	\N
95	LLRS_DUCT	DUC	DUC - Ductile	\N
96	LLRS_DUCT	DNO	DNO - Non-ductile	\N
97	LLRS_DUCT	DBD	DBD - Equipped with base isolation and/or energy dissipation devices	\N
98	HEIGHT	H99	H99 - Number of storeys unknown	\N
99	HEIGHT	H	H - Number of storeys above ground	\N
100	HEIGHT	HB	HB - Number of storeys below ground	\N
101	HEIGHT	HF	HF - Height of ground floor level above grade	\N
103	YR_BUILT	Y99	Y99 - Year unknown	\N
104	YR_BUILT	YEX	YEX - Exact  date of construction or retrofit	\N
105	YR_BUILT	YBET	YBET - Upper and lower bound for the date of construction or retrofit	\N
106	YR_BUILT	YPRE	YPRE - Latest possible date of construction or retrofit	\N
107	YR_BUILT	YAPP	YAPP - Approximate date of construction or retrofit	\N
108	OCCUPY	OC99	OC99 - Unknown occupancy	\N
109	OCCUPY	RES	RES - Residential	\N
110	OCCUPY	COM	COM - Commercial and public	\N
111	OCCUPY	MIX	MIX - Mixed use	\N
112	OCCUPY	IND	IND - Industrial	\N
113	OCCUPY	AGR	AGR - Agriculture	\N
114	OCCUPY	ASS	ASS - Assembly	\N
115	OCCUPY	GOV	GOV - Government	\N
116	OCCUPY	EDU	EDU - Education	\N
117	OCCUPY	OCO	OCO - Other occupancy type	\N
118	OCCUPY_DT	RES99	RES99 - Residential, unknown type	\N
119	OCCUPY_DT	RES1	RES1 - Single dwelling	\N
120	OCCUPY_DT	RES2	RES2 - Multi-unit, unknown type	\N
121	OCCUPY_DT	RES2A	RES2A - 2 Units (duplex)	\N
122	OCCUPY_DT	RES2B	RES2B - 3-4 Units	\N
123	OCCUPY_DT	RES2C	RES2C - 5-9 Units	\N
124	OCCUPY_DT	RES2D	RES2D - 10-19 Units	\N
125	OCCUPY_DT	RES2E	RES2E - 20-49 Units	\N
126	OCCUPY_DT	RES2F	RES2F - 50+ Units	\N
127	OCCUPY_DT	RES3	RES3 - Temporary lodging	\N
128	OCCUPY_DT	RES4	RES4 - Institutional housing	\N
129	OCCUPY_DT	RES5	RES5 - Mobile home	\N
130	OCCUPY_DT	RES6	RES6 - Informal housing	\N
131	OCCUPY_DT	COM99	COM99 - Commercial and public, unknown type	\N
132	OCCUPY_DT	COM1	COM1 - Retail trade	\N
133	OCCUPY_DT	COM2	COM2 - Wholesale trade and storage (warehouse)	\N
134	OCCUPY_DT	COM3	COM3 - Offices, professional/technical services	\N
135	OCCUPY_DT	COM4	COM4 - Hospital/medical clinic	\N
136	OCCUPY_DT	COM5	COM5 - Entertainment	\N
137	OCCUPY_DT	COM6	COM6 - Public building	\N
138	OCCUPY_DT	COM7	COM7 - Covered parking garage	\N
139	OCCUPY_DT	COM8	COM8 - Bus station	\N
140	OCCUPY_DT	COM9	COM9 - Railway station	\N
141	OCCUPY_DT	COM10	COM10 - Airport	\N
142	OCCUPY_DT	COM11	COM11 - Recreation and leisure	\N
143	OCCUPY_DT	MIX99	MIX99 - Mixed, unknown type	\N
144	OCCUPY_DT	MIX1	MIX1 - Mostly residential and commercial	\N
145	OCCUPY_DT	MIX2	MIX2 - Mostly commercial and residential	\N
146	OCCUPY_DT	MIX3	MIX3 - Mostly commercial and industrial	\N
147	OCCUPY_DT	MIX4	MIX4 - Mostly residential and industrial	\N
148	OCCUPY_DT	MIX5	MIX5 - Mostly industrial and commercial	\N
149	OCCUPY_DT	MIX6	MIX6 - Mostly industrial and residential	\N
150	OCCUPY_DT	IND99	IND99 - Industiral, unknown type	\N
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
168	OCCUPY_DT	EDU3	EDU3 - College/university offices and/or classrooms	\N
169	OCCUPY_DT	EDU4	EDU4 - College/university research facilities and/or labs	\N
170	POSITION	BPD	BPD - Detached building	\N
171	POSITION	BP1	BP1 - Adjoining building(s) on one side	\N
172	POSITION	BP2	BP2 - Adjoining building(s) on two sides	\N
173	POSITION	BP3	BP3 - Adjoining building(s) on three sides	\N
174	PLAN_SHAPE	PLF99	PLF99 - Unknown plan shape	\N
175	PLAN_SHAPE	PLFSQ	PLFSQ - Square, solid	\N
176	PLAN_SHAPE	PLFSQO	PLFSQO - Square, with an opening in plan	\N
177	PLAN_SHAPE	PLFR	PLFR - Rectangular, solid	\N
178	PLAN_SHAPE	PLFRO	PLFRO - Rectangular, with an opening in plan	\N
179	PLAN_SHAPE	PLFL	PLFL - L-shape	\N
180	PLAN_SHAPE	PLFC	PLFC - Curved, solid	\N
181	PLAN_SHAPE	PLFCO	PLFCO - Curved, with an opening in plan	\N
182	PLAN_SHAPE	PLFD	PLFD - Triangular, solid	\N
183	PLAN_SHAPE	PLFDO	PLFDO - Triangular, with an opening in plan	\N
184	PLAN_SHAPE	PLFP	PLFP - Polygonal, solid (e.g. trapezoid, pentagon, hexagon)	\N
185	PLAN_SHAPE	PLFPO	PLFPO - Polygonal, with an opening in plan	\N
186	PLAN_SHAPE	PLFE	PLFE - E-shape	\N
187	PLAN_SHAPE	PLFH	PLFH - H-shape	\N
188	PLAN_SHAPE	PLFS	PLFS - S-shape	\N
189	PLAN_SHAPE	PLFT	PLFT - T-shape	\N
190	PLAN_SHAPE	PLFU	PLFU - U- or C-shape	\N
191	PLAN_SHAPE	PLFX	PLFX - X-shape	\N
192	PLAN_SHAPE	PLFY	PLFY - Y-shape	\N
193	PLAN_SHAPE	PLFI	PLFI - Irregular plan shape	\N
194	STR_IRREG	IR99	IR99 - Unknown structural irregularity	\N
195	STR_IRREG	IRRE	IRRE - Regular structure	\N
196	STR_IRREG	IRIR	IRIR - Irregular structure	\N
197	STR_IRREG_DT	IRPP	IRPP - Plan irregularity - primary	\N
198	STR_IRREG_DT	IRPS	IRPS - Plan irregularity - secondary	\N
199	STR_IRREG_DT	IRVP	IRVP - Vertical irregularity - primary	\N
200	STR_IRREG_DT	IRVS	IRVS - Vertical irregularity - secondary	\N
201	STR_IRREG_TYPE	IRN	INR - No irregularity	\N
202	STR_IRREG_TYPE	TOR	TOR - Torsion eccentricity	\N
203	STR_IRREG_TYPE	REC	REC - Re-entrant corner	\N
204	STR_IRREG_TYPE	IRHO	IRHO - Other plan irregularity	\N
205	STR_IRREG_TYPE	SOS	SOS - Soft storey	\N
206	STR_IRREG_TYPE	CRW	CRW - Cripple wall	\N
207	STR_IRREG_TYPE	SHC	SHC - Short column	\N
208	STR_IRREG_TYPE	POP	POP - Pounding potential	\N
209	STR_IRREG_TYPE	SET	SET - Setback	\N
210	STR_IRREG_TYPE	CHV	CHV - Change in vertical structure (includes large overhangs)	\N
211	STR_IRREG_TYPE	IRVO	IRVO - Other vertical irregularity	\N
212	NONSTRCEXW	EW99	EW99 - Unknown material of exterior walls	\N
213	NONSTRCEXW	EWC	EWC - Concrete exterior walls	\N
214	NONSTRCEXW	EWG	EWG - Glass exterior walls	\N
215	NONSTRCEXW	EWE	EWE - Earthen exterior walls	\N
216	NONSTRCEXW	EWMA	EWMA - Masonry exterior walls	\N
217	NONSTRCEXW	EWME	EWME - Metal exterior walls	\N
218	NONSTRCEXW	EWV	EWV - Vegetative exterior walls	\N
219	NONSTRCEXW	EWW	EWW - Wooden exterior walls	\N
220	NONSTRCEXW	EWSL	EWSL - Stucco finish on light framing for exterior walls	\N
221	NONSTRCEXW	EWPL	EWPL - Plastic/vinyl exterior walls, various	\N
222	NONSTRCEXW	EWCB	EWCB - Cement-based boards for exterior walls	\N
223	NONSTRCEXW	EWO	EWO - Material of exterior walls, other	\N
224	ROOF_SHAPE	R99	R99 - Unknown roof shape	\N
225	ROOF_SHAPE	RSH1	RSH1 - Flat	\N
226	ROOF_SHAPE	RSH2	RSH2 - Pitched with gable ends	\N
227	ROOF_SHAPE	RSH3	RSH3 - Pitched and hipped	\N
228	ROOF_SHAPE	RSH4	RSH4 - Pitched with dormers	\N
229	ROOF_SHAPE	RSH5	RSH5 - Monopitch	\N
230	ROOF_SHAPE	RSH6	RSH6 - Sawtooth	\N
231	ROOF_SHAPE	RSH7	RSH7 - Curved	\N
232	ROOF_SHAPE	RSH8	RSH8 - Complex regular	\N
233	ROOF_SHAPE	RSH9	RSH9 - Complex irregular	\N
234	ROOF_SHAPE	RSHO	RSHO - Roof shape, other	\N
235	ROOFCOVMAT	RMT99	RMT99 - Unknown roof covering	\N
236	ROOFCOVMAT	RMN	RMN - Concrete rood without additional covering	\N
237	ROOFCOVMAT	RMT1	RMT1 - Clay or concrete tile roof covering	\N
238	ROOFCOVMAT	RMT2	RMT2 - Fibre cement or metal tile roof covering	\N
239	ROOFCOVMAT	RMT3	RMT3 - Membrane roof covering	\N
240	ROOFCOVMAT	RMT4	RMT4 - Slate roof covering	\N
241	ROOFCOVMAT	RMT5	RMT5 - Stone slab roof covering	\N
242	ROOFCOVMAT	RMT6	RMT6 - Metal or asbestos sheet roof covering	\N
243	ROOFCOVMAT	RMT7	RMT7 - Wooden or asphalt shingle roof covering	\N
244	ROOFCOVMAT	RMT8	RMT8 - Vegetative roof covering	\N
245	ROOFCOVMAT	RMT9	RMT9 - Earthen roof covering	\N
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
262	ROOFSYSTYP	RC99	RC99 - Concrete roof, unknown	\N
263	ROOFSYSTYP	RC1	RC1 - Cast-in-place beamless reinforced concrete roof	\N
264	ROOFSYSTYP	RC2	RC2 - Cast-in-place beam-supported reinforced concrete roof	\N
265	ROOFSYSTYP	RC3	RC3 - Precast concrete roof with reinforced concrete topping	\N
266	ROOFSYSTYP	RC4	RC4 - Precast concrete roof without reinforced concrete topping	\N
267	ROOFSYSTYP	RME99	RME99 - Metal roof, unknown	\N
268	ROOFSYSTYP	RME1	RME1 - Metal beams or trusses supporting light roofing	\N
269	ROOFSYSTYP	RME2	RME2 - Metal roof beams supporting precast concrete slabs	\N
270	ROOFSYSTYP	RME3	RME3 - Composite steel roof deck and concrete slab	\N
271	ROOFSYSTYP	RWO99	RWO99 - Wooden roof, unknown	\N
272	ROOFSYSTYP	RWO1	RWO1 - Wooden structure with roof covering	\N
273	ROOFSYSTYP	RWO2	RWO2 - Wooden beams or trusses with heavy roof covering	\N
274	ROOFSYSTYP	RWO3	RWO3 - Wood-based sheets on rafters or purlins	\N
275	ROOFSYSTYP	RWO4	RWO4 - Plywood panels or other light-weight panels for roof	\N
276	ROOFSYSTYP	RWO5	RWO5 - Bamboo, straw or thatch roof	\N
277	ROOFSYSTYP	RFA1	RFA1 - Inflatable or tensile membrane roof	\N
278	ROOFSYSTYP	RFAO	RFAO - Fabric roof, other	\N
279	ROOF_CONN	RWC99	RWC99 - Roof-wall diaphragm connection unknown	\N
280	ROOF_CONN	RWCN	RWCN - Roof-wall diaphragm connection not provided	\N
281	ROOF_CONN	RWCP	RWCP - Roof-wall diaphragm connection present	\N
282	ROOF_CONN	RTD99	RTD99 - Roof tie-down unknown	\N
283	ROOF_CONN	RTDN	RTDN - Roof tie-down not provided	\N
284	ROOF_CONN	RTDP	RTDP - Roof tie-down present	\N
285	FLOOR_MAT	FN	FN - No elevated or suspended floor	\N
286	FLOOR_MAT	F99	F99 - Floor material, unknown	\N
287	FLOOR_MAT	FM	FM - Masonry floor	\N
288	FLOOR_MAT	FE	FE - Earthen floor	\N
289	FLOOR_MAT	FC	FC - Concrete floor	\N
290	FLOOR_MAT	FME	FME - Metal floor	\N
291	FLOOR_MAT	FW	FW - Wooden floor	\N
292	FLOOR_MAT	FO	FO - Floor material, other	\N
293	FLOOR_TYPE	FM99	FM99 - Masonry floor, unknown	\N
294	FLOOR_TYPE	FM1	FM1 - Vaulted masonry floor	\N
295	FLOOR_TYPE	FM2	FM2 - Shallow-arched masonry floor	\N
296	FLOOR_TYPE	FM3	FM3 - Composite cast-in-place reinforced concrete and masonry floor system	\N
297	FLOOR_TYPE	FE99	FE99 - Earthen floor, unknown	\N
298	FLOOR_TYPE	FC99	FC99 - Concrete floor, unknown	\N
299	FLOOR_TYPE	FC1	FC1 - Cast-in-place beamless reinforced concrete floor	\N
300	FLOOR_TYPE	FC2	FC2 - Cast-in-place beam-supported reinforced concrete floor	\N
301	FLOOR_TYPE	FC3	FC3 - Precast concrete flor with reinforced concrete topping	\N
302	FLOOR_TYPE	FC4	FC4 - Precast concrete floor without reinforced concrete topping	\N
303	FLOOR_TYPE	FME99	FME99 - Metal floor, unknown	\N
304	FLOOR_TYPE	FME1	FME1 - Metal beams, trusses or joists supporting light flooring	\N
305	FLOOR_TYPE	FME2	FME2 - Metal floor beams supporting precast concrete slabs	\N
306	FLOOR_TYPE	FME3	FME3 - Composite steel deck and concrete slab	\N
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
323	STR_IRREG_DT	IRP99	IRP99 - Structural irregularity detail, unknown	\N
324	STR_IRREG_TYPE	IRT99	IRT99 - Structural irregularity type, unknown	\N
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

SELECT pg_catalog.setval('dic_attribute_value_gid_seq', 1, false);

ALTER TABLE ONLY dic_attribute_value
    ADD CONSTRAINT fk_attribute_type_code FOREIGN KEY (attribute_type_code) REFERENCES dic_attribute_type(code);

--
-- Name: dic_hazard; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_hazard (
    gid serial PRIMARY KEY,
    code character varying(254),
    description character varying(254),
    extended_description character varying(1024),
    attribute_type_code character varying(254)
);


ALTER TABLE taxonomy.dic_hazard OWNER TO postgres;

COMMENT ON TABLE dic_hazard IS 'The hazard dictionary table. Contains information about the hazard type to which the taxonomy attribute type is linked to.';


COMMENT ON COLUMN dic_hazard.gid IS 'Unique hazard identifier';

COMMENT ON COLUMN dic_hazard.code IS 'Identifier for the hazard type';

COMMENT ON COLUMN dic_hazard.description IS 'Short textual description of the hazard type';

COMMENT ON COLUMN dic_hazard.extended_description IS 'Extended textual description of the hazard type';

COMMENT ON COLUMN dic_hazard.attribute_type_code IS 'Code of the taxonomy attribute type to which the hazard type is linked to';

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

ALTER TABLE ONLY dic_hazard
    ADD CONSTRAINT fk_attribute_type_code FOREIGN KEY (attribute_type_code) REFERENCES dic_attribute_type(code);

--
-- Name: dic_qualifier_type; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_qualifier_type (
    gid serial PRIMARY KEY,
    code character varying(254) UNIQUE,
    description character varying(254),
    extended_description character varying(1024)
);

ALTER TABLE taxonomy.dic_qualifier_type OWNER TO postgres;

COMMENT ON TABLE dic_qualifier_type IS 'The qualifier type dictionary table. Contains information about the qualifier types.';

COMMENT ON COLUMN dic_qualifier_type.gid IS 'Unique qualifier type identifier';

COMMENT ON COLUMN dic_qualifier_type.code IS 'Code of the qualifier type';

COMMENT ON COLUMN dic_qualifier_type.description IS 'Short textual description of the qualifier type';

COMMENT ON COLUMN dic_qualifier_type.extended_description IS 'Extended textual description of the qualifier type';

COPY dic_qualifier_type (gid, code, description, extended_description) FROM stdin;
1	BELIEF	Uncertainty measured as subjective degree of belief	\N
2	QUALITY	Assessment of quality of attribute information	\N
3	SOURCE	Source of information	\N
4	VALIDTIME	Valid time of real-world object (e.g., construction period)	\N
\.

--
-- Name: dic_qualifier_value; Type: TABLE; Schema: taxonomy; Owner: postgres; Tablespace: 
--

CREATE TABLE dic_qualifier_value (
    gid serial PRIMARY KEY,
    qualifier_type_code character varying(254),
    qualifier_value character varying(254) UNIQUE,
    description character varying(254),
    extended_description character varying(1024)
);

ALTER TABLE taxonomy.dic_qualifier_value OWNER TO postgres;

COMMENT ON TABLE dic_qualifier_value IS 'The qualifier value dictionary table. Contains information about the qualifier values.';
COMMENT ON COLUMN dic_qualifier_value.gid IS 'Unique qualifier value identifier';
COMMENT ON COLUMN dic_qualifier_value.qualifier_type_code IS 'Code of the qualifier type to which the value refers to';
COMMENT ON COLUMN dic_qualifier_value.qualifier_value IS 'Value of the qualifier';
COMMENT ON COLUMN dic_qualifier_value.description IS 'Short textual description of the qualifier value';
COMMENT ON COLUMN dic_qualifier_value.extended_description IS 'Extended textual description of the qualifier value';

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

ALTER TABLE ONLY dic_qualifier_value
    ADD CONSTRAINT fk_dic_qualifier_value FOREIGN KEY (qualifier_type_code) REFERENCES dic_qualifier_type(code);

--
-- Indexes for schema taxonomy 
--

CREATE INDEX idx_dic_attribute_type_0 ON dic_attribute_type USING btree (taxonomy_code);
ALTER TABLE ONLY dic_attribute_type
    ADD CONSTRAINT idx_dic_attribute_type UNIQUE (code);
CREATE INDEX idx_dic_attribute_value ON dic_attribute_value USING btree (attribute_type_code);
CREATE INDEX idx_dic_qualifier_value ON dic_qualifier_value USING btree (qualifier_type_code);
CREATE INDEX idx_hazard ON dic_hazard USING btree (attribute_type_code);

-----------------------------------------------------------
--
-- Name: survey; Type: SCHEMA; Schema: -; Owner: postgres
--
-----------------------------------------------------------

CREATE SCHEMA survey;

ALTER SCHEMA survey OWNER TO postgres;

SET search_path = survey, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: survey; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey (
    gid serial PRIMARY KEY,
    name character varying(100) UNIQUE,
    description character varying(255),
    type character varying(100),
    resp character varying(255)
);


ALTER TABLE survey.survey OWNER TO postgres;
COMMENT ON TABLE survey IS 'main description of the survey';
COMMENT ON COLUMN survey.gid IS 'unique id';
COMMENT ON COLUMN survey.name IS 'survey (short) name ';
COMMENT ON COLUMN survey.description IS 'short description of the survey';
COMMENT ON COLUMN survey.type IS 'survey type';
COMMENT ON COLUMN survey.resp IS 'name of survey responsible';

--
-- Name: survey_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_type (
    gid serial PRIMARY KEY,
    code character varying(100) UNIQUE,
    description character varying(255)
);


ALTER TABLE survey.survey_type OWNER TO postgres;
COMMENT ON TABLE survey_type IS 'list the different types of surveys which can generate or modify assset contents';
COMMENT ON COLUMN survey_type.gid IS 'unique id';
COMMENT ON COLUMN survey_type.code IS 'alfanumeric identifier of the survey type';
COMMENT ON COLUMN survey_type.description IS 'short textual description of the type';

COPY survey_type (gid, code, description) FROM stdin;
1	RRVS	Remote Rapid Visual Survey
3	OTH	Other (unspecified)
2	IDCT	Inventory Data Capture Tool
\.

CREATE INDEX idx_survey ON survey USING btree (type);

ALTER TABLE ONLY survey
    ADD CONSTRAINT fk_survey_survey_type FOREIGN KEY (type) REFERENCES survey_type(code);

------------------------------------------------------------------------
--
-- Name: asset; Type: SCHEMA; Schema: -; Owner: postgres
--
------------------------------------------------------------------------

CREATE SCHEMA asset;


ALTER SCHEMA asset OWNER TO postgres;

SET search_path = asset, pg_catalog;

--
-- Name: edit_object_view(); Type: FUNCTION; Schema: asset; Owner: postgres
--

CREATE FUNCTION edit_object_view() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
       INSERT INTO asset.object (gid, survey_gid, source, accuracy, description, the_geom) VALUES (DEFAULT, NEW.survey_gid, NEW.source, NEW.accuracy, NEW.description, NEW.the_geom);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'MAT_TYPE', NEW.mat_type);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'MAT_TECH', NEW.mat_tech);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'MAT_PROP', NEW.mat_prop);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'LLRS', NEW.llrs);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'LLRS_DUCT', NEW.llrs_duct);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value, attribute_numeric_1, attribute_numeric_2) VALUES ((SELECT max(gid) FROM asset.object), 'HEIGHT', NEW.height, NEW.height_1, NEW.height_2);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'YR_BUILT', NEW.yr_built);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'OCCUPY', NEW.occupy);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'OCCUPY_DT', NEW.occupy_dt);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'POSITION', NEW."position");
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'PLAN_SHAPE', NEW.plan_shape);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'STR_IRREG', NEW.str_irreg);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'STR_IRREG_DT', NEW.str_irreg_dt);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'STR_IRREG_TYPE', NEW.str_irreg_type);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'NONSTRCEXW', NEW.nonstrcexw);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'ROOF_SHAPE', NEW.roof_shape);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'ROOFCOVMAT', NEW.roofcovmat);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'ROOFSYSMAT', NEW.roofsysmat);	 
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'ROOFSYSTYP', NEW.roofsystyp);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'ROOF_CONN', NEW.roof_conn);    
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'FLOOR_MAT', NEW.floor_mat);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'FLOOR_TYPE', NEW.floor_type);
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'FLOOR_CONN', NEW.floor_conn);       
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'FOUNDN_SYS', NEW.foundn_sys);       
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'BUILD_TYPE', NEW.build_type);       
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value) VALUES ((SELECT max(gid) FROM asset.object), 'BUILD_SUBTYPE', NEW.build_subtype);       
       INSERT INTO asset.object_attribute (object_id, attribute_type_code, attribute_value, attribute_numeric_1, attribute_numeric_2) VALUES ((SELECT max(gid) FROM asset.object), 'VULN', NEW.vuln, NEW.vuln_1, NEW.vuln_2);       
       
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_TYPE'), 'BELIEF', 'BP', NEW.mat_type_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_TECH'), 'BELIEF', 'BP', NEW.mat_tech_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_PROP'), 'BELIEF', 'BP', NEW.mat_prop_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='LLRS'), 'BELIEF', 'BP', NEW.llrs_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='LLRS_DUCT'), 'BELIEF', 'BP', NEW.llrs_duct_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='HEIGHT'), 'BELIEF', 'BP', NEW.height_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='YR_BUILT'), 'BELIEF', 'BP', NEW.yr_built_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='OCCUPY'), 'BELIEF', 'BP', NEW.occupy_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='OCCUPY_DT'), 'BELIEF', 'BP', NEW.occupy_dt_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='POSITION'), 'BELIEF', 'BP', NEW.position_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='PLAN_SHAPE'), 'BELIEF', 'BP', NEW.plan_shape_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG'), 'BELIEF', 'BP', NEW.str_irreg_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG_DT'), 'BELIEF', 'BP', NEW.str_irreg_dt_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG_TYPE'), 'BELIEF', 'BP', NEW.str_irreg_type_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='NONSTRCEXW'), 'BELIEF', 'BP', NEW.nonstrcexw_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOF_SHAPE'), 'BELIEF', 'BP', NEW.roof_shape_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFCOVMAT'), 'BELIEF', 'BP', NEW.roofcovmat_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFSYSMAT'), 'BELIEF', 'BP', NEW.roofsysmat_bp);	 
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFSYSTYP'), 'BELIEF', 'BP', NEW.roofsystyp_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOF_CONN'), 'BELIEF', 'BP', NEW.roof_conn_bp);    
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_MAT'), 'BELIEF', 'BP', NEW.floor_mat_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_TYPE'), 'BELIEF', 'BP', NEW.floor_type_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_CONN'), 'BELIEF', 'BP', NEW.floor_conn_bp);       
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FOUNDN_SYS'), 'BELIEF', 'BP', NEW.foundn_sys_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='BUILD_TYPE'), 'BELIEF', 'BP', NEW.build_type_bp);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='BUILD_SUBTYPE'), 'BELIEF', 'BP', NEW.build_subtype_bp);  
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='VULN'), 'BELIEF', 'BP', NEW.vuln_bp);      
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value, qualifier_timestamp_1) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='YR_BUILT'), 'VALIDTIME', NEW.yr_built_vt, NEW.yr_built_vt1);

       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_TYPE'), 'SOURCE', NEW.mat_type_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_TECH'), 'SOURCE', NEW.mat_tech_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='MAT_PROP'), 'SOURCE', NEW.mat_prop_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='LLRS'), 'SOURCE', NEW.llrs_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='LLRS_DUCT'), 'SOURCE', NEW.llrs_duct_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='HEIGHT'), 'SOURCE', NEW.height_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='YR_BUILT'), 'SOURCE', NEW.yr_built_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='OCCUPY'), 'SOURCE', NEW.occupy_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='OCCUPY_DT'), 'SOURCE', NEW.occupy_dt_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='POSITION'), 'SOURCE', NEW.position_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='PLAN_SHAPE'), 'SOURCE', NEW.plan_shape_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG'), 'SOURCE', NEW.str_irreg_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG_DT'), 'SOURCE', NEW.str_irreg_dt_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='STR_IRREG_TYPE'), 'SOURCE', NEW.str_irreg_type_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='NONSTRCEXW'), 'SOURCE', NEW.nonstrcexw_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOF_SHAPE'), 'SOURCE', NEW.roof_shape_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFCOVMAT'), 'SOURCE', NEW.roofcovmat_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFSYSMAT'), 'SOURCE', NEW.roofsysmat_src);	 
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOFSYSTYP'), 'SOURCE', NEW.roofsystyp_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='ROOF_CONN'), 'SOURCE', NEW.roof_conn_src);    
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_MAT'), 'SOURCE', NEW.floor_mat_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_TYPE'), 'SOURCE', NEW.floor_type_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FLOOR_CONN'), 'SOURCE', NEW.floor_conn_src);       
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='FOUNDN_SYS'), 'SOURCE', NEW.foundn_sys_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='BUILD_TYPE'), 'SOURCE', NEW.build_type_src);
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='BUILD_SUBTYPE'), 'SOURCE', NEW.build_subtype_src);  
       INSERT INTO asset.object_attribute_qualifier (attribute_id, qualifier_type_code, qualifier_value) VALUES ((SELECT max(gid) FROM asset.object_attribute WHERE attribute_type_code='VULN'), 'SOURCE', NEW.vuln_src);
 
       RETURN NEW;

      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE asset.object SET survey_gid=NEW.survey_gid, source=NEW.source, accuracy=NEW.accuracy, description=NEW.description, the_geom=NEW.the_geom 
        WHERE gid=OLD.gid;
       --TODO: UPDATE ONLY IF DETAIL IS AVAILABLE, ELSE INSERT THE DETAIL
       UPDATE asset.object_attribute SET attribute_value=NEW.mat_type WHERE object_id=OLD.gid AND attribute_type_code='MAT_TYPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.mat_tech WHERE object_id=OLD.gid AND attribute_type_code='MAT_TECH';
       UPDATE asset.object_attribute SET attribute_value=NEW.mat_prop WHERE object_id=OLD.gid AND attribute_type_code='MAT_PROP';
       UPDATE asset.object_attribute SET attribute_value=NEW.llrs WHERE object_id=OLD.gid AND attribute_type_code='LLRS';	
       UPDATE asset.object_attribute SET attribute_value=NEW.llrs_duct WHERE object_id=OLD.gid AND attribute_type_code='LLRS_DUCT';
       UPDATE asset.object_attribute SET attribute_value=NEW.height WHERE object_id=OLD.gid AND attribute_type_code='HEIGHT';
       UPDATE asset.object_attribute SET attribute_value=NEW.yr_built WHERE object_id=OLD.gid AND attribute_type_code='YR_BUILT';
       UPDATE asset.object_attribute SET attribute_value=NEW.occupy WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY';
       UPDATE asset.object_attribute SET attribute_value=NEW.occupy_dt WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY_DT';
       UPDATE asset.object_attribute SET attribute_value=NEW."position" WHERE object_id=OLD.gid AND attribute_type_code='POSITION';	
       UPDATE asset.object_attribute SET attribute_value=NEW.plan_shape WHERE object_id=OLD.gid AND attribute_type_code='PLAN_SHAPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.str_irreg WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG';
       UPDATE asset.object_attribute SET attribute_value=NEW.str_irreg_dt WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_DT';
       UPDATE asset.object_attribute SET attribute_value=NEW.str_irreg_type WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_TYPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.nonstrcexw WHERE object_id=OLD.gid AND attribute_type_code='NONSTRCEXW';
       UPDATE asset.object_attribute SET attribute_value=NEW.roof_shape WHERE object_id=OLD.gid AND attribute_type_code='ROOF_SHAPE';	
       UPDATE asset.object_attribute SET attribute_value=NEW.roofcovmat WHERE object_id=OLD.gid AND attribute_type_code='ROOFCOVMAT';
       UPDATE asset.object_attribute SET attribute_value=NEW.roofsystyp WHERE object_id=OLD.gid AND attribute_type_code='ROOFSYSTYP';
       UPDATE asset.object_attribute SET attribute_value=NEW.roof_conn WHERE object_id=OLD.gid AND attribute_type_code='ROOF_CONN';
       UPDATE asset.object_attribute SET attribute_value=NEW.floor_mat WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_MAT';
       UPDATE asset.object_attribute SET attribute_value=NEW.floor_type WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_TYPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.floor_conn WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_CONN';
       UPDATE asset.object_attribute SET attribute_value=NEW.foundn_sys WHERE object_id=OLD.gid AND attribute_type_code='FOUNDN_SYS';
       UPDATE asset.object_attribute SET attribute_value=NEW.build_type WHERE object_id=OLD.gid AND attribute_type_code='BUILD_TYPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.build_subtype WHERE object_id=OLD.gid AND attribute_type_code='BUILD_SUBTYPE';
       UPDATE asset.object_attribute SET attribute_value=NEW.vuln WHERE object_id=OLD.gid AND attribute_type_code='VULN';
       UPDATE asset.object_attribute SET attribute_numeric_1=NEW.vuln_1 WHERE object_id=OLD.gid AND attribute_type_code='VULN';
       UPDATE asset.object_attribute SET attribute_numeric_2=NEW.vuln_2 WHERE object_id=OLD.gid AND attribute_type_code='VULN';
       UPDATE asset.object_attribute SET attribute_numeric_1=NEW.height_1 WHERE object_id=OLD.gid AND attribute_type_code='HEIGHT';
       UPDATE asset.object_attribute SET attribute_numeric_2=NEW.height_2 WHERE object_id=OLD.gid AND attribute_type_code='HEIGHT';

       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.mat_type_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_TYPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.mat_tech_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_TECH') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.mat_prop_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_PROP') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.llrs_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='LLRS') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.llrs_duct_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='LLRS_DUCT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.height_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='HEIGHT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.yr_built_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='YR_BUILT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.occupy_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.occupy_dt_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY_DT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.position_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='POSITION') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.plan_shape_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='PLAN_SHAPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.str_irreg_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.str_irreg_dt_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_DT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.str_irreg_type_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_TYPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.nonstrcexw_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='NONSTRCEXW') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.roof_shape_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOF_SHAPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.roofcovmat_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFCOVMAT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.roofsysmat_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFSYSMAT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.roofsystyp_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFSYSTYP') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.roof_conn_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOF_CONN') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.floor_mat_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_MAT') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.floor_type_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_TYPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.floor_conn_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_CONN') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.foundn_sys_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FOUNDN_SYS') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.build_type_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='BUILD_TYPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.build_subtype_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='BUILD_SUBTYPE') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_numeric_1=NEW.vuln_bp WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='VULN') AND qualifier_type_code='BELIEF';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.yr_built_vt WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='YR_BUILT') AND qualifier_type_code='VALIDTIME';
       UPDATE asset.object_attribute_qualifier SET qualifier_timestamp_1=NEW.yr_built_vt1 WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='YR_BUILT') AND qualifier_type_code='VALIDTIME'; 
       
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.mat_type_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_TYPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.mat_tech_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_TECH') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.mat_prop_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='MAT_PROP') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.llrs_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='LLRS') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.llrs_duct_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='LLRS_DUCT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.height_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='HEIGHT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.yr_built_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='YR_BUILT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.occupy_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.occupy_dt_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='OCCUPY_DT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.position_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='POSITION') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.plan_shape_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='PLAN_SHAPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.str_irreg_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.str_irreg_dt_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_DT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.str_irreg_type_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='STR_IRREG_TYPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.nonstrcexw_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='NONSTRCEXW') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.roof_shape_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOF_SHAPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.roofcovmat_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFCOVMAT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.roofsysmat_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFSYSMAT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.roofsystyp_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOFSYSTYP') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.roof_conn_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='ROOF_CONN') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.floor_mat_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_MAT') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.floor_type_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_TYPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.floor_conn_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FLOOR_CONN') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.foundn_sys_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='FOUNDN_SYS') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.build_type_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='BUILD_TYPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.build_subtype_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='BUILD_SUBTYPE') AND qualifier_type_code='SOURCE';
       UPDATE asset.object_attribute_qualifier SET qualifier_value=NEW.vuln_src WHERE attribute_id=(SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid AND attribute_type_code='VULN') AND qualifier_type_code='SOURCE';

       RETURN NEW;

      ELSIF TG_OP = 'DELETE' THEN
       DELETE FROM asset.object_attribute_qualifier WHERE attribute_id IN (SELECT gid FROM asset.object_attribute WHERE object_id=OLD.gid);
       DELETE FROM asset.object_attribute WHERE object_id=OLD.gid;
       DELETE FROM asset.object WHERE gid=OLD.gid;
       --workaround to include row information after delete (because it is not possible to define a AFTER FOR EACH ROW trigger on a view)
       IF EXISTS (SELECT event_object_schema, trigger_name FROM information_schema.triggers WHERE event_object_schema = 'asset' AND trigger_name = 'zhistory_trigger_row') THEN
	       INSERT INTO history.logged_actions VALUES(
	        NEXTVAL('history.logged_actions_gid_seq'),    -- gid
		TG_TABLE_SCHEMA::text,                        -- schema_name
		TG_TABLE_NAME::text,                          -- table_name
		TG_RELID,                                     -- relation OID for much quicker searches
		txid_current(),                               -- transaction_id
		session_user::text,                           -- transaction_user
		current_timestamp,                            -- transaction_time
		NULL,                              	      -- top-level query or queries (if multistatement) from client
		'D',					      -- transaction_type
		hstore(OLD.*), NULL, NULL);                   -- old_record, new_record, changed_fields
	END IF;
       RETURN NULL;
      END IF;
      RETURN NEW;
END;
$$;


ALTER FUNCTION asset.edit_object_view() OWNER TO postgres;

COMMENT ON FUNCTION edit_object_view() IS '
This function makes the object view (adjusted for the rrvs) editable and forwards the edits to the underlying tables.
';


SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: object; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object (
    gid serial PRIMARY KEY,
    survey_gid integer,
    description character varying(254),
    source text,
    accuracy numeric,
    the_geom public.geometry
);


ALTER TABLE asset.object OWNER TO postgres;
COMMENT ON TABLE object IS 'The object table (e.g. per building scale). Contains basic information about the object.';
COMMENT ON COLUMN object.gid IS 'Unique object identifier';
COMMENT ON COLUMN object.survey_gid IS 'Identifier for the survey';
COMMENT ON COLUMN object.description IS 'Textual description of the object';
COMMENT ON COLUMN object.source IS 'Source of the object (geometry)';
COMMENT ON COLUMN object.accuracy IS 'Accuracy of the object (geometry)';
COMMENT ON COLUMN object.the_geom IS 'Spatial reference and geometry information';

--
-- Name: object_attribute; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object_attribute (
    gid serial PRIMARY KEY,
    object_id integer,
    attribute_type_code character varying(254),
    attribute_value character varying(254),
    attribute_numeric_1 numeric,
    attribute_numeric_2 numeric,
    attribute_text_1 character varying(254)
);


ALTER TABLE asset.object_attribute OWNER TO postgres;
COMMENT ON TABLE object_attribute IS 'The object object detail table. Contains information about the object details.';
COMMENT ON COLUMN object_attribute.gid IS 'Unique object detail identifier';
COMMENT ON COLUMN object_attribute.object_id IS 'Object identifier';
COMMENT ON COLUMN object_attribute.attribute_type_code IS 'Code of the taxonomy attribute type';
COMMENT ON COLUMN object_attribute.attribute_value IS 'Value of the taxonomy attribute type (from look up table in taxonomy scheme)';
COMMENT ON COLUMN object_attribute.attribute_numeric_1 IS 'Value of the taxonomy attribute type (numeric)';
COMMENT ON COLUMN object_attribute.attribute_numeric_2 IS 'Value of the taxonomy attribute type (numeric)';
COMMENT ON COLUMN object_attribute.attribute_text_1 IS 'Value of the taxonomy attribute type (textual)';

ALTER TABLE ONLY object_attribute
    ADD CONSTRAINT fk_object_gid FOREIGN KEY (object_id) REFERENCES object(gid);

--
-- Name: object_attribute_qualifier; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object_attribute_qualifier (
    gid serial PRIMARY KEY,
    attribute_id integer,
    qualifier_type_code character varying(254),
    qualifier_value character varying(254),
    qualifier_numeric_1 numeric,
    qualifier_text_1 character varying(254),
    qualifier_timestamp_1 timestamp with time zone
);


ALTER TABLE asset.object_attribute_qualifier OWNER TO postgres;
COMMENT ON TABLE object_attribute_qualifier IS 'The object object attribute qualifier table. Contains information about the object qualifiers.';
COMMENT ON COLUMN object_attribute_qualifier.gid IS 'Unique object attribute qualifier identifier';
COMMENT ON COLUMN object_attribute_qualifier.attribute_id IS 'Object atttribute identifier';
COMMENT ON COLUMN object_attribute_qualifier.qualifier_type_code IS 'Code of the taxonomy qualifier type';
COMMENT ON COLUMN object_attribute_qualifier.qualifier_value IS 'Value of the taxonomy qualifier type (from look up table in taxonomy scheme)';
COMMENT ON COLUMN object_attribute_qualifier.qualifier_numeric_1 IS 'Value of the taxonomy qualifier type (numeric)';
COMMENT ON COLUMN object_attribute_qualifier.qualifier_text_1 IS 'Value of the taxonomy qualifier type (textual)';
COMMENT ON COLUMN object_attribute_qualifier.qualifier_timestamp_1 IS 'Value of the taxonomy qualifier type (timestamp)';

ALTER TABLE ONLY object_attribute_qualifier
    ADD CONSTRAINT fk_attribute_gid FOREIGN KEY (attribute_id) REFERENCES object_attribute(gid);

--
-- Name: v_object_data; Type: VIEW; Schema: asset; Owner: postgres
--

CREATE VIEW v_object_data AS
    SELECT a.gid, a.survey_gid, a.description, a.source, a.accuracy, a.the_geom, b.object_id, b.mat_type, b.mat_tech, b.mat_prop, b.llrs, b.llrs_duct, b.height, b.yr_built, b.occupy, b.occupy_dt, b."position", b.plan_shape, b.str_irreg, b.str_irreg_dt, b.str_irreg_type, b.nonstrcexw, b.roof_shape, b.roofcovmat, b.roofsysmat, b.roofsystyp, b.roof_conn, b.floor_mat, b.floor_type, b.floor_conn, b.foundn_sys, b.build_type, b.build_subtype, b.vuln, e.vuln_1, e.vuln_2, c.height_1, c.height_2, d.yr_built_vt, d.yr_built_vt1 FROM ((((object a JOIN (SELECT ct.object_id, ct.mat_type, ct.mat_tech, ct.mat_prop, ct.llrs, ct.llrs_duct, ct.height, ct.yr_built, ct.occupy, ct.occupy_dt, ct."position", ct.plan_shape, ct.str_irreg, ct.str_irreg_dt, ct.str_irreg_type, ct.nonstrcexw, ct.roof_shape, ct.roofcovmat, ct.roofsysmat, ct.roofsystyp, ct.roof_conn, ct.floor_mat, ct.floor_type, ct.floor_conn, ct.foundn_sys, ct.build_type, ct.build_subtype, ct.vuln FROM public.crosstab('SELECT object_id, attribute_type_code, attribute_value FROM asset.object_attribute order by object_id'::text, 'select code from taxonomy.dic_attribute_type order by gid'::text) ct(object_id integer, mat_type character varying, mat_tech character varying, mat_prop character varying, llrs character varying, llrs_duct character varying, height character varying, yr_built character varying, occupy character varying, occupy_dt character varying, "position" character varying, plan_shape character varying, str_irreg character varying, str_irreg_dt character varying, str_irreg_type character varying, nonstrcexw character varying, roof_shape character varying, roofcovmat character varying, roofsysmat character varying, roofsystyp character varying, roof_conn character varying, floor_mat character varying, floor_type character varying, floor_conn character varying, foundn_sys character varying, build_type character varying, build_subtype character varying, vuln character varying)) b ON ((a.gid = b.object_id))) LEFT JOIN (SELECT object_attribute.object_id, object_attribute.attribute_numeric_1 AS height_1, object_attribute.attribute_numeric_2 AS height_2 FROM object_attribute object_attribute WHERE ((object_attribute.attribute_type_code)::text = 'HEIGHT'::text)) c ON ((a.gid = c.object_id))) LEFT JOIN (SELECT sub.object_id, sub.qualifier_value AS yr_built_vt, sub.qualifier_timestamp_1 AS yr_built_vt1 FROM (SELECT a.gid, a.object_id, a.attribute_type_code, a.attribute_value, a.attribute_numeric_1, a.attribute_numeric_2, a.attribute_text_1, b.gid, b.attribute_id, b.qualifier_type_code, b.qualifier_value, b.qualifier_numeric_1, b.qualifier_text_1, b.qualifier_timestamp_1 FROM (object_attribute a JOIN object_attribute_qualifier b ON ((a.gid = b.attribute_id)))) sub WHERE (((sub.attribute_type_code)::text = 'YR_BUILT'::text) AND ((sub.qualifier_type_code)::text = 'VALIDTIME'::text)) ORDER BY sub.object_id) d ON ((a.gid = d.object_id))) LEFT JOIN (SELECT object_attribute.object_id, object_attribute.attribute_numeric_1 AS vuln_1, object_attribute.attribute_numeric_2 AS vuln_2 FROM object_attribute object_attribute WHERE ((object_attribute.attribute_type_code)::text = 'VULN'::text)) e ON ((a.gid = e.object_id))) ORDER BY a.gid;


ALTER TABLE asset.v_object_data OWNER TO postgres;

--
-- Name: v_object_metadata; Type: VIEW; Schema: asset; Owner: postgres
--

CREATE VIEW v_object_metadata AS
    SELECT 'THE_GEOM'::character varying AS attribute_type, 'Object geometry'::character varying AS description, ARRAY(SELECT DISTINCT object.source FROM object object) AS source, 'BP'::character varying AS belief_type, avg(object.accuracy) AS avg_belief FROM object object UNION SELECT b.attribute_type_code AS attribute_type, c.description, ARRAY(SELECT DISTINCT object_attribute_qualifier.qualifier_value FROM object_attribute_qualifier object_attribute_qualifier WHERE ((object_attribute_qualifier.qualifier_type_code)::text = 'SOURCE'::text)) AS source, (SELECT DISTINCT object_attribute_qualifier.qualifier_value FROM object_attribute_qualifier object_attribute_qualifier WHERE ((object_attribute_qualifier.qualifier_type_code)::text = 'BELIEF'::text)) AS belief_type, avg(a.qualifier_numeric_1) AS avg_belief FROM ((object_attribute_qualifier a JOIN object_attribute b ON ((a.attribute_id = b.gid))) JOIN taxonomy.dic_attribute_type c ON (((b.attribute_type_code)::text = (c.code)::text))) GROUP BY b.attribute_type_code, c.description, (SELECT DISTINCT object_attribute_qualifier.qualifier_value FROM object_attribute_qualifier object_attribute_qualifier WHERE ((object_attribute_qualifier.qualifier_type_code)::text = 'BELIEF'::text)), ARRAY(SELECT DISTINCT object_attribute_qualifier.qualifier_value FROM object_attribute_qualifier object_attribute_qualifier WHERE ((object_attribute_qualifier.qualifier_type_code)::text = 'SOURCE'::text)) ORDER BY 1;


ALTER TABLE asset.v_object_metadata OWNER TO postgres;

--
-- Name: ve_object; Type: VIEW; Schema: asset; Owner: postgres
--

CREATE VIEW ve_object AS
    SELECT a.gid, a.survey_gid, a.description, a.source, a.accuracy, a.the_geom, b.object_id, b.mat_type, b.mat_tech, b.mat_prop, b.llrs, b.llrs_duct, b.height, b.yr_built, b.occupy, b.occupy_dt, b."position", b.plan_shape, b.str_irreg, b.str_irreg_dt, b.str_irreg_type, b.nonstrcexw, b.roof_shape, b.roofcovmat, b.roofsysmat, b.roofsystyp, b.roof_conn, b.floor_mat, b.floor_type, b.floor_conn, b.foundn_sys, b.build_type, b.build_subtype, b.vuln, f.vuln_1, f.vuln_2, c.height_1, c.height_2, d.object_id1, d.mat_type_bp, d.mat_tech_bp, d.mat_prop_bp, d.llrs_bp, d.llrs_duct_bp, d.height_bp, d.yr_built_bp, d.occupy_bp, d.occupy_dt_bp, d.position_bp, d.plan_shape_bp, d.str_irreg_bp, d.str_irreg_dt_bp, d.str_irreg_type_bp, d.nonstrcexw_bp, d.roof_shape_bp, d.roofcovmat_bp, d.roofsysmat_bp, d.roofsystyp_bp, d.roof_conn_bp, d.floor_mat_bp, d.floor_type_bp, d.floor_conn_bp, d.foundn_sys_bp, d.build_type_bp, d.build_subtype_bp, d.vuln_bp, e.yr_built_vt, e.yr_built_vt1, g.object_id2, g.mat_type_src, g.mat_tech_src, g.mat_prop_src, g.llrs_src, g.llrs_duct_src, g.height_src, g.yr_built_src, g.occupy_src, g.occupy_dt_src, g.position_src, g.plan_shape_src, g.str_irreg_src, g.str_irreg_dt_src, g.str_irreg_type_src, g.nonstrcexw_src, g.roof_shape_src, g.roofcovmat_src, g.roofsysmat_src, g.roofsystyp_src, g.roof_conn_src, g.floor_mat_src, g.floor_type_src, g.floor_conn_src, g.foundn_sys_src, g.build_type_src, g.build_subtype_src, g.vuln_src FROM ((((((object a JOIN (SELECT ct.object_id, ct.mat_type, ct.mat_tech, ct.mat_prop, ct.llrs, ct.llrs_duct, ct.height, ct.yr_built, ct.occupy, ct.occupy_dt, ct."position", ct.plan_shape, ct.str_irreg, ct.str_irreg_dt, ct.str_irreg_type, ct.nonstrcexw, ct.roof_shape, ct.roofcovmat, ct.roofsysmat, ct.roofsystyp, ct.roof_conn, ct.floor_mat, ct.floor_type, ct.floor_conn, ct.foundn_sys, ct.build_type, ct.build_subtype, ct.vuln FROM public.crosstab('SELECT object_id, attribute_type_code, attribute_value FROM asset.object_attribute order by object_id'::text, 'select code from taxonomy.dic_attribute_type order by gid'::text) ct(object_id integer, mat_type character varying, mat_tech character varying, mat_prop character varying, llrs character varying, llrs_duct character varying, height character varying, yr_built character varying, occupy character varying, occupy_dt character varying, "position" character varying, plan_shape character varying, str_irreg character varying, str_irreg_dt character varying, str_irreg_type character varying, nonstrcexw character varying, roof_shape character varying, roofcovmat character varying, roofsysmat character varying, roofsystyp character varying, roof_conn character varying, floor_mat character varying, floor_type character varying, floor_conn character varying, foundn_sys character varying, build_type character varying, build_subtype character varying, vuln character varying)) b ON ((a.gid = b.object_id))) LEFT JOIN (SELECT object_attribute.object_id, object_attribute.attribute_numeric_1 AS height_1, object_attribute.attribute_numeric_2 AS height_2 FROM object_attribute object_attribute WHERE ((object_attribute.attribute_type_code)::text = 'HEIGHT'::text)) c ON ((a.gid = c.object_id))) JOIN (SELECT a.object_id1, a.mat_type_bp, a.mat_tech_bp, a.mat_prop_bp, a.llrs_bp, a.llrs_duct_bp, a.height_bp, a.yr_built_bp, a.occupy_bp, a.occupy_dt_bp, a.position_bp, a.plan_shape_bp, a.str_irreg_bp, a.str_irreg_dt_bp, a.str_irreg_type_bp, a.nonstrcexw_bp, a.roof_shape_bp, a.roofcovmat_bp, a.roofsysmat_bp, a.roofsystyp_bp, a.roof_conn_bp, a.floor_mat_bp, a.floor_type_bp, a.floor_conn_bp, a.foundn_sys_bp, a.build_type_bp, a.build_subtype_bp, a.vuln_bp FROM public.crosstab('SELECT object_id, attribute_type_code, qualifier_numeric_1 FROM (SELECT * FROM asset.object_attribute as a
				JOIN (SELECT * FROM asset.object_attribute_qualifier WHERE qualifier_type_code=''BELIEF'') as b
				ON (a.gid = b.attribute_id)) sub ORDER BY object_id'::text, 'SELECT code from taxonomy.dic_attribute_type order by gid'::text) a(object_id1 integer, mat_type_bp integer, mat_tech_bp integer, mat_prop_bp integer, llrs_bp integer, llrs_duct_bp integer, height_bp integer, yr_built_bp integer, occupy_bp integer, occupy_dt_bp integer, position_bp integer, plan_shape_bp integer, str_irreg_bp integer, str_irreg_dt_bp integer, str_irreg_type_bp integer, nonstrcexw_bp integer, roof_shape_bp integer, roofcovmat_bp integer, roofsysmat_bp integer, roofsystyp_bp integer, roof_conn_bp integer, floor_mat_bp integer, floor_type_bp integer, floor_conn_bp integer, foundn_sys_bp integer, build_type_bp integer, build_subtype_bp integer, vuln_bp integer)) d ON ((a.gid = d.object_id1))) LEFT JOIN (SELECT sub.object_id, sub.qualifier_value AS yr_built_vt, sub.qualifier_timestamp_1 AS yr_built_vt1 FROM (SELECT a.gid, a.object_id, a.attribute_type_code, a.attribute_value, a.attribute_numeric_1, a.attribute_numeric_2, a.attribute_text_1, b.gid, b.attribute_id, b.qualifier_type_code, b.qualifier_value, b.qualifier_numeric_1, b.qualifier_text_1, b.qualifier_timestamp_1 FROM (object_attribute a JOIN object_attribute_qualifier b ON ((a.gid = b.attribute_id)))) sub WHERE (((sub.attribute_type_code)::text = 'YR_BUILT'::text) AND ((sub.qualifier_type_code)::text = 'VALIDTIME'::text)) ORDER BY sub.object_id) e ON ((a.gid = e.object_id))) LEFT JOIN (SELECT object_attribute.object_id, object_attribute.attribute_numeric_1 AS vuln_1, object_attribute.attribute_numeric_2 AS vuln_2 FROM object_attribute object_attribute WHERE ((object_attribute.attribute_type_code)::text = 'VULN'::text)) f ON ((a.gid = f.object_id))) JOIN (SELECT ct.object_id2, ct.mat_type_src, ct.mat_tech_src, ct.mat_prop_src, ct.llrs_src, ct.llrs_duct_src, ct.height_src, ct.yr_built_src, ct.occupy_src, ct.occupy_dt_src, ct.position_src, ct.plan_shape_src, ct.str_irreg_src, ct.str_irreg_dt_src, ct.str_irreg_type_src, ct.nonstrcexw_src, ct.roof_shape_src, ct.roofcovmat_src, ct.roofsysmat_src, ct.roofsystyp_src, ct.roof_conn_src, ct.floor_mat_src, ct.floor_type_src, ct.floor_conn_src, ct.foundn_sys_src, ct.build_type_src, ct.build_subtype_src, ct.vuln_src FROM public.crosstab('SELECT object_id, attribute_type_code, qualifier_value FROM (SELECT * FROM asset.object_attribute as a
				JOIN (SELECT * FROM asset.object_attribute_qualifier WHERE qualifier_type_code=''SOURCE'') as b
				ON (a.gid = b.attribute_id)) sub ORDER BY object_id'::text, 'SELECT code from taxonomy.dic_attribute_type order by gid'::text) ct(object_id2 integer, mat_type_src character varying, mat_tech_src character varying, mat_prop_src character varying, llrs_src character varying, llrs_duct_src character varying, height_src character varying, yr_built_src character varying, occupy_src character varying, occupy_dt_src character varying, position_src character varying, plan_shape_src character varying, str_irreg_src character varying, str_irreg_dt_src character varying, str_irreg_type_src character varying, nonstrcexw_src character varying, roof_shape_src character varying, roofcovmat_src character varying, roofsysmat_src character varying, roofsystyp_src character varying, roof_conn_src character varying, floor_mat_src character varying, floor_type_src character varying, floor_conn_src character varying, foundn_sys_src character varying, build_type_src character varying, build_subtype_src character varying, vuln_src character varying)) g ON ((a.gid = g.object_id2))) ORDER BY a.gid;


ALTER TABLE asset.ve_object OWNER TO postgres;
ALTER TABLE ONLY ve_object ALTER COLUMN mat_type SET DEFAULT 'MAT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN mat_tech SET DEFAULT 'MATT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN mat_prop SET DEFAULT 'MATP99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN llrs SET DEFAULT 'L99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN llrs_duct SET DEFAULT 'DU99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN height SET DEFAULT 'H99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN yr_built SET DEFAULT 'Y99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN occupy SET DEFAULT 'OC99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN occupy_dt SET DEFAULT 'OCCDT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN "position" SET DEFAULT 'BP99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN plan_shape SET DEFAULT 'PLF99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg SET DEFAULT 'IR99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg_dt SET DEFAULT 'IRP99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg_type SET DEFAULT 'IRT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN nonstrcexw SET DEFAULT 'EW99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN roof_shape SET DEFAULT 'R99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN roofcovmat SET DEFAULT 'RMT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN roofsysmat SET DEFAULT 'RSM99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN roofsystyp SET DEFAULT 'RST99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN roof_conn SET DEFAULT 'RCN99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN floor_mat SET DEFAULT 'F99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN floor_type SET DEFAULT 'FT99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN floor_conn SET DEFAULT 'FWC99'::character varying;
ALTER TABLE ONLY ve_object ALTER COLUMN foundn_sys SET DEFAULT 'FOS99'::character varying;

CREATE TRIGGER object_trigger INSTEAD OF INSERT OR DELETE OR UPDATE ON ve_object FOR EACH ROW EXECUTE PROCEDURE edit_object_view();

--
-- Set sequences of primary keys to value!=1
--

SELECT pg_catalog.setval('object_attribute_gid_seq', 54000, true);
SELECT pg_catalog.setval('object_attribute_qualifier_gid_seq', 110000, true);
SELECT pg_catalog.setval('object_gid_seq', 2000, true);

--
-- Indices for shema asset 
--

CREATE INDEX idx_object ON object USING btree (survey_gid);
CREATE INDEX idx_object_attribute ON object_attribute USING btree (object_id);
CREATE INDEX idx_object_attribute_qualifier ON object_attribute_qualifier USING btree (attribute_id);
CREATE INDEX idx_object_attribute_qualifier_0 ON object_attribute_qualifier USING btree (qualifier_type_code);
CREATE INDEX idx_object_attribute_qualifier_1 ON object_attribute_qualifier USING btree (qualifier_value);
CREATE INDEX idx_object_attribute_value ON object_attribute USING btree (attribute_value);
CREATE INDEX pk_object_attribute_type_code ON object_attribute USING btree (attribute_type_code);

ALTER TABLE ONLY object
    ADD CONSTRAINT fk_object_survey FOREIGN KEY (survey_gid) REFERENCES survey.survey(gid);

------------------------------------------------------------
--
-- Name: image; Type: SCHEMA; Schema: -; Owner: postgres
--
------------------------------------------------------------

CREATE SCHEMA image;


ALTER SCHEMA image OWNER TO postgres;

SET search_path = image, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gpano_metadata; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

CREATE TABLE gpano_metadata (
    gid serial PRIMARY KEY,
    usepanoramaviewer boolean,
    capturesoftware character varying,
    stitchingsoftware character varying,
    projectiontype character varying DEFAULT 'equirectangular'::character varying NOT NULL,
    poseheadingdegrees real,
    posepitchdegrees real DEFAULT 0,
    poserolldegrees real DEFAULT 0,
    initialviewheadingdegrees integer DEFAULT 0,
    initialviewpitchdegrees integer DEFAULT 0,
    initialviewrolldegrees integer DEFAULT 0,
    initialhorizontalfovdegrees real,
    firstphotodate timestamp without time zone,
    sourcephotoscount integer,
    exposurelockused boolean,
    croppedareaimagewidthpixels integer NOT NULL,
    croppedareaimageheightpixels integer NOT NULL,
    fullpanoheightpixels integer NOT NULL,
    fullpanowidthpixels integer NOT NULL,
    croppedarealeftpixels integer NOT NULL,
    croppedareatoppixels integer NOT NULL,
    initialcameradolly real DEFAULT 0
);


ALTER TABLE image.gpano_metadata OWNER TO postgres;


COMMENT ON TABLE gpano_metadata IS ' Photosphere XMP metadata. Properties that provide information regarding the creation and rendering of photo spheres, also sometimes referred to as panoramas';
COMMENT ON COLUMN gpano_metadata.gid IS 'unique identifier';
COMMENT ON COLUMN gpano_metadata.usepanoramaviewer IS 'Whether to show this image in a photo sphere viewer rather than as a normal flat image. This may be specified based on user preferences or by the stitching software. The application displaying or ingesting the image may choose to ignore this.';
COMMENT ON COLUMN gpano_metadata.capturesoftware IS 'If capture was done using an application on a mobile device, such as an Android phone, the name of the application that was used (such as “Photo Sphere”). This should be left blank if source images were captured manually, such as by using a DSLR on a tripod.';
COMMENT ON COLUMN gpano_metadata.stitchingsoftware IS 'The software that was used to create the final photo sphere. This may sometimes be the same value as that of  GPano:CaptureSoftware.';
COMMENT ON COLUMN gpano_metadata.projectiontype IS 'Projection type used in the image file. Google products currently support the value equirectangular.';
COMMENT ON COLUMN gpano_metadata.poseheadingdegrees IS 'Compass heading, measured in degrees, for the center the image. Value must be >= 0 and < 360.';
COMMENT ON COLUMN gpano_metadata.posepitchdegrees IS 'Pitch, measured in degrees, for the center in the image. Value must be >= -90 and <= 90.';
COMMENT ON COLUMN gpano_metadata.poserolldegrees IS 'Roll, measured in degrees, of the image where level with the horizon is 0. Value must be > -180 and <= 180.';
COMMENT ON COLUMN gpano_metadata.initialviewheadingdegrees IS 'The heading angle of the initial view in degrees.';
COMMENT ON COLUMN gpano_metadata.initialviewpitchdegrees IS 'The pitch angle of the initial view in degrees.';
COMMENT ON COLUMN gpano_metadata.initialviewrolldegrees IS 'The roll angle of the initial view in degrees.';
COMMENT ON COLUMN gpano_metadata.initialhorizontalfovdegrees IS 'The initial horizontal field of view that the viewer should display (in degrees). This is similar to a zoom level.';
COMMENT ON COLUMN gpano_metadata.firstphotodate IS 'Date and time for the first image created in the photo sphere.';
COMMENT ON COLUMN gpano_metadata.sourcephotoscount IS 'Number of source images used to create the photo sphere.';
COMMENT ON COLUMN gpano_metadata.exposurelockused IS 'When individual source photographs were captured, whether or not the camera’s exposure setting was locked. ';
COMMENT ON COLUMN gpano_metadata.croppedareaimagewidthpixels IS ' Original width in pixels of the image (equal to the actual image’s width for unedited images).';
COMMENT ON COLUMN gpano_metadata.croppedareaimageheightpixels IS 'Original height in pixels of the image (equal to the actual image’s height for unedited images).';
COMMENT ON COLUMN gpano_metadata.fullpanoheightpixels IS 'Original full height from which the image was cropped. If only a partial photo sphere was captured, this specifies the height of what the full photo sphere would have been.';
COMMENT ON COLUMN gpano_metadata.croppedarealeftpixels IS 'Column where the left edge of the image was cropped from the full sized photo sphere.';
COMMENT ON COLUMN gpano_metadata.croppedareatoppixels IS 'Row where the top edge of the image was cropped from the full sized photo sphere.';
COMMENT ON COLUMN gpano_metadata.initialcameradolly IS 'This optional parameter moves the virtual camera position along the line of sight, away from the center of the photo sphere. A rear surface position is represented by the value -1.0, while a front surface position is represented by 1.0. For normal viewing, this parameter should be set to 0.';
COMMENT ON COLUMN gpano_metadata.fullpanowidthpixels IS 'Original full width from which the image was cropped. If only a partial photo sphere was captured, this specifies the width of what the full photo sphere would have been.';

--
-- Name: gps; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

CREATE TABLE gps (
    gid serial PRIMARY KEY,
    altitude real,
    azimuth real,
    abspeed real,
    the_geom public.geometry,
    lat real,
    lon real
);


ALTER TABLE image.gps OWNER TO postgres;

COMMENT ON TABLE gps IS 'basic information about position, derived from GPS measurements (can be interpolated)';
COMMENT ON COLUMN gps.altitude IS 'altitude in meters (an be interpolated)';
COMMENT ON COLUMN gps.azimuth IS 'direction of motion, in degrees, clockwise  from the north';
COMMENT ON COLUMN gps.abspeed IS 'absolute speed at measurement time, in km/h (can be interpolated)';
COMMENT ON COLUMN gps.lat IS 'latitude (can be interpolated)';
COMMENT ON COLUMN gps.lon IS 'longitude, in degrees WGS84 ';

--
-- Name: image_type; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

CREATE TABLE image_type (
    gid serial PRIMARY KEY,
    code character varying(50) NOT NULL UNIQUE,
    description character varying(255)
);


ALTER TABLE image.image_type OWNER TO postgres;

COMMENT ON TABLE image_type IS 'possible types of images';
COMMENT ON COLUMN image_type.code IS 'alfanumeric descriptor of image type';
COMMENT ON COLUMN image_type.description IS 'short text descriptino of the image type';

INSERT INTO image.image_type (gid, code, description) VALUES (1,'pano','panoramic or omnidirectional image');
INSERT INTO image.image_type (gid, code, description) VALUES (2,'pict','generic simple picture');

-- 
-- Name: img; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

CREATE TABLE img (
    gid serial PRIMARY KEY,
    source text,
    gps integer,
    survey integer,
    "timestamp" timestamp without time zone,
    filename character varying(100),
    type character varying,
    repository character varying(255),
    frame_id integer,
    gpano integer,
    width integer,
    height integer
);


ALTER TABLE image.img OWNER TO postgres;

COMMENT ON TABLE img IS 'image descriptor';
COMMENT ON COLUMN img.gps IS 'info from GPS ';
COMMENT ON COLUMN img.survey IS 'code of the survey that generated the images';
COMMENT ON COLUMN img."timestamp" IS 'creation of the image, in Universal Coordinated Time (UTC)';
COMMENT ON COLUMN img.filename IS 'name of the physical file of the image, if existing, with extension';
COMMENT ON COLUMN img.type IS 'type of image';
COMMENT ON COLUMN img.repository IS 'physical path to the repository hosting the image file, if existing ';
COMMENT ON COLUMN img.frame_id IS 'id of the frame in an omnidirectional PGR sequence';
COMMENT ON COLUMN img.gpano IS 'gpano metadata';
COMMENT ON COLUMN img.width IS 'number of columns';
COMMENT ON COLUMN img.height IS 'number of rows';

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_gpano_metadata FOREIGN KEY (gpano) REFERENCES gpano_metadata(gid);

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_gps FOREIGN KEY (gps) REFERENCES gps(gid);

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_image_type FOREIGN KEY (type) REFERENCES image_type(code);

--
-- Indices for schema image: 
--

CREATE INDEX idx_img ON img USING btree (gps);
CREATE INDEX idx_img_0 ON img USING btree (survey);
CREATE INDEX idx_img_1 ON img USING btree (type);
CREATE INDEX idx_img_2 ON img USING btree (gpano);

------------------------------------------------------------
--
-- Name: history; Type: SCHEMA; Schema: -; Owner: postgres
--
------------------------------------------------------------

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
    gid bigserial PRIMARY KEY,
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

COMMENT ON TABLE logged_actions IS 'History of transactions on activated tables, from history.if_modified_func().';
COMMENT ON COLUMN logged_actions.gid IS 'Unique log identifier';
COMMENT ON COLUMN logged_actions.schema_name IS 'Textual reference to the database schema which contains the modified table';
COMMENT ON COLUMN logged_actions.table_name IS 'Name of the modified table';
COMMENT ON COLUMN logged_actions.table_id IS 'OID of the modified table';
COMMENT ON COLUMN logged_actions.transaction_id IS 'Identifier of the transaction (may differ from gid when more than one row is affected by a transaction query)';
COMMENT ON COLUMN logged_actions.transaction_user IS 'Session user name who caused the transaction';
COMMENT ON COLUMN logged_actions.transaction_time IS 'Timestamp when transaction was started (current_timestamp)';
COMMENT ON COLUMN logged_actions.transaction_query IS 'Transaction query';
COMMENT ON COLUMN logged_actions.transaction_type IS 'Transaction type (I = insert, D = delete, U = update, T = truncate)';
COMMENT ON COLUMN logged_actions.old_record IS 'The old record before the modification containing all the values as hstore (for DELETE and UPDATE statements)';
COMMENT ON COLUMN logged_actions.new_record IS 'The new record after the modification containing all the values as hstore (for INSERT and UPDATE statements)';
COMMENT ON COLUMN logged_actions.changed_fields IS 'The modified fields only, including the new values, stored as hstore';

--
-- Indices schema history: 
--

CREATE INDEX logged_changes_action_idx ON logged_actions USING btree (transaction_type);
CREATE INDEX logged_changes_table_id_idx ON logged_actions USING btree (table_id);
