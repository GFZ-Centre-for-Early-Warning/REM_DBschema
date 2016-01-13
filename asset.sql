--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: asset; Type: SCHEMA; Schema: -; Owner: postgres
--

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

--
-- Name: FUNCTION edit_object_view(); Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON FUNCTION edit_object_view() IS '
This function makes the object view (adjusted for the rrvs) editable and forwards the edits to the underlying tables.
';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: object; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object (
    gid integer NOT NULL,
    survey_gid integer,
    description character varying(254),
    source text,
    accuracy numeric,
    the_geom public.geometry
);


ALTER TABLE asset.object OWNER TO postgres;

--
-- Name: TABLE object; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON TABLE object IS 'The object table (e.g. per building scale). Contains basic information about the object.';


--
-- Name: COLUMN object.gid; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.gid IS 'Unique object identifier';


--
-- Name: COLUMN object.survey_gid; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.survey_gid IS 'Identifier for the survey';


--
-- Name: COLUMN object.description; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.description IS 'Textual description of the object';


--
-- Name: COLUMN object.source; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.source IS 'Source of the object (geometry)';


--
-- Name: COLUMN object.accuracy; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.accuracy IS 'Accuracy of the object (geometry)';


--
-- Name: COLUMN object.the_geom; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object.the_geom IS 'Spatial reference and geometry information';


--
-- Name: object_attribute; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object_attribute (
    gid integer NOT NULL,
    object_id integer,
    attribute_type_code character varying(254),
    attribute_value character varying(254),
    attribute_numeric_1 numeric,
    attribute_numeric_2 numeric,
    attribute_text_1 character varying(254)
);


ALTER TABLE asset.object_attribute OWNER TO postgres;

--
-- Name: TABLE object_attribute; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON TABLE object_attribute IS 'The object object detail table. Contains information about the object details.';


--
-- Name: COLUMN object_attribute.gid; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.gid IS 'Unique object detail identifier';


--
-- Name: COLUMN object_attribute.object_id; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.object_id IS 'Object identifier';


--
-- Name: COLUMN object_attribute.attribute_type_code; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.attribute_type_code IS 'Code of the taxonomy attribute type';


--
-- Name: COLUMN object_attribute.attribute_value; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.attribute_value IS 'Value of the taxonomy attribute type (from look up table in taxonomy scheme)';


--
-- Name: COLUMN object_attribute.attribute_numeric_1; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.attribute_numeric_1 IS 'Value of the taxonomy attribute type (numeric)';


--
-- Name: COLUMN object_attribute.attribute_numeric_2; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.attribute_numeric_2 IS 'Value of the taxonomy attribute type (numeric)';


--
-- Name: COLUMN object_attribute.attribute_text_1; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute.attribute_text_1 IS 'Value of the taxonomy attribute type (textual)';


--
-- Name: object_attribute_gid_seq; Type: SEQUENCE; Schema: asset; Owner: postgres
--

CREATE SEQUENCE object_attribute_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE asset.object_attribute_gid_seq OWNER TO postgres;

--
-- Name: object_attribute_gid_seq; Type: SEQUENCE OWNED BY; Schema: asset; Owner: postgres
--

ALTER SEQUENCE object_attribute_gid_seq OWNED BY object_attribute.gid;


--
-- Name: object_attribute_qualifier; Type: TABLE; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE TABLE object_attribute_qualifier (
    gid integer NOT NULL,
    attribute_id integer,
    qualifier_type_code character varying(254),
    qualifier_value character varying(254),
    qualifier_numeric_1 numeric,
    qualifier_text_1 character varying(254),
    qualifier_timestamp_1 timestamp with time zone
);


ALTER TABLE asset.object_attribute_qualifier OWNER TO postgres;

--
-- Name: TABLE object_attribute_qualifier; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON TABLE object_attribute_qualifier IS 'The object object attribute qualifier table. Contains information about the object qualifiers.';


--
-- Name: COLUMN object_attribute_qualifier.gid; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.gid IS 'Unique object attribute qualifier identifier';


--
-- Name: COLUMN object_attribute_qualifier.attribute_id; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.attribute_id IS 'Object atttribute identifier';


--
-- Name: COLUMN object_attribute_qualifier.qualifier_type_code; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.qualifier_type_code IS 'Code of the taxonomy qualifier type';


