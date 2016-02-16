--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: image; Type: SCHEMA; Schema: -; Owner: postgres
--

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

--
-- Name: TABLE gpano_metadata; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON TABLE gpano_metadata IS ' Photosphere XMP metadata. Properties that provide information regarding the creation and rendering of photo spheres, also sometimes referred to as panoramas';


--
-- Name: COLUMN gpano_metadata.gid; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.gid IS 'unique identifier';


--
-- Name: COLUMN gpano_metadata.usepanoramaviewer; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.usepanoramaviewer IS 'Whether to show this image in a photo sphere viewer rather than as a normal flat image. This may be specified based on user preferences or by the stitching software. The application displaying or ingesting the image may choose to ignore this.';


--
-- Name: COLUMN gpano_metadata.capturesoftware; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.capturesoftware IS 'If capture was done using an application on a mobile device, such as an Android phone, the name of the application that was used (such as “Photo Sphere”). This should be left blank if source images were captured manually, such as by using a DSLR on a tripod.';


--
-- Name: COLUMN gpano_metadata.stitchingsoftware; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.stitchingsoftware IS 'The software that was used to create the final photo sphere. This may sometimes be the same value as that of  GPano:CaptureSoftware.';


--
-- Name: COLUMN gpano_metadata.projectiontype; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.projectiontype IS 'Projection type used in the image file. Google products currently support the value equirectangular.';


--
-- Name: COLUMN gpano_metadata.poseheadingdegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.poseheadingdegrees IS 'Compass heading, measured in degrees, for the center the image. Value must be >= 0 and < 360.';


--
-- Name: COLUMN gpano_metadata.posepitchdegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.posepitchdegrees IS 'Pitch, measured in degrees, for the center in the image. Value must be >= -90 and <= 90.';


--
-- Name: COLUMN gpano_metadata.poserolldegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.poserolldegrees IS 'Roll, measured in degrees, of the image where level with the horizon is 0. Value must be > -180 and <= 180.';


--
-- Name: COLUMN gpano_metadata.initialviewheadingdegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.initialviewheadingdegrees IS 'The heading angle of the initial view in degrees.';


--
-- Name: COLUMN gpano_metadata.initialviewpitchdegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.initialviewpitchdegrees IS 'The pitch angle of the initial view in degrees.';


--
-- Name: COLUMN gpano_metadata.initialviewrolldegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.initialviewrolldegrees IS 'The roll angle of the initial view in degrees.';


--
-- Name: COLUMN gpano_metadata.initialhorizontalfovdegrees; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.initialhorizontalfovdegrees IS 'The initial horizontal field of view that the viewer should display (in degrees). This is similar to a zoom level.';


--
-- Name: COLUMN gpano_metadata.firstphotodate; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.firstphotodate IS 'Date and time for the first image created in the photo sphere.';


--
-- Name: COLUMN gpano_metadata.sourcephotoscount; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.sourcephotoscount IS 'Number of source images used to create the photo sphere.';


--
-- Name: COLUMN gpano_metadata.exposurelockused; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.exposurelockused IS 'When individual source photographs were captured, whether or not the camera’s exposure setting was locked. ';


--
-- Name: COLUMN gpano_metadata.croppedareaimagewidthpixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.croppedareaimagewidthpixels IS ' Original width in pixels of the image (equal to the actual image’s width for unedited images).';


--
-- Name: COLUMN gpano_metadata.croppedareaimageheightpixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.croppedareaimageheightpixels IS 'Original height in pixels of the image (equal to the actual image’s height for unedited images).';


--
-- Name: COLUMN gpano_metadata.fullpanoheightpixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.fullpanoheightpixels IS 'Original full height from which the image was cropped. If only a partial photo sphere was captured, this specifies the height of what the full photo sphere would have been.';


--
-- Name: COLUMN gpano_metadata.croppedarealeftpixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.croppedarealeftpixels IS 'Column where the left edge of the image was cropped from the full sized photo sphere.';


--
-- Name: COLUMN gpano_metadata.croppedareatoppixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.croppedareatoppixels IS 'Row where the top edge of the image was cropped from the full sized photo sphere.';


--
-- Name: COLUMN gpano_metadata.initialcameradolly; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.initialcameradolly IS 'This optional parameter moves the virtual camera position along the line of sight, away from the center of the photo sphere. A rear surface position is represented by the value -1.0, while a front surface position is represented by 1.0. For normal viewing, this parameter should be set to 0.';


--
-- Name: COLUMN gpano_metadata.fullpanowidthpixels; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gpano_metadata.fullpanowidthpixels IS 'Original full width from which the image was cropped. If only a partial photo sphere was captured, this specifies the width of what the full photo sphere would have been.';

--
-- Name: gid; Type: DEFAULT; Schema: image; Owner: postgres
--

