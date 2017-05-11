--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: lang; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE lang AS ENUM (
    'en',
    'ru',
    'ua'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cv_trans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cv_trans (
    id integer NOT NULL,
    cv_id integer,
    tran_lang lang NOT NULL,
    full_name character varying NOT NULL,
    marital_status character varying,
    address character varying,
    summary character varying(500),
    personal_skills character varying,
    technical_skills json,
    qualifications character varying(100)[],
    links json,
    languages json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" character varying
);


--
-- Name: cv_trans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cv_trans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cv_trans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cv_trans_id_seq OWNED BY cv_trans.id;


--
-- Name: cvs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cvs (
    id integer NOT NULL,
    token character varying(6),
    birthday timestamp without time zone NOT NULL,
    email character varying NOT NULL,
    phone character varying,
    skype character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cvs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cvs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cvs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cvs_id_seq OWNED BY cvs.id;


--
-- Name: educations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE educations (
    id integer NOT NULL,
    cv_tran_id integer,
    degree character varying NOT NULL,
    specialty character varying,
    institution character varying NOT NULL,
    year integer NOT NULL,
    institution_address character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE educations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE educations_id_seq OWNED BY educations.id;


--
-- Name: experiences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE experiences (
    id integer NOT NULL,
    cv_tran_id integer,
    started_at timestamp without time zone NOT NULL,
    finished_at timestamp without time zone,
    "position" character varying NOT NULL,
    company character varying NOT NULL,
    company_site character varying,
    company_address character varying,
    duties character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE experiences_id_seq OWNED BY experiences.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projects (
    id integer NOT NULL,
    experience_id integer,
    name character varying NOT NULL,
    description character varying(500),
    link character varying,
    technologies character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cv_trans ALTER COLUMN id SET DEFAULT nextval('cv_trans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cvs ALTER COLUMN id SET DEFAULT nextval('cvs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY educations ALTER COLUMN id SET DEFAULT nextval('educations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY experiences ALTER COLUMN id SET DEFAULT nextval('experiences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cv_trans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cv_trans
    ADD CONSTRAINT cv_trans_pkey PRIMARY KEY (id);


--
-- Name: cvs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cvs
    ADD CONSTRAINT cvs_pkey PRIMARY KEY (id);


--
-- Name: educations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- Name: experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY experiences
    ADD CONSTRAINT experiences_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_cv_trans_on_cv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cv_trans_on_cv_id ON cv_trans USING btree (cv_id);


--
-- Name: index_cvs_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cvs_on_token ON cvs USING btree (token);


--
-- Name: index_educations_on_cv_tran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_educations_on_cv_tran_id ON educations USING btree (cv_tran_id);


--
-- Name: index_experiences_on_cv_tran_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_experiences_on_cv_tran_id ON experiences USING btree (cv_tran_id);


--
-- Name: index_projects_on_experience_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_experience_id ON projects USING btree (experience_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20170228125752'),
('20170228130101'),
('20170228143047'),
('20170228143058'),
('20170228153923'),
('20170403104246'),
('20170511113650');