--
-- Name: COLUMN object_attribute_qualifier.qualifier_value; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.qualifier_value IS 'Value of the taxonomy qualifier type (from look up table in taxonomy scheme)';


--
-- Name: COLUMN object_attribute_qualifier.qualifier_numeric_1; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.qualifier_numeric_1 IS 'Value of the taxonomy qualifier type (numeric)';


--
-- Name: COLUMN object_attribute_qualifier.qualifier_text_1; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.qualifier_text_1 IS 'Value of the taxonomy qualifier type (textual)';


--
-- Name: COLUMN object_attribute_qualifier.qualifier_timestamp_1; Type: COMMENT; Schema: asset; Owner: postgres
--

COMMENT ON COLUMN object_attribute_qualifier.qualifier_timestamp_1 IS 'Value of the taxonomy qualifier type (timestamp)';


--
-- Name: object_attribute_qualifier_gid_seq; Type: SEQUENCE; Schema: asset; Owner: postgres
--

CREATE SEQUENCE object_attribute_qualifier_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE asset.object_attribute_qualifier_gid_seq OWNER TO postgres;

--
-- Name: object_attribute_qualifier_gid_seq; Type: SEQUENCE OWNED BY; Schema: asset; Owner: postgres
--

ALTER SEQUENCE object_attribute_qualifier_gid_seq OWNED BY object_attribute_qualifier.gid;


--
-- Name: object_gid_seq; Type: SEQUENCE; Schema: asset; Owner: postgres
--

CREATE SEQUENCE object_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE asset.object_gid_seq OWNER TO postgres;

--
-- Name: object_gid_seq; Type: SEQUENCE OWNED BY; Schema: asset; Owner: postgres
--

ALTER SEQUENCE object_gid_seq OWNED BY object.gid;


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