ALTER TABLE ONLY gpano_metadata ALTER COLUMN gid SET DEFAULT nextval('gpano_metadata_gid_seq'::regclass);

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

--
-- Name: TABLE gps; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON TABLE gps IS 'basic information about position, derived from GPS measurements (can be interpolated)';


--
-- Name: COLUMN gps.altitude; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gps.altitude IS 'altitude in meters (an be interpolated)';


--
-- Name: COLUMN gps.azimuth; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gps.azimuth IS 'direction of motion, in degrees, clockwise  from the north';


--
-- Name: COLUMN gps.abspeed; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gps.abspeed IS 'absolute speed at measurement time, in km/h (can be interpolated)';


--
-- Name: COLUMN gps.lat; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gps.lat IS 'latitude (can be interpolated)';


--
-- Name: COLUMN gps.lon; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN gps.lon IS 'longitude, in degrees WGS84 ';


--
-- Name: image_type; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

CREATE TABLE image_type (
    gid serial PRIMARY KEY,
    code character varying(50) NOT NULL,
    description character varying(255)
);


ALTER TABLE image.image_type OWNER TO postgres;

--
-- Name: TABLE image_type; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON TABLE image_type IS 'possible types of images';


--
-- Name: COLUMN image_type.code; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN image_type.code IS 'alfanumeric descriptor of image type';


--
-- Name: COLUMN image_type.description; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN image_type.description IS 'short text descriptino of the image type';



ALTER TABLE image.image_type_gid_seq OWNER TO postgres;

--
-- Name: image_type_gid_seq; Type: SEQUENCE OWNED BY; Schema: image; Owner: postgres
--

ALTER SEQUENCE image_type_gid_seq OWNED BY image_type.gid;


--
-- Name: img; Type: TABLE; Schema: image; Owner: postgres; Tablespace: 
--

--
-- Name: gid; Type: DEFAULT; Schema: image; Owner: postgres
--

ALTER TABLE ONLY image_type ALTER COLUMN gid SET DEFAULT nextval('image_type_gid_seq'::regclass);


--
-- Data for Name: image_type; Type: TABLE DATA; Schema: image; Owner: postgres
--

INSERT INTO image.image_type (gid, code, description) VALUES (1,'pano','panoramic or omnidirectional image');
INSERT INTO image.image_type (gid, code, description) VALUES (2,'pict','generic simple picture');

--
-- Name: pk_image_type_0; Type: CONSTRAINT; Schema: image; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY image_type
    ADD CONSTRAINT pk_image_type_0 UNIQUE (code);


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

--
-- Name: TABLE img; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON TABLE img IS 'image descriptor';


--
-- Name: COLUMN img.gps; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.gps IS 'info from GPS ';


--
-- Name: COLUMN img.survey; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.survey IS 'code of the survey that generated the images';


--
-- Name: COLUMN img."timestamp"; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img."timestamp" IS 'creation of the image, in Universal Coordinated Time (UTC)';


--
-- Name: COLUMN img.filename; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.filename IS 'name of the physical file of the image, if existing, with extension';


--
-- Name: COLUMN img.type; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.type IS 'type of image';


--
-- Name: COLUMN img.repository; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.repository IS 'physical path to the repository hosting the image file, if existing ';


--
-- Name: COLUMN img.frame_id; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.frame_id IS 'id of the frame in an omnidirectional PGR sequence';


--
-- Name: COLUMN img.gpano; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.gpano IS 'gpano metadata';


--
-- Name: COLUMN img.width; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.width IS 'number of columns';


--
-- Name: COLUMN img.height; Type: COMMENT; Schema: image; Owner: postgres
--

COMMENT ON COLUMN img.height IS 'number of rows';

--
-- Name: fk_img_gpano_metadata; Type: FK CONSTRAINT; Schema: image; Owner: postgres
--

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_gpano_metadata FOREIGN KEY (gpano) REFERENCES gpano_metadata(gid);


--
-- Name: fk_img_gps; Type: FK CONSTRAINT; Schema: image; Owner: postgres
--

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_gps FOREIGN KEY (gps) REFERENCES gps(gid);


--
-- Name: fk_img_image_type; Type: FK CONSTRAINT; Schema: image; Owner: postgres
--

ALTER TABLE ONLY img
    ADD CONSTRAINT fk_img_image_type FOREIGN KEY (type) REFERENCES image_type(code);


--
-- Name: idx_img; Type: INDEX; Schema: image; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img ON img USING btree (gps);


--
-- Name: idx_img_0; Type: INDEX; Schema: image; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img_0 ON img USING btree (survey);


--
-- Name: idx_img_1; Type: INDEX; Schema: image; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img_1 ON img USING btree (type);


--
-- Name: idx_img_2; Type: INDEX; Schema: image; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img_2 ON img USING btree (gpano);

--
-- PostgreSQL database dump complete
--