--
-- Name: gid; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object ALTER COLUMN gid SET DEFAULT nextval('object_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object_attribute ALTER COLUMN gid SET DEFAULT nextval('object_attribute_gid_seq'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object_attribute_qualifier ALTER COLUMN gid SET DEFAULT nextval('object_attribute_qualifier_gid_seq'::regclass);


--
-- Name: mat_type; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN mat_type SET DEFAULT 'MAT99'::character varying;


--
-- Name: mat_tech; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN mat_tech SET DEFAULT 'MATT99'::character varying;


--
-- Name: mat_prop; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN mat_prop SET DEFAULT 'MATP99'::character varying;


--
-- Name: llrs; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN llrs SET DEFAULT 'L99'::character varying;


--
-- Name: llrs_duct; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN llrs_duct SET DEFAULT 'DU99'::character varying;


--
-- Name: height; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN height SET DEFAULT 'H99'::character varying;


--
-- Name: yr_built; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN yr_built SET DEFAULT 'Y99'::character varying;


--
-- Name: occupy; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN occupy SET DEFAULT 'OC99'::character varying;


--
-- Name: occupy_dt; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN occupy_dt SET DEFAULT 'OCCDT99'::character varying;


--
-- Name: position; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN "position" SET DEFAULT 'BP99'::character varying;


--
-- Name: plan_shape; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN plan_shape SET DEFAULT 'PLF99'::character varying;


--
-- Name: str_irreg; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg SET DEFAULT 'IR99'::character varying;


--
-- Name: str_irreg_dt; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg_dt SET DEFAULT 'IRP99'::character varying;


--
-- Name: str_irreg_type; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN str_irreg_type SET DEFAULT 'IRT99'::character varying;


--
-- Name: nonstrcexw; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN nonstrcexw SET DEFAULT 'EW99'::character varying;


--
-- Name: roof_shape; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN roof_shape SET DEFAULT 'R99'::character varying;


--
-- Name: roofcovmat; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN roofcovmat SET DEFAULT 'RMT99'::character varying;


--
-- Name: roofsysmat; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN roofsysmat SET DEFAULT 'RSM99'::character varying;


--
-- Name: roofsystyp; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN roofsystyp SET DEFAULT 'RST99'::character varying;


--
-- Name: roof_conn; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN roof_conn SET DEFAULT 'RCN99'::character varying;


--
-- Name: floor_mat; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN floor_mat SET DEFAULT 'F99'::character varying;


--
-- Name: floor_type; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN floor_type SET DEFAULT 'FT99'::character varying;


--
-- Name: floor_conn; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN floor_conn SET DEFAULT 'FWC99'::character varying;


--
-- Name: foundn_sys; Type: DEFAULT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY ve_object ALTER COLUMN foundn_sys SET DEFAULT 'FOS99'::character varying;


--
-- Data for Name: object; Type: TABLE DATA; Schema: asset; Owner: postgres
--

COPY object (gid, survey_gid, description, source, accuracy, the_geom) FROM stdin;
\.


--
-- Data for Name: object_attribute; Type: TABLE DATA; Schema: asset; Owner: postgres
--

COPY object_attribute (gid, object_id, attribute_type_code, attribute_value, attribute_numeric_1, attribute_numeric_2, attribute_text_1) FROM stdin;
\.


--
-- Name: object_attribute_gid_seq; Type: SEQUENCE SET; Schema: asset; Owner: postgres
--

SELECT pg_catalog.setval('object_attribute_gid_seq', 54000, true);


--
-- Data for Name: object_attribute_qualifier; Type: TABLE DATA; Schema: asset; Owner: postgres
--

COPY object_attribute_qualifier (gid, attribute_id, qualifier_type_code, qualifier_value, qualifier_numeric_1, qualifier_text_1, qualifier_timestamp_1) FROM stdin;
\.


--
-- Name: object_attribute_qualifier_gid_seq; Type: SEQUENCE SET; Schema: asset; Owner: postgres
--

SELECT pg_catalog.setval('object_attribute_qualifier_gid_seq', 110000, true);


--
-- Name: object_gid_seq; Type: SEQUENCE SET; Schema: asset; Owner: postgres
--

SELECT pg_catalog.setval('object_gid_seq', 2000, true);


--
-- Name: pk_object; Type: CONSTRAINT; Schema: asset; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY object_attribute
    ADD CONSTRAINT pk_object PRIMARY KEY (gid);


--
-- Name: pk_object_0; Type: CONSTRAINT; Schema: asset; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY object
    ADD CONSTRAINT pk_object_0 PRIMARY KEY (gid);


--
-- Name: pk_object_attribute_qualifier; Type: CONSTRAINT; Schema: asset; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY object_attribute_qualifier
    ADD CONSTRAINT pk_object_attribute_qualifier PRIMARY KEY (gid);


--
-- Name: idx_object; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object ON object USING btree (survey_gid);


--
-- Name: idx_object_attribute; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object_attribute ON object_attribute USING btree (object_id);


--
-- Name: idx_object_attribute_qualifier; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object_attribute_qualifier ON object_attribute_qualifier USING btree (attribute_id);


--
-- Name: idx_object_attribute_qualifier_0; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object_attribute_qualifier_0 ON object_attribute_qualifier USING btree (qualifier_type_code);


--
-- Name: idx_object_attribute_qualifier_1; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object_attribute_qualifier_1 ON object_attribute_qualifier USING btree (qualifier_value);


--
-- Name: idx_object_attribute_value; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_object_attribute_value ON object_attribute USING btree (attribute_value);


--
-- Name: pk_object_attribute_type_code; Type: INDEX; Schema: asset; Owner: postgres; Tablespace: 
--

CREATE INDEX pk_object_attribute_type_code ON object_attribute USING btree (attribute_type_code);


--
-- Name: object_trigger; Type: TRIGGER; Schema: asset; Owner: postgres
--

CREATE TRIGGER object_trigger INSTEAD OF INSERT OR DELETE OR UPDATE ON ve_object FOR EACH ROW EXECUTE PROCEDURE edit_object_view();


--
-- Name: fk_attribute_gid; Type: FK CONSTRAINT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object_attribute_qualifier
    ADD CONSTRAINT fk_attribute_gid FOREIGN KEY (attribute_id) REFERENCES object_attribute(gid);


--
-- Name: fk_object_gid; Type: FK CONSTRAINT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object_attribute
    ADD CONSTRAINT fk_object_gid FOREIGN KEY (object_id) REFERENCES object(gid);


--
-- Name: fk_object_survey; Type: FK CONSTRAINT; Schema: asset; Owner: postgres
--

ALTER TABLE ONLY object
    ADD CONSTRAINT fk_object_survey FOREIGN KEY (survey_gid) REFERENCES survey.survey(gid);


--
-- PostgreSQL database dump complete
--

