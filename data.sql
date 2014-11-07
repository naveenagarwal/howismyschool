--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    namespace character varying(255),
    body text,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.active_admin_comments OWNER TO postgres;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO postgres;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: class_room_students; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE class_room_students (
    id integer NOT NULL,
    class_room_id integer,
    student_id integer,
    year character varying(255),
    school_branch_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.class_room_students OWNER TO postgres;

--
-- Name: class_room_students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE class_room_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.class_room_students_id_seq OWNER TO postgres;

--
-- Name: class_room_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE class_room_students_id_seq OWNED BY class_room_students.id;


--
-- Name: class_rooms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE class_rooms (
    id integer NOT NULL,
    name character varying(255),
    creator_id integer,
    creator_type character varying(255),
    school_id integer,
    school_branch_id integer,
    grade character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    document_id integer
);


ALTER TABLE public.class_rooms OWNER TO postgres;

--
-- Name: class_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE class_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.class_rooms_id_seq OWNER TO postgres;

--
-- Name: class_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE class_rooms_id_seq OWNED BY class_rooms.id;


--
-- Name: class_tests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE class_tests (
    id integer NOT NULL,
    name character varying(255),
    school_id integer,
    school_branch_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    document_id integer
);


ALTER TABLE public.class_tests OWNER TO postgres;

--
-- Name: class_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE class_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.class_tests_id_seq OWNER TO postgres;

--
-- Name: class_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE class_tests_id_seq OWNED BY class_tests.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    description text,
    comentator_id integer,
    comentator_type character varying(255),
    comment_for_id integer,
    comment_for_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    name character varying(255),
    document_type character varying(255),
    recorded_ids character varying(255)[] DEFAULT '{}'::character varying[],
    creator_id integer,
    creator_type character varying(255),
    school_branch_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: managers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE managers (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creator_id integer,
    creator_type character varying(255)
);


ALTER TABLE public.managers OWNER TO postgres;

--
-- Name: managers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.managers_id_seq OWNER TO postgres;

--
-- Name: managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE managers_id_seq OWNED BY managers.id;


--
-- Name: mock_test_takens; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mock_test_takens (
    id integer NOT NULL,
    mock_test_id integer,
    student_id integer,
    ques_and_ans_id integer,
    answer_given json DEFAULT '{}'::json,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.mock_test_takens OWNER TO postgres;

--
-- Name: mock_test_takens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mock_test_takens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mock_test_takens_id_seq OWNER TO postgres;

--
-- Name: mock_test_takens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mock_test_takens_id_seq OWNED BY mock_test_takens.id;


--
-- Name: mock_tests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mock_tests (
    id integer NOT NULL,
    school_branch_id integer,
    creator_id integer,
    creator_type character varying(255),
    name character varying(255),
    class_room_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    publish boolean,
    subject_id integer
);


ALTER TABLE public.mock_tests OWNER TO postgres;

--
-- Name: mock_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mock_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mock_tests_id_seq OWNER TO postgres;

--
-- Name: mock_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mock_tests_id_seq OWNED BY mock_tests.id;


--
-- Name: my_details; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE my_details (
    id integer NOT NULL,
    whoami_id integer,
    whoami_type character varying(255),
    school_branch_id integer,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    phone character varying(255),
    emergency_contact character varying(255),
    address_temporary character varying(255),
    address_permamnent character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.my_details OWNER TO postgres;

--
-- Name: my_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE my_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.my_details_id_seq OWNER TO postgres;

--
-- Name: my_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE my_details_id_seq OWNED BY my_details.id;


--
-- Name: ques_and_ans; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ques_and_ans (
    id integer NOT NULL,
    question text,
    answer_type integer,
    answer_choices json DEFAULT '{}'::json,
    right_answer json DEFAULT '{}'::json,
    mock_test_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.ques_and_ans OWNER TO postgres;

--
-- Name: ques_and_ans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ques_and_ans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ques_and_ans_id_seq OWNER TO postgres;

--
-- Name: ques_and_ans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ques_and_ans_id_seq OWNED BY ques_and_ans.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schedules (
    id integer NOT NULL,
    title character varying(255),
    creator_id integer,
    creator_type character varying(255),
    school_branch_id integer,
    event_for hstore DEFAULT ''::hstore,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedules_id_seq OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE schedules_id_seq OWNED BY schedules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: school_branches; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE school_branches (
    id integer NOT NULL,
    name character varying(255),
    address text,
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    school_id integer
);


ALTER TABLE public.school_branches OWNER TO postgres;

--
-- Name: school_branches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE school_branches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.school_branches_id_seq OWNER TO postgres;

--
-- Name: school_branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE school_branches_id_seq OWNED BY school_branches.id;


--
-- Name: school_controllers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE school_controllers (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creator_id integer,
    creator_type character varying(255),
    school_branch_id integer,
    manager_id integer
);


ALTER TABLE public.school_controllers OWNER TO postgres;

--
-- Name: school_controllers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE school_controllers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.school_controllers_id_seq OWNER TO postgres;

--
-- Name: school_controllers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE school_controllers_id_seq OWNED BY school_controllers.id;


--
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schools (
    id integer NOT NULL,
    name character varying(255),
    regestrar_details hstore DEFAULT '"email"=>"", "phone"=>"", "address"=>"", "last_name"=>"", "first_name"=>""'::hstore,
    school_controller_id integer,
    manager_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schools_id_seq OWNER TO postgres;

--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: searches; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE searches (
    id integer NOT NULL,
    text character varying(255),
    searcher_id integer,
    searcher_type character varying(255),
    result text[] DEFAULT '{}'::text[],
    school_branch_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.searches OWNER TO postgres;

--
-- Name: searches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.searches_id_seq OWNER TO postgres;

--
-- Name: searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE searches_id_seq OWNED BY searches.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    name character varying(255),
    roll_number character varying(255),
    class_room_id integer,
    school_branch_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    year character varying(255),
    document_id integer,
    mother_name character varying(255),
    father_name character varying(255),
    address character varying(255),
    previous_school character varying(255),
    father_phone character varying(255),
    mother_phone character varying(255),
    email character varying(255),
    other_info text
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subjects (
    id integer NOT NULL,
    name character varying(255),
    school_branch_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    document_id integer
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_id_seq OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE teachers (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creator_id integer,
    creator_type character varying(255),
    school_id integer,
    school_branch_id integer
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teachers_id_seq OWNED BY teachers.id;


--
-- Name: test_results; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE test_results (
    id integer NOT NULL,
    percentage double precision DEFAULT 0.0,
    grade character varying(255),
    outcome boolean DEFAULT false,
    remarks text,
    subject_id integer,
    student_id integer,
    class_test_id integer,
    school_branch_id integer,
    class_room_id integer,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    year character varying(255),
    test_results_from_file_id integer,
    class_room_name character varying(255),
    class_test_name character varying(255),
    student_name character varying(255),
    subject_name character varying(255)
);


ALTER TABLE public.test_results OWNER TO postgres;

--
-- Name: test_results_from_files; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE test_results_from_files (
    id integer NOT NULL,
    name character varying(255),
    school_branch_id integer,
    test_result_ids character varying(255)[] DEFAULT '{}'::character varying[],
    status integer,
    status_msg text,
    creator_id integer,
    creator_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    parsing_errors text
);


ALTER TABLE public.test_results_from_files OWNER TO postgres;

--
-- Name: test_results_from_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE test_results_from_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_results_from_files_id_seq OWNER TO postgres;

--
-- Name: test_results_from_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE test_results_from_files_id_seq OWNED BY test_results_from_files.id;


--
-- Name: test_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE test_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_results_id_seq OWNER TO postgres;

--
-- Name: test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE test_results_id_seq OWNED BY test_results.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class_room_students ALTER COLUMN id SET DEFAULT nextval('class_room_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class_rooms ALTER COLUMN id SET DEFAULT nextval('class_rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class_tests ALTER COLUMN id SET DEFAULT nextval('class_tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY managers ALTER COLUMN id SET DEFAULT nextval('managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mock_test_takens ALTER COLUMN id SET DEFAULT nextval('mock_test_takens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mock_tests ALTER COLUMN id SET DEFAULT nextval('mock_tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY my_details ALTER COLUMN id SET DEFAULT nextval('my_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ques_and_ans ALTER COLUMN id SET DEFAULT nextval('ques_and_ans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedules ALTER COLUMN id SET DEFAULT nextval('schedules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_branches ALTER COLUMN id SET DEFAULT nextval('school_branches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_controllers ALTER COLUMN id SET DEFAULT nextval('school_controllers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY searches ALTER COLUMN id SET DEFAULT nextval('searches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachers ALTER COLUMN id SET DEFAULT nextval('teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY test_results ALTER COLUMN id SET DEFAULT nextval('test_results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY test_results_from_files ALTER COLUMN id SET DEFAULT nextval('test_results_from_files_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY active_admin_comments (id, namespace, body, resource_id, resource_type, author_id, author_type, created_at, updated_at) FROM stdin;
\.


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('active_admin_comments_id_seq', 1, false);


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
1	admin@example.com	$2a$10$0Hy9CPxCUNYs1F/TPhux7Ol1YzdO4b.hZneqBf7McE.WKdKfXufzG	\N	\N	\N	1	2014-06-26 05:15:32.295624	2014-06-26 05:15:32.295624	127.0.0.1	127.0.0.1	2014-06-26 05:10:28.961556	2014-06-26 11:41:47.312657
\.


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admin_users_id_seq', 1, true);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY admins (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at) FROM stdin;
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admins_id_seq', 1, false);


--
-- Data for Name: class_room_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY class_room_students (id, class_room_id, student_id, year, school_branch_id, creator_id, creator_type, created_at, updated_at) FROM stdin;
1	6	7	2014-2015	1	2	Teacher	2014-07-17 06:56:37.966128	2014-07-17 06:56:37.966128
2	6	8	2014-2015	1	2	Teacher	2014-07-17 06:56:38.014919	2014-07-17 06:56:38.014919
3	6	9	2014-2015	1	2	Teacher	2014-07-17 06:56:38.035887	2014-07-17 06:56:38.035887
4	6	10	2014-2015	1	2	Teacher	2014-07-17 06:56:38.068481	2014-07-17 06:56:38.068481
5	7	11	2014-2015	1	2	Teacher	2014-07-17 06:56:38.088176	2014-07-17 06:56:38.088176
6	7	12	2014-2015	1	2	Teacher	2014-07-17 06:56:38.109556	2014-07-17 06:56:38.109556
7	7	13	2014-2015	1	2	Teacher	2014-07-17 06:56:38.129775	2014-07-17 06:56:38.129775
8	7	14	2014-2015	1	2	Teacher	2014-07-17 06:56:38.150004	2014-07-17 06:56:38.150004
9	8	15	2014-2015	1	2	Teacher	2014-07-17 06:56:38.171495	2014-07-17 06:56:38.171495
10	8	16	2014-2015	1	2	Teacher	2014-07-17 06:56:38.191552	2014-07-17 06:56:38.191552
11	8	17	2014-2015	1	2	Teacher	2014-07-17 06:56:38.21324	2014-07-17 06:56:38.21324
12	8	18	2014-2015	1	2	Teacher	2014-07-17 06:56:38.233059	2014-07-17 06:56:38.233059
13	6	19	2014-2015	1	2	Teacher	2014-07-17 06:56:38.254729	2014-07-17 06:56:38.254729
14	6	20	2014-2015	1	2	Teacher	2014-07-17 06:56:38.274465	2014-07-17 06:56:38.274465
15	6	21	2014-2015	1	2	Teacher	2014-07-17 06:56:38.294619	2014-07-17 06:56:38.294619
16	6	22	2014-2015	1	2	Teacher	2014-07-17 06:56:38.315925	2014-07-17 06:56:38.315925
17	7	23	2014-2015	1	2	Teacher	2014-07-17 06:56:38.336322	2014-07-17 06:56:38.336322
18	7	24	2014-2015	1	2	Teacher	2014-07-17 06:56:38.358214	2014-07-17 06:56:38.358214
19	8	25	2014-2015	1	2	Teacher	2014-07-17 06:56:38.377608	2014-07-17 06:56:38.377608
20	10	26	2014-2015	1	2	Teacher	2014-07-17 06:56:38.398178	2014-07-17 06:56:38.398178
21	10	27	2014-2015	1	2	Teacher	2014-07-17 06:56:38.419517	2014-07-17 06:56:38.419517
22	10	28	2014-2015	1	2	Teacher	2014-07-17 06:56:38.439288	2014-07-17 06:56:38.439288
23	10	29	2014-2015	1	2	Teacher	2014-07-17 06:56:38.46165	2014-07-17 06:56:38.46165
24	10	30	2014-2015	1	2	Teacher	2014-07-17 06:56:38.52245	2014-07-17 06:56:38.52245
25	11	31	2014-2015	1	2	Teacher	2014-07-17 06:56:38.546324	2014-07-17 06:56:38.546324
26	11	32	2014-2015	1	2	Teacher	2014-07-17 06:56:38.566039	2014-07-17 06:56:38.566039
27	11	33	2014-2015	1	2	Teacher	2014-07-17 06:56:38.587635	2014-07-17 06:56:38.587635
28	11	34	2014-2015	1	2	Teacher	2014-07-17 06:56:38.608532	2014-07-17 06:56:38.608532
29	11	35	2014-2015	1	2	Teacher	2014-07-17 06:56:38.628397	2014-07-17 06:56:38.628397
30	11	36	2014-2015	1	2	Teacher	2014-07-17 06:56:38.650243	2014-07-17 06:56:38.650243
31	11	37	2014-2015	1	2	Teacher	2014-07-17 06:56:38.670379	2014-07-17 06:56:38.670379
32	10	38	2014-2015	1	2	Teacher	2014-07-17 06:56:38.692169	2014-07-17 06:56:38.692169
33	10	39	2014-2015	1	2	Teacher	2014-07-17 06:56:38.713147	2014-07-17 06:56:38.713147
34	10	40	2014-2015	1	2	Teacher	2014-07-17 06:56:38.733938	2014-07-17 06:56:38.733938
35	10	41	2014-2015	1	2	Teacher	2014-07-17 06:56:38.754289	2014-07-17 06:56:38.754289
36	10	42	2014-2015	1	2	Teacher	2014-07-17 06:56:38.77503	2014-07-17 06:56:38.77503
37	11	43	2014-2015	1	2	Teacher	2014-07-17 06:56:38.796858	2014-07-17 06:56:38.796858
38	11	44	2014-2015	1	2	Teacher	2014-07-17 06:56:38.817007	2014-07-17 06:56:38.817007
39	11	45	2014-2015	1	2	Teacher	2014-07-17 06:56:38.838193	2014-07-17 06:56:38.838193
40	12	46	2014-2015	1	2	Teacher	2014-07-17 06:56:38.8592	2014-07-17 06:56:38.8592
41	12	47	2014-2015	1	2	Teacher	2014-07-17 06:56:38.880206	2014-07-17 06:56:38.880206
42	12	48	2014-2015	1	2	Teacher	2014-07-17 06:56:38.900537	2014-07-17 06:56:38.900537
43	12	49	2014-2015	1	2	Teacher	2014-07-17 06:56:38.921297	2014-07-17 06:56:38.921297
44	12	50	2014-2015	1	2	Teacher	2014-07-17 06:56:38.934361	2014-07-17 06:56:38.934361
45	13	51	2014-2015	1	2	Teacher	2014-07-17 06:56:38.955241	2014-07-17 06:56:38.955241
46	13	52	2014-2015	1	2	Teacher	2014-07-17 06:56:38.97631	2014-07-17 06:56:38.97631
47	13	53	2014-2015	1	2	Teacher	2014-07-17 06:56:38.996799	2014-07-17 06:56:38.996799
48	13	54	2014-2015	1	2	Teacher	2014-07-17 06:56:39.018295	2014-07-17 06:56:39.018295
49	14	55	2014-2015	1	2	Teacher	2014-07-17 06:56:39.038642	2014-07-17 06:56:39.038642
50	14	56	2014-2015	1	2	Teacher	2014-07-17 06:56:39.060385	2014-07-17 06:56:39.060385
51	14	57	2014-2015	1	2	Teacher	2014-07-17 06:56:39.080997	2014-07-17 06:56:39.080997
52	14	58	2014-2015	1	2	Teacher	2014-07-17 06:56:39.101504	2014-07-17 06:56:39.101504
53	12	59	2014-2015	1	2	Teacher	2014-07-17 06:56:39.122644	2014-07-17 06:56:39.122644
54	12	60	2014-2015	1	2	Teacher	2014-07-17 06:56:39.142772	2014-07-17 06:56:39.142772
55	12	61	2014-2015	1	2	Teacher	2014-07-17 06:56:39.164438	2014-07-17 06:56:39.164438
56	12	62	2014-2015	1	2	Teacher	2014-07-17 06:56:39.184782	2014-07-17 06:56:39.184782
57	13	63	2014-2015	1	2	Teacher	2014-07-17 06:56:39.20639	2014-07-17 06:56:39.20639
58	13	64	2014-2015	1	2	Teacher	2014-07-17 06:56:39.227571	2014-07-17 06:56:39.227571
59	14	65	2014-2015	1	2	Teacher	2014-07-17 06:56:39.290566	2014-07-17 06:56:39.290566
60	15	66	2014-2015	1	2	Teacher	2014-07-17 06:56:39.311008	2014-07-17 06:56:39.311008
61	15	67	2014-2015	1	2	Teacher	2014-07-17 06:56:39.330614	2014-07-17 06:56:39.330614
62	15	68	2014-2015	1	2	Teacher	2014-07-17 06:56:39.352589	2014-07-17 06:56:39.352589
63	15	69	2014-2015	1	2	Teacher	2014-07-17 06:56:39.373231	2014-07-17 06:56:39.373231
64	15	70	2014-2015	1	2	Teacher	2014-07-17 06:56:39.394278	2014-07-17 06:56:39.394278
65	16	71	2014-2015	1	2	Teacher	2014-07-17 06:56:39.41519	2014-07-17 06:56:39.41519
66	16	72	2014-2015	1	2	Teacher	2014-07-17 06:56:39.437513	2014-07-17 06:56:39.437513
67	16	73	2014-2015	1	2	Teacher	2014-07-17 06:56:39.456962	2014-07-17 06:56:39.456962
68	16	74	2014-2015	1	2	Teacher	2014-07-17 06:56:39.478476	2014-07-17 06:56:39.478476
69	17	75	2014-2015	1	2	Teacher	2014-07-17 06:56:39.498517	2014-07-17 06:56:39.498517
70	17	76	2014-2015	1	2	Teacher	2014-07-17 06:56:39.519536	2014-07-17 06:56:39.519536
71	17	77	2014-2015	1	2	Teacher	2014-07-17 06:56:39.5407	2014-07-17 06:56:39.5407
72	17	78	2014-2015	1	2	Teacher	2014-07-17 06:56:39.561518	2014-07-17 06:56:39.561518
73	15	79	2014-2015	1	2	Teacher	2014-07-17 06:56:39.58245	2014-07-17 06:56:39.58245
74	15	80	2014-2015	1	2	Teacher	2014-07-17 06:56:39.602839	2014-07-17 06:56:39.602839
75	15	81	2014-2015	1	2	Teacher	2014-07-17 06:56:39.624605	2014-07-17 06:56:39.624605
76	15	82	2014-2015	1	2	Teacher	2014-07-17 06:56:39.645108	2014-07-17 06:56:39.645108
77	16	83	2014-2015	1	2	Teacher	2014-07-17 06:56:39.666453	2014-07-17 06:56:39.666453
78	16	84	2014-2015	1	2	Teacher	2014-07-17 06:56:39.68734	2014-07-17 06:56:39.68734
79	17	85	2014-2015	1	2	Teacher	2014-07-17 06:56:39.707346	2014-07-17 06:56:39.707346
80	26	86	2014-2015	1	2	Teacher	2014-07-17 06:56:39.728797	2014-07-17 06:56:39.728797
81	26	87	2014-2015	1	2	Teacher	2014-07-17 06:56:39.786691	2014-07-17 06:56:39.786691
82	6	6	2014-2015	1	2	Teacher	2014-07-17 06:56:39.804217	2014-07-17 06:56:39.804217
\.


--
-- Name: class_room_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('class_room_students_id_seq', 82, true);


--
-- Data for Name: class_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY class_rooms (id, name, creator_id, creator_type, school_id, school_branch_id, grade, created_at, updated_at, document_id) FROM stdin;
6	1	2	Teacher	\N	1	A	2014-07-04 08:19:35.738304	2014-09-22 11:14:58.279595	\N
7	1	2	Teacher	\N	1	B	2014-07-04 08:19:35.81464	2014-09-22 11:14:58.279595	\N
8	1	2	Teacher	\N	1	C	2014-07-04 08:19:35.833736	2014-09-22 11:14:58.279595	\N
9	1	2	Teacher	\N	1	D	2014-07-04 08:19:35.855716	2014-09-22 11:14:58.279595	\N
10	2	2	Teacher	\N	1	A	2014-07-04 08:19:35.875294	2014-09-22 11:14:58.279595	\N
11	2	2	Teacher	\N	1	B	2014-07-04 08:19:35.895193	2014-09-22 11:14:58.279595	\N
12	3	2	Teacher	\N	1	A	2014-07-04 08:19:35.918392	2014-09-22 11:14:58.279595	\N
13	3	2	Teacher	\N	1	B	2014-07-04 08:19:35.936892	2014-09-22 11:14:58.279595	\N
14	3	2	Teacher	\N	1	C	2014-07-04 08:19:35.958638	2014-09-22 11:14:58.279595	\N
15	4	2	Teacher	\N	1	A	2014-07-04 08:19:35.979546	2014-09-22 11:14:58.279595	\N
16	4	2	Teacher	\N	1	B	2014-07-04 08:19:35.998494	2014-09-22 11:14:58.279595	\N
17	4	2	Teacher	\N	1	C	2014-07-04 08:19:36.019925	2014-09-22 11:14:58.279595	\N
18	4	2	Teacher	\N	1	D	2014-07-04 08:19:36.041261	2014-09-22 11:14:58.279595	\N
19	5	2	Teacher	\N	1	A	2014-07-04 08:19:36.063309	2014-09-22 11:14:58.279595	\N
20	6	2	Teacher	\N	1	A	2014-07-04 08:19:36.083638	2014-09-22 11:14:58.279595	\N
21	6	2	Teacher	\N	1	B	2014-07-04 08:19:36.105943	2014-09-22 11:14:58.279595	\N
22	6	2	Teacher	\N	1	C	2014-07-04 08:19:36.12581	2014-09-22 11:14:58.279595	\N
23	6	2	Teacher	\N	1	D	2014-07-04 08:19:36.145069	2014-09-22 11:14:58.279595	\N
24	6	2	Teacher	\N	1	E	2014-07-04 08:19:36.167931	2014-09-22 11:14:58.279595	\N
25	6	2	Teacher	\N	1	F	2014-07-04 08:19:36.186913	2014-09-22 11:14:58.279595	\N
26	7	2	Teacher	\N	1	A	2014-07-04 11:00:20.044192	2014-09-22 11:14:58.279595	8
27	7	2	Teacher	\N	1	B	2014-07-04 11:00:20.07057	2014-09-22 11:14:58.279595	8
28	7	2	Teacher	\N	1	C	2014-07-04 11:00:20.09106	2014-09-22 11:14:58.279595	8
29	7	2	Teacher	\N	1	D	2014-07-04 11:00:20.11361	2014-09-22 11:14:58.279595	8
30	7	2	Teacher	\N	1	E	2014-07-04 11:00:20.133505	2014-09-22 11:14:58.279595	8
31	7	2	Teacher	\N	1	F	2014-07-04 11:00:20.154877	2014-09-22 11:14:58.279595	8
32	7	2	Teacher	\N	1	G	2014-07-04 11:00:20.175304	2014-09-22 11:14:58.279595	8
\.


--
-- Name: class_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('class_rooms_id_seq', 32, true);


--
-- Data for Name: class_tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY class_tests (id, name, school_id, school_branch_id, creator_id, creator_type, created_at, updated_at, document_id) FROM stdin;
1	FA1	\N	\N	\N	\N	2014-06-26 04:55:03.881261	2014-06-26 04:55:03.881261	\N
2	FA2	\N	\N	\N	\N	2014-06-26 04:55:56.587422	2014-06-26 04:55:56.587422	\N
3	FA3	\N	\N	\N	\N	2014-06-26 04:56:08.20066	2014-06-26 04:56:08.20066	\N
5	FA2	\N	1	2	Teacher	2014-06-27 10:17:43.389738	2014-06-27 10:17:43.389738	\N
4	FA1	\N	1	2	Teacher	2014-06-27 10:17:23.055567	2014-06-27 10:17:53.07928	\N
6	FA3	\N	1	2	Teacher	2014-07-04 07:24:25.830789	2014-07-04 07:24:25.830789	\N
7	FA4	\N	1	2	Teacher	2014-07-04 08:22:31.881801	2014-07-04 08:22:31.881801	\N
8	MA1	\N	1	2	Teacher	2014-07-04 10:36:53.850188	2014-07-04 10:36:53.850188	6
9	MA2	\N	1	2	Teacher	2014-07-04 10:36:53.873549	2014-07-04 10:36:53.873549	6
10	MA3	\N	1	2	Teacher	2014-07-04 10:36:53.898075	2014-07-04 10:36:53.898075	6
11	SA1	\N	1	2	Teacher	2014-07-04 10:36:53.91563	2014-07-04 10:36:53.91563	6
12	SA2	\N	1	2	Teacher	2014-07-04 10:36:53.937798	2014-07-04 10:36:53.937798	6
13	SA3	\N	1	2	Teacher	2014-07-04 10:36:53.959175	2014-07-04 10:36:53.959175	6
14	GA1	\N	1	2	Teacher	2014-07-04 11:03:04.142439	2014-07-04 11:03:04.142439	9
15	GA2	\N	1	2	Teacher	2014-07-04 11:03:04.171982	2014-07-04 11:03:04.171982	9
16	GA3	\N	1	2	Teacher	2014-07-04 11:03:04.192973	2014-07-04 11:03:04.192973	9
\.


--
-- Name: class_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('class_tests_id_seq', 16, true);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comments (id, description, comentator_id, comentator_type, comment_for_id, comment_for_type, created_at, updated_at) FROM stdin;
13	asdfa	\N	\N	\N	\N	2014-09-01 12:07:10.568669	2014-09-01 12:07:10.568669
14	latest comment123	\N	\N	\N	\N	2014-09-01 12:27:46.155266	2014-09-01 12:59:26.554042
15	123123	\N	\N	\N	\N	2014-09-01 12:59:34.629356	2014-09-01 13:01:27.656745
16	asdfasd	\N	\N	\N	\N	2014-09-01 13:01:32.845218	2014-09-01 13:01:32.845218
17	hi	\N	\N	\N	\N	2014-09-02 08:54:35.349841	2014-09-02 08:54:35.349841
18	asdf	\N	\N	\N	\N	2014-09-02 08:56:28.014891	2014-09-02 08:56:28.014891
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comments_id_seq', 18, true);


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documents (id, name, document_type, recorded_ids, creator_id, creator_type, school_branch_id, created_at, updated_at) FROM stdin;
3	class_room_sample.csv	Class Room	{6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}	2	Teacher	1	2014-07-04 07:29:40.847671	2014-07-04 08:19:36.207247
4	students_sample.csv	Student	{6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}	2	Teacher	1	2014-07-04 08:59:10.475355	2014-07-04 09:06:04.980837
5	students_sample.csv	Student	{26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85}	2	Teacher	1	2014-07-04 09:29:14.742163	2014-07-04 09:30:31.575862
6	class_tests_sample.csv	Class Test	{8,9,10,11,12,13}	2	Teacher	1	2014-07-04 10:34:30.476909	2014-07-04 10:36:53.979994
7	subjects_sample.csv	Subject	{24,25,26,27,28,29,30,31,32,33,34,35}	2	Teacher	1	2014-07-04 10:41:04.208643	2014-07-04 10:45:14.351213
8	class_rooms_new_sample.csv	Class Room	{26,27,28,29,30,31,32}	2	Teacher	1	2014-07-04 10:57:38.942188	2014-07-04 11:00:20.196428
9	class_tests_new_sample.csv	Class Test	{}	2	Teacher	1	2014-07-04 11:02:47.079945	2014-07-04 11:05:04.134723
10	subjects_new_sample.csv	Subject	{36}	2	Teacher	1	2014-07-04 11:05:37.142584	2014-07-04 11:05:47.923734
11	students_new_sample.csv	Student	{86,87}	2	Teacher	1	2014-07-04 11:08:30.497893	2014-07-04 11:08:47.982286
13	students_sample_new.csv	Student	{}	2	Teacher	1	2014-07-07 11:30:15.447723	2014-07-07 11:30:15.447723
14	class_rooms_sample.csv	Class Room	{}	2	Teacher	1	2014-09-19 13:11:45.398869	2014-09-19 13:11:45.398869
\.


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documents_id_seq', 14, true);


--
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY managers (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at, creator_id, creator_type) FROM stdin;
1	smith@example.com	$2a$10$za5kPlSxayX4sTrbrn9CzOAhQ6IyARH/dmbjgwLgXNHiToL7x7m9y	\N	\N	\N	2	2014-06-25 08:03:59.120524	2014-06-25 05:04:07.164103	127.0.0.1	127.0.0.1	\N	\N	\N	\N	0	\N	\N	2014-06-25 05:03:51.35597	2014-06-25 08:03:59.122389	\N	\N
2	naveen@gmail.com	$2a$10$5MePytP8NWvfK4l0uL01UeQu8cBdOn0q20oQsHKNi81aQEJ26RypC	\N	\N	\N	2	2014-06-26 11:49:37.459568	2014-06-26 11:48:38.591951	127.0.0.1	127.0.0.1	\N	\N	\N	\N	0	\N	\N	2014-06-26 08:20:52.696638	2014-06-27 05:17:59.5694	\N	\N
\.


--
-- Name: managers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('managers_id_seq', 2, true);


--
-- Data for Name: mock_test_takens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mock_test_takens (id, mock_test_id, student_id, ques_and_ans_id, answer_given, created_at, updated_at) FROM stdin;
\.


--
-- Name: mock_test_takens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mock_test_takens_id_seq', 1, false);


--
-- Data for Name: mock_tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mock_tests (id, school_branch_id, creator_id, creator_type, name, class_room_id, created_at, updated_at, publish, subject_id) FROM stdin;
1	1	2	Teacher	MT 1	6	2014-08-04 07:33:49.127315	2014-08-04 07:33:49.127315	f	1
\.


--
-- Name: mock_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mock_tests_id_seq', 1, true);


--
-- Data for Name: my_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY my_details (id, whoami_id, whoami_type, school_branch_id, first_name, middle_name, last_name, phone, emergency_contact, address_temporary, address_permamnent, created_at, updated_at) FROM stdin;
1	2	Teacher	1	Naveen		Agarwal	8800576579	8800576579	Hlll Barrey, Sweet Avaenue	Hlll Barrey, Sweet Avaenue	2014-07-10 07:34:32.688577	2014-07-10 07:34:32.688577
\.


--
-- Name: my_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('my_details_id_seq', 1, true);


--
-- Data for Name: ques_and_ans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ques_and_ans (id, question, answer_type, answer_choices, right_answer, mock_test_id, creator_id, creator_type, created_at, updated_at) FROM stdin;
\.


--
-- Name: ques_and_ans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ques_and_ans_id_seq', 1, true);


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schedules (id, title, creator_id, creator_type, school_branch_id, event_for, start_time, end_time, created_at, updated_at) FROM stdin;
9	Play Hockey	2	Teacher	1	"ids"=>"6,8", "type"=>"ClassRoom", "names"=>"1A, 1C"	2014-07-10 18:22:08	2014-07-10 19:22:08	2014-07-16 12:52:39.338407	2014-07-17 05:19:43.769763
13	Play Hockey	2	Teacher	1	"ids"=>"7", "type"=>"ClassRoom", "names"=>"1B"	2014-08-23 18:32:51	2014-08-24 18:32:51	2014-07-16 13:03:17.327726	2014-07-17 05:19:44.386216
14	Play Hockey	2	Teacher	1	"ids"=>"9", "type"=>"ClassRoom", "names"=>"1D"	2014-08-04 18:47:40	2014-08-05 18:47:40	2014-07-16 13:17:56.54697	2014-07-17 05:19:44.409714
15	Play Hockey	2	Teacher	1	"ids"=>"7", "type"=>"ClassRoom", "names"=>"1B"	2014-08-05 18:49:26	2014-08-05 19:49:26	2014-07-16 13:19:55.662377	2014-07-17 05:19:44.490406
16	FA1 Tests	2	Teacher	1	"ids"=>"11", "type"=>"ClassRoom", "names"=>"2B"	2014-07-07 18:50:51	2014-07-09 18:50:51	2014-07-16 13:21:03.756505	2014-07-17 05:19:44.51594
8	FA2 Tests	2	Teacher	1	"ids"=>"9, 11", "type"=>"ClassRoom", "names"=>"1D, 2B"	2014-07-08 17:11:36	2014-07-10 17:11:36	2014-07-16 11:41:58.411532	2014-07-17 05:19:44.669406
20	FA1 Tests	2	Teacher	1	"ids"=>"11", "type"=>"ClassRoom", "names"=>"2B"	2014-08-06 18:54:18	2014-08-07 18:54:18	2014-07-21 07:25:11.202394	2014-07-21 07:25:11.202394
21	FA1 Tests	2	Teacher	1	"ids"=>"11", "type"=>"ClassRoom", "names"=>"2B"	2014-08-06 18:54:18	2014-08-07 18:54:18	2014-07-21 07:25:16.030473	2014-07-21 07:25:16.030473
22	FA1 Tests	2	Teacher	1	"ids"=>"11", "type"=>"ClassRoom", "names"=>"2B"	2014-08-06 18:54:18	2014-08-07 18:54:18	2014-07-21 07:25:20.341847	2014-07-21 07:25:20.341847
23	Cricket Match	2	Teacher	1	"ids"=>"6,8", "type"=>"ClassRoom", "names"=>"[\\"1A\\", \\"1C\\"]"	2014-08-02 16:06:06	2014-08-02 17:06:06	2014-07-22 09:36:48.262257	2014-07-22 09:36:48.262257
27	test physics	2	Teacher	1	"ids"=>"6", "type"=>"ClassRoom", "names"=>"1A"	2014-10-08 12:46:37	2014-10-09 12:46:37	2014-10-08 07:19:05.000117	2014-10-08 07:19:05.000117
30	physics test	2	Teacher	1	"ids"=>"11", "type"=>"ClassRoom", "names"=>"2B"	2014-11-18 15:06:35	2014-11-19 15:06:35	2014-11-04 09:37:01.014048	2014-11-04 09:37:01.014048
\.


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('schedules_id_seq', 30, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20140624044500
20140624044512
20140624044525
20140624044499
20140624044529
20140625094526
20140625094527
20140625094638
20140626044342
20140626050817
20140626051359
20140625094525
20140626104746
20140626110551
20140626112433
20140627054907
20140627082051
20140627090323
20140701090511
20140701115309
20140701122320
20140702120319
20140703050351
20140704061323
20140704055233
20140708123448
20140710043219
20140710055044
20140710083249
20140716070342
20140717064520
20140801071156
20140804062745
20140804063157
20140804065750
20140804071841
20140901094211
\.


--
-- Data for Name: school_branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY school_branches (id, name, address, city, state, zip, created_at, updated_at, school_id) FROM stdin;
1	St. Marry Private Limited	\N	\N	\N	\N	2014-06-26 11:02:05.478485	2014-06-26 11:02:05.512784	7
\.


--
-- Name: school_branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('school_branches_id_seq', 1, true);


--
-- Data for Name: school_controllers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY school_controllers (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at, creator_id, creator_type, school_branch_id, manager_id) FROM stdin;
1	john@example.com	$2a$10$rhR.twVQC4s.Pr2hkNCVxe8LvcQ3YRn9KinIvleXUQwImwXHtBC5K	\N	\N	\N	1	2014-06-25 05:03:36.496273	2014-06-25 05:03:36.496273	127.0.0.1	127.0.0.1	\N	\N	\N	\N	0	\N	\N	2014-06-25 05:03:17.315048	2014-06-25 05:03:36.497479	\N	\N	\N	\N
2	naveen@gmail.com	$2a$10$K9PH2QBTRb8QMo/5YvmhBOSTPFKFHGdqHkfztDAMbo.wuicvZPDty	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	2014-06-26 08:20:52.605187	2014-06-26 08:20:52.605187	\N	\N	\N	\N
3	naveen1@gmail.com	$2a$10$EAMRM1qAPQ4WOtTZ2SXRrepbQqNYFGe2wOX1TKAeIrO5O/q4qp3mq	\N	\N	\N	1	2014-06-27 05:18:20.845128	2014-06-27 05:18:20.845128	127.0.0.1	127.0.0.1	\N	\N	\N	\N	0	\N	\N	2014-06-26 11:54:35.461708	2014-06-27 05:18:20.846125	\N	\N	1	2
\.


--
-- Name: school_controllers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('school_controllers_id_seq', 3, true);


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schools (id, name, regestrar_details, school_controller_id, manager_id, created_at, updated_at) FROM stdin;
7	St. Marry Private Limited	"email"=>"naveen@gmail.com", "phone"=>"1234567890", "address"=>"At Home", "last_name"=>"Agarwal", "first_name"=>"Naveen"	2	2	2014-06-26 08:21:56.137785	2014-06-26 08:21:56.137785
\.


--
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('schools_id_seq', 7, true);


--
-- Data for Name: searches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY searches (id, text, searcher_id, searcher_type, result, school_branch_id, created_at, updated_at) FROM stdin;
2	ramesh fa*	2	Teacher	{}	1	2014-07-09 09:42:19.714665	2014-07-09 09:43:18.94163
3	fa1	2	Teacher	{}	1	2014-07-09 09:43:37.0614	2014-07-09 09:43:37.0614
4	fa2	2	Teacher	{}	1	2014-07-09 09:43:44.812026	2014-07-09 09:43:44.812026
5	fa5	2	Teacher	{}	1	2014-07-09 09:43:49.428434	2014-07-09 09:43:49.428434
6	fa4	2	Teacher	{}	1	2014-07-09 09:43:52.340048	2014-07-09 09:43:52.340048
7	fa4 ramesh	2	Teacher	{}	1	2014-07-09 09:46:35.236623	2014-07-09 09:46:35.236623
8	fa4 	2	Teacher	{}	1	2014-07-09 09:46:54.001314	2014-07-09 09:46:54.001314
9	fa4 or ramesh	2	Teacher	{}	1	2014-07-09 09:52:31.01892	2014-07-09 09:52:31.01892
10	ramesh	2	Teacher	{}	1	2014-07-09 09:52:34.749739	2014-07-09 09:52:34.749739
11	ram	2	Teacher	{}	1	2014-07-09 09:53:39.185234	2014-07-09 09:53:39.185234
12	ram*	2	Teacher	{}	1	2014-07-09 09:53:41.285557	2014-07-09 09:53:41.285557
13	Ram*	2	Teacher	{}	1	2014-07-09 09:54:26.294957	2014-07-09 09:54:26.294957
14	ram*, fa1	2	Teacher	{}	1	2014-07-09 09:57:37.307302	2014-07-09 09:57:37.307302
15	ram fa1	2	Teacher	{}	1	2014-07-09 09:59:08.961846	2014-07-09 09:59:08.961846
1	ramesh fa1	2	Teacher	{}	1	2014-07-09 09:41:54.375597	2014-07-09 09:59:12.326369
16	nicole fa*	2	Teacher	{}	1	2014-07-09 10:01:01.659507	2014-07-09 10:01:01.659507
17	nicole fa1	2	Teacher	{}	1	2014-07-09 10:01:05.284485	2014-07-09 10:01:05.284485
18	FA1	2	Teacher	{}	1	2014-07-09 10:17:39.093178	2014-07-09 10:17:39.093178
19	nicole FA1	2	Teacher	{}	1	2014-07-09 10:18:11.720278	2014-07-09 10:18:11.720278
20	ramesh FA1	2	Teacher	{}	1	2014-07-09 10:56:05.043699	2014-07-09 10:56:05.043699
21	ramesh FA*	2	Teacher	{}	1	2014-07-09 10:56:21.422563	2014-07-09 10:56:21.422563
22	physics	2	Teacher	{}	1	2014-07-09 11:03:03.677059	2014-07-09 11:03:03.677059
23	math	2	Teacher	{}	1	2014-07-09 11:06:36.154862	2014-07-09 11:06:36.154862
24	physics maths	2	Teacher	{}	1	2014-07-09 11:08:00.783297	2014-07-09 11:08:00.783297
25	chemistry	2	Teacher	{}	1	2014-07-09 11:08:12.26914	2014-07-09 11:08:12.26914
26	1A	2	Teacher	{}	1	2014-07-09 11:26:56.079847	2014-07-09 11:26:56.079847
27	1	2	Teacher	{}	1	2014-07-09 11:26:58.785976	2014-07-09 11:26:58.785976
28	1B	2	Teacher	{}	1	2014-07-09 11:31:04.646081	2014-07-09 11:31:04.646081
29	1B ramesh	2	Teacher	{}	1	2014-07-09 11:31:54.841115	2014-07-09 11:31:54.841115
30	asd	2	Teacher	{}	1	2014-07-09 11:49:53.657388	2014-07-09 11:49:53.657388
31	12341	2	Teacher	{}	1	2014-07-09 11:53:33.157177	2014-07-09 11:53:33.157177
32	12	2	Teacher	{}	1	2014-07-09 11:58:52.563729	2014-07-09 11:58:52.563729
33	1a	2	Teacher	{}	1	2014-07-09 12:01:09.428395	2014-07-09 12:01:09.428395
34	1A ramesh fa1	2	Teacher	{}	1	2014-07-09 12:04:31.592832	2014-07-09 12:04:31.592832
35	1A pass	2	Teacher	{}	1	2014-07-09 12:14:03.909461	2014-07-09 12:14:03.909461
36	ramesh 1A	2	Teacher	{}	1	2014-07-11 07:33:30.877123	2014-07-11 07:33:30.877123
37	1A ramesh	2	Teacher	{}	1	2014-07-15 11:17:50.765536	2014-07-15 11:17:50.765536
38	1A ramesh suresh	2	Teacher	{}	1	2014-07-15 11:17:56.895006	2014-07-15 11:17:56.895006
39	raminder	2	Teacher	{}	1	2014-10-08 07:19:59.852389	2014-10-08 07:19:59.852389
40	ramesh 1a	2	Teacher	{}	1	2014-11-04 09:42:37.291252	2014-11-04 09:42:37.291252
\.


--
-- Name: searches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('searches_id_seq', 40, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY students (id, name, roll_number, class_room_id, school_branch_id, creator_id, creator_type, created_at, updated_at, year, document_id, mother_name, father_name, address, previous_school, father_phone, mother_phone, email, other_info) FROM stdin;
7	Suresh	2	6	1	2	Teacher	2014-07-04 09:06:04.589146	2014-07-04 09:06:04.589146	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	Dinesh	3	6	1	2	Teacher	2014-07-04 09:06:04.608927	2014-07-04 09:06:04.608927	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	Prakash	4	6	1	2	Teacher	2014-07-04 09:06:04.63137	2014-07-04 09:06:04.63137	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	Satish	5	6	1	2	Teacher	2014-07-04 09:06:04.651487	2014-07-04 09:06:04.651487	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	Abhishek	6	7	1	2	Teacher	2014-07-04 09:06:04.67224	2014-07-04 09:06:04.67224	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	Manmohan	7	7	1	2	Teacher	2014-07-04 09:06:04.692856	2014-07-04 09:06:04.692856	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	Raminder	8	7	1	2	Teacher	2014-07-04 09:06:04.712416	2014-07-04 09:06:04.712416	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	Hemant	9	7	1	2	Teacher	2014-07-04 09:06:04.73365	2014-07-04 09:06:04.73365	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	Shivling	10	8	1	2	Teacher	2014-07-04 09:06:04.757287	2014-07-04 09:06:04.757287	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	Shekar	11	8	1	2	Teacher	2014-07-04 09:06:04.775018	2014-07-04 09:06:04.775018	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	Raman	12	8	1	2	Teacher	2014-07-04 09:06:04.795294	2014-07-04 09:06:04.795294	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	Manoj	13	8	1	2	Teacher	2014-07-04 09:06:04.816926	2014-07-04 09:06:04.816926	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
19	Anuj	14	6	1	2	Teacher	2014-07-04 09:06:04.837206	2014-07-04 09:06:04.837206	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	Swati	15	6	1	2	Teacher	2014-07-04 09:06:04.857466	2014-07-04 09:06:04.857466	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	Rita	16	6	1	2	Teacher	2014-07-04 09:06:04.879436	2014-07-04 09:06:04.879436	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	Mona	17	6	1	2	Teacher	2014-07-04 09:06:04.898036	2014-07-04 09:06:04.898036	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	Pooja	18	7	1	2	Teacher	2014-07-04 09:06:04.918442	2014-07-04 09:06:04.918442	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	Shivani	19	7	1	2	Teacher	2014-07-04 09:06:04.940248	2014-07-04 09:06:04.940248	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	Ritika	20	8	1	2	Teacher	2014-07-04 09:06:04.960107	2014-07-04 09:06:04.960107	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	Ramesh	1	10	1	2	Teacher	2014-07-04 09:30:30.308873	2014-07-04 09:30:30.308873	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	Suresh	2	10	1	2	Teacher	2014-07-04 09:30:30.345617	2014-07-04 09:30:30.345617	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	Dinesh	3	10	1	2	Teacher	2014-07-04 09:30:30.367656	2014-07-04 09:30:30.367656	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
29	Prakash	4	10	1	2	Teacher	2014-07-04 09:30:30.387989	2014-07-04 09:30:30.387989	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
30	Satish	5	10	1	2	Teacher	2014-07-04 09:30:30.407404	2014-07-04 09:30:30.407404	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
31	Abhishek	6	11	1	2	Teacher	2014-07-04 09:30:30.432465	2014-07-04 09:30:30.432465	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
32	Manmohan	7	11	1	2	Teacher	2014-07-04 09:30:30.448122	2014-07-04 09:30:30.448122	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	Raminder	8	11	1	2	Teacher	2014-07-04 09:30:30.469686	2014-07-04 09:30:30.469686	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	Hemant	9	11	1	2	Teacher	2014-07-04 09:30:30.489621	2014-07-04 09:30:30.489621	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	Shivling	10	11	1	2	Teacher	2014-07-04 09:30:30.512322	2014-07-04 09:30:30.512322	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
36	Shekar	11	11	1	2	Teacher	2014-07-04 09:30:30.531325	2014-07-04 09:30:30.531325	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	Raman	12	11	1	2	Teacher	2014-07-04 09:30:30.553712	2014-07-04 09:30:30.553712	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	Manoj	13	10	1	2	Teacher	2014-07-04 09:30:30.57283	2014-07-04 09:30:30.57283	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	Anuj	14	10	1	2	Teacher	2014-07-04 09:30:30.592867	2014-07-04 09:30:30.592867	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	Swati	15	10	1	2	Teacher	2014-07-04 09:30:30.614915	2014-07-04 09:30:30.614915	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	Rita	16	10	1	2	Teacher	2014-07-04 09:30:30.634656	2014-07-04 09:30:30.634656	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	Mona	17	10	1	2	Teacher	2014-07-04 09:30:30.65496	2014-07-04 09:30:30.65496	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	Pooja	18	11	1	2	Teacher	2014-07-04 09:30:30.678949	2014-07-04 09:30:30.678949	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	Shivani	19	11	1	2	Teacher	2014-07-04 09:30:30.69613	2014-07-04 09:30:30.69613	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	Ritika	20	11	1	2	Teacher	2014-07-04 09:30:30.717679	2014-07-04 09:30:30.717679	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	Ramesh	1	12	1	2	Teacher	2014-07-04 09:30:30.742801	2014-07-04 09:30:30.742801	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	Suresh	2	12	1	2	Teacher	2014-07-04 09:30:30.761028	2014-07-04 09:30:30.761028	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	Dinesh	3	12	1	2	Teacher	2014-07-04 09:30:30.781463	2014-07-04 09:30:30.781463	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	Prakash	4	12	1	2	Teacher	2014-07-04 09:30:30.802739	2014-07-04 09:30:30.802739	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	Satish	5	12	1	2	Teacher	2014-07-04 09:30:30.823823	2014-07-04 09:30:30.823823	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	Abhishek	6	13	1	2	Teacher	2014-07-04 09:30:30.845263	2014-07-04 09:30:30.845263	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	Manmohan	7	13	1	2	Teacher	2014-07-04 09:30:30.865461	2014-07-04 09:30:30.865461	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	Raminder	8	13	1	2	Teacher	2014-07-04 09:30:30.885552	2014-07-04 09:30:30.885552	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	Hemant	9	13	1	2	Teacher	2014-07-04 09:30:30.90756	2014-07-04 09:30:30.90756	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	Shivling	10	14	1	2	Teacher	2014-07-04 09:30:30.92987	2014-07-04 09:30:30.92987	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	Shekar	11	14	1	2	Teacher	2014-07-04 09:30:30.949024	2014-07-04 09:30:30.949024	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	Raman	12	14	1	2	Teacher	2014-07-04 09:30:30.969691	2014-07-04 09:30:30.969691	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	Manoj	13	14	1	2	Teacher	2014-07-04 09:30:30.989979	2014-07-04 09:30:30.989979	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	Anuj	14	12	1	2	Teacher	2014-07-04 09:30:31.013732	2014-07-04 09:30:31.013732	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	Swati	15	12	1	2	Teacher	2014-07-04 09:30:31.031575	2014-07-04 09:30:31.031575	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	Rita	16	12	1	2	Teacher	2014-07-04 09:30:31.0539	2014-07-04 09:30:31.0539	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	Mona	17	12	1	2	Teacher	2014-07-04 09:30:31.07463	2014-07-04 09:30:31.07463	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	Pooja	18	13	1	2	Teacher	2014-07-04 09:30:31.095501	2014-07-04 09:30:31.095501	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	Shivani	19	13	1	2	Teacher	2014-07-04 09:30:31.116154	2014-07-04 09:30:31.116154	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	Ritika	20	14	1	2	Teacher	2014-07-04 09:30:31.137996	2014-07-04 09:30:31.137996	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	Ramesh	1	15	1	2	Teacher	2014-07-04 09:30:31.160746	2014-07-04 09:30:31.160746	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	Suresh	2	15	1	2	Teacher	2014-07-04 09:30:31.178201	2014-07-04 09:30:31.178201	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	Dinesh	3	15	1	2	Teacher	2014-07-04 09:30:31.199842	2014-07-04 09:30:31.199842	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	Prakash	4	15	1	2	Teacher	2014-07-04 09:30:31.220086	2014-07-04 09:30:31.220086	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	Satish	5	15	1	2	Teacher	2014-07-04 09:30:31.241749	2014-07-04 09:30:31.241749	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	Abhishek	6	16	1	2	Teacher	2014-07-04 09:30:31.263635	2014-07-04 09:30:31.263635	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	Manmohan	7	16	1	2	Teacher	2014-07-04 09:30:31.283915	2014-07-04 09:30:31.283915	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	Raminder	8	16	1	2	Teacher	2014-07-04 09:30:31.304476	2014-07-04 09:30:31.304476	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	Hemant	9	16	1	2	Teacher	2014-07-04 09:30:31.325908	2014-07-04 09:30:31.325908	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	Shivling	10	17	1	2	Teacher	2014-07-04 09:30:31.348408	2014-07-04 09:30:31.348408	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	Shekar	11	17	1	2	Teacher	2014-07-04 09:30:31.366554	2014-07-04 09:30:31.366554	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	Raman	12	17	1	2	Teacher	2014-07-04 09:30:31.3886	2014-07-04 09:30:31.3886	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	Manoj	13	17	1	2	Teacher	2014-07-04 09:30:31.40901	2014-07-04 09:30:31.40901	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	Anuj	14	15	1	2	Teacher	2014-07-04 09:30:31.430716	2014-07-04 09:30:31.430716	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	Swati	15	15	1	2	Teacher	2014-07-04 09:30:31.450846	2014-07-04 09:30:31.450846	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	Rita	16	15	1	2	Teacher	2014-07-04 09:30:31.472302	2014-07-04 09:30:31.472302	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	Mona	17	15	1	2	Teacher	2014-07-04 09:30:31.492443	2014-07-04 09:30:31.492443	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	Pooja	18	16	1	2	Teacher	2014-07-04 09:30:31.514381	2014-07-04 09:30:31.514381	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	Shivani	19	16	1	2	Teacher	2014-07-04 09:30:31.534384	2014-07-04 09:30:31.534384	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	Ritika	20	17	1	2	Teacher	2014-07-04 09:30:31.554657	2014-07-04 09:30:31.554657	2014-2015	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	Ramesh	1	26	1	2	Teacher	2014-07-04 11:08:47.916864	2014-07-04 11:08:47.916864	2014-2015	11	\N	\N	\N	\N	\N	\N	\N	\N
87	Suresh	2	26	1	2	Teacher	2014-07-04 11:08:47.961053	2014-07-04 11:08:47.961053	2014-2015	11	\N	\N	\N	\N	\N	\N	\N	\N
6	Ramesh Sharma	1	6	1	2	Teacher	2014-07-04 09:06:04.568543	2014-07-10 08:48:47.380808	2014-2015	\N	Kulwant Sharma	Jessy Sharma	Parsk street, 7th Avenue	M.M. Public School	1234567890	1234567890	ramesh@gmail.com	This is just the test info
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('students_id_seq', 87, true);


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subjects (id, name, school_branch_id, creator_id, creator_type, created_at, updated_at, document_id) FROM stdin;
1	Maths	1	2	Teacher	2014-06-27 06:00:23.802042	2014-06-27 06:00:23.802042	\N
2	Physics	1	2	Teacher	2014-06-27 06:00:38.661408	2014-06-27 06:00:38.661408	\N
3	Chemistry	1	2	Teacher	2014-06-27 06:00:47.269172	2014-06-27 06:00:47.269172	\N
4	Biology	1	2	Teacher	2014-06-27 06:00:58.726956	2014-06-27 06:00:58.726956	\N
5	English	1	2	Teacher	2014-06-27 06:01:10.161048	2014-06-27 06:01:10.161048	\N
6	Computer Science	1	2	Teacher	2014-06-27 06:01:20.365718	2014-06-27 06:01:20.365718	\N
24	Sanskrit	1	2	Teacher	2014-07-04 10:45:14.06378	2014-07-04 10:45:14.06378	7
25	Veda's	1	2	Teacher	2014-07-04 10:45:14.101632	2014-07-04 10:45:14.101632	7
26	Physical Education	1	2	Teacher	2014-07-04 10:45:14.126487	2014-07-04 10:45:14.126487	7
27	Computers	1	2	Teacher	2014-07-04 10:45:14.144035	2014-07-04 10:45:14.144035	7
28	Arts	1	2	Teacher	2014-07-04 10:45:14.170506	2014-07-04 10:45:14.170506	7
29	Accounts	1	2	Teacher	2014-07-04 10:45:14.193462	2014-07-04 10:45:14.193462	7
30	Economics	1	2	Teacher	2014-07-04 10:45:14.2153	2014-07-04 10:45:14.2153	7
31	Civics	1	2	Teacher	2014-07-04 10:45:14.236509	2014-07-04 10:45:14.236509	7
32	Geography	1	2	Teacher	2014-07-04 10:45:14.258001	2014-07-04 10:45:14.258001	7
33	History	1	2	Teacher	2014-07-04 10:45:14.278808	2014-07-04 10:45:14.278808	7
34	Science	1	2	Teacher	2014-07-04 10:45:14.301175	2014-07-04 10:45:14.301175	7
35	Drawing	1	2	Teacher	2014-07-04 10:45:14.330742	2014-07-04 10:45:14.330742	7
36	Engineering Drawing	1	2	Teacher	2014-07-04 11:05:47.882393	2014-07-04 11:05:47.882393	10
\.


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('subjects_id_seq', 36, true);


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teachers (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at, creator_id, creator_type, school_id, school_branch_id) FROM stdin;
2	teacher@gmail.com	$2a$10$vLT9saSuO5IgdOxzIAMZPe5Rh.ACNmhnxzJOVHKvCGjjRzUbeaagu	\N	\N	2014-11-04 09:31:44.045281	22	2014-11-04 09:31:44.370731	2014-10-08 07:09:31.518714	127.0.0.1	192.168.11.68	\N	\N	\N	\N	0	\N	\N	2014-06-27 05:23:26.383885	2014-11-04 09:31:44.372465	3	SchoolController	7	1
1	sandra@howismyschool.com	$2a$10$BHcUDVV5ApTGarFsL7m2luBGXZoFGPfunxVcj4zZrhlf0DOtqZBIG	\N	\N	\N	7	2014-06-25 08:38:13.637943	2014-06-25 05:01:39.02944	127.0.0.1	127.0.0.1	\N	\N	\N	\N	0	\N	\N	2014-06-24 05:14:34.742688	2014-06-26 11:41:47.338528	\N	\N	\N	\N
\.


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('teachers_id_seq', 2, true);


--
-- Data for Name: test_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY test_results (id, percentage, grade, outcome, remarks, subject_id, student_id, class_test_id, school_branch_id, class_room_id, creator_id, creator_type, created_at, updated_at, year, test_results_from_file_id, class_room_name, class_test_name, student_name, subject_name) FROM stdin;
158	86	A	t	\N	2	29	5	1	10	2	Teacher	2014-07-07 11:51:40.92748	2014-07-10 06:19:10.729569	2013-2014	14	2A	FA2	Prakash - 4	Physics
330	86	A	t	\N	2	29	5	1	10	2	Teacher	2014-07-10 06:19:23.721894	2014-07-10 06:19:23.721894	2014-2015	14	2A	FA2	Prakash - 4	Physics
331	66	A	t	\N	2	29	5	1	10	2	Teacher	2014-07-15 09:35:20.422096	2014-07-15 09:35:20.422096	2012-2013	14	2A	FA2	Prakash - 4	Physics
332	70	\N	t	\N	2	30	5	1	10	2	Teacher	2014-07-15 09:35:20.652082	2014-07-15 09:35:20.652082	2013-2014	14	2A	FA2	Satish - 5	Physics
333	60	\N	t	\N	2	30	5	1	10	2	Teacher	2014-07-15 09:35:20.677563	2014-07-15 09:35:20.677563	2012-2013	14	2A	FA2	Satish - 5	Physics
334	72	\N	t	\N	2	38	5	1	10	2	Teacher	2014-07-15 09:35:20.708707	2014-07-15 09:35:20.708707	2013-2014	14	2A	FA2	Manoj - 13	Physics
335	62	\N	t	\N	2	38	5	1	10	2	Teacher	2014-07-15 09:35:20.735682	2014-07-15 09:35:20.735682	2012-2013	14	2A	FA2	Manoj - 13	Physics
336	63	\N	t	\N	2	39	5	1	10	2	Teacher	2014-07-15 09:35:20.766768	2014-07-15 09:35:20.766768	2013-2014	14	2A	FA2	Anuj - 14	Physics
337	53	\N	t	\N	2	39	5	1	10	2	Teacher	2014-07-15 09:35:20.79591	2014-07-15 09:35:20.79591	2012-2013	14	2A	FA2	Anuj - 14	Physics
338	37	\N	f	\N	2	40	5	1	10	2	Teacher	2014-07-15 09:35:20.824651	2014-07-15 09:35:20.824651	2013-2014	14	2A	FA2	Swati - 15	Physics
159	80	\N	t	\N	2	30	5	1	10	2	Teacher	2014-07-07 11:51:40.960277	2014-07-10 06:02:26.326602	2014-2015	14	2A	FA2	Satish - 5	Physics
160	82	\N	t	\N	2	38	5	1	10	2	Teacher	2014-07-07 11:51:40.986934	2014-07-10 06:02:26.354647	2014-2015	14	2A	FA2	Manoj - 13	Physics
161	73	\N	t	\N	2	39	5	1	10	2	Teacher	2014-07-07 11:51:41.014971	2014-07-10 06:02:26.37531	2014-2015	14	2A	FA2	Anuj - 14	Physics
162	27	\N	f	\N	2	40	5	1	10	2	Teacher	2014-07-07 11:51:41.048505	2014-07-10 06:02:26.401836	2014-2015	14	2A	FA2	Swati - 15	Physics
163	5	\N	f	\N	2	41	5	1	10	2	Teacher	2014-07-07 11:51:41.086935	2014-07-10 06:02:26.42825	2014-2015	14	2A	FA2	Rita - 16	Physics
164	78	\N	t	\N	3	26	5	1	10	2	Teacher	2014-07-07 11:51:41.112239	2014-07-10 06:02:26.456753	2014-2015	14	2A	FA2	Ramesh - 1	Chemistry
165	49	\N	t	\N	3	27	5	1	10	2	Teacher	2014-07-07 11:51:41.144781	2014-07-10 06:02:26.477757	2014-2015	14	2A	FA2	Suresh - 2	Chemistry
166	96	\N	t	\N	3	28	5	1	10	2	Teacher	2014-07-07 11:51:41.17349	2014-07-10 06:02:26.498931	2014-2015	14	2A	FA2	Dinesh - 3	Chemistry
167	30	\N	f	\N	3	29	5	1	10	2	Teacher	2014-07-07 11:51:41.202753	2014-07-10 06:02:26.522155	2014-2015	14	2A	FA2	Prakash - 4	Chemistry
168	19	\N	f	\N	3	30	5	1	10	2	Teacher	2014-07-07 11:51:41.230617	2014-07-10 06:02:26.541349	2014-2015	14	2A	FA2	Satish - 5	Chemistry
169	82	\N	t	\N	3	38	5	1	10	2	Teacher	2014-07-07 11:51:41.257028	2014-07-10 06:02:26.562728	2014-2015	14	2A	FA2	Manoj - 13	Chemistry
170	59	\N	t	\N	3	39	5	1	10	2	Teacher	2014-07-07 11:51:41.289501	2014-07-10 06:02:26.585281	2014-2015	14	2A	FA2	Anuj - 14	Chemistry
171	31	\N	f	\N	3	40	5	1	10	2	Teacher	2014-07-07 11:51:41.318285	2014-07-10 06:02:26.605102	2014-2015	14	2A	FA2	Swati - 15	Chemistry
172	78	\N	t	\N	3	41	5	1	10	2	Teacher	2014-07-07 11:51:41.349814	2014-07-10 06:02:26.62862	2014-2015	14	2A	FA2	Rita - 16	Chemistry
173	76	\N	t	\N	1	26	6	1	10	2	Teacher	2014-07-07 11:51:41.379173	2014-07-10 06:02:26.647652	2014-2015	14	2A	FA3	Ramesh - 1	Maths
174	63	\N	t	\N	1	27	6	1	10	2	Teacher	2014-07-07 11:51:41.407953	2014-07-10 06:02:26.674572	2014-2015	14	2A	FA3	Suresh - 2	Maths
175	84	\N	t	\N	1	28	6	1	10	2	Teacher	2014-07-07 11:51:41.436925	2014-07-10 06:02:26.694356	2014-2015	14	2A	FA3	Dinesh - 3	Maths
176	76	\N	t	\N	1	29	6	1	10	2	Teacher	2014-07-07 11:51:41.468674	2014-07-10 06:02:26.716269	2014-2015	14	2A	FA3	Prakash - 4	Maths
177	27	\N	f	\N	1	30	6	1	10	2	Teacher	2014-07-07 11:51:41.49874	2014-07-10 06:02:26.73852	2014-2015	14	2A	FA3	Satish - 5	Maths
178	72	\N	t	\N	1	38	6	1	10	2	Teacher	2014-07-07 11:51:41.524384	2014-07-10 06:02:26.758977	2014-2015	14	2A	FA3	Manoj - 13	Maths
179	57	\N	t	\N	1	39	6	1	10	2	Teacher	2014-07-07 11:51:41.552676	2014-07-10 06:02:26.783631	2014-2015	14	2A	FA3	Anuj - 14	Maths
180	18	\N	f	\N	1	40	6	1	10	2	Teacher	2014-07-07 11:51:41.581283	2014-07-10 06:02:26.81017	2014-2015	14	2A	FA3	Swati - 15	Maths
181	100	\N	t	\N	1	41	6	1	10	2	Teacher	2014-07-07 11:51:41.61417	2014-07-10 06:02:26.831012	2014-2015	14	2A	FA3	Rita - 16	Maths
182	100	\N	t	\N	2	26	6	1	10	2	Teacher	2014-07-07 11:51:41.641087	2014-07-10 06:02:26.855858	2014-2015	14	2A	FA3	Ramesh - 1	Physics
183	100	\N	t	\N	2	27	6	1	10	2	Teacher	2014-07-07 11:51:41.672231	2014-07-10 06:02:26.883271	2014-2015	14	2A	FA3	Suresh - 2	Physics
184	63	\N	t	\N	2	28	6	1	10	2	Teacher	2014-07-07 11:51:41.701103	2014-07-10 06:02:26.904008	2014-2015	14	2A	FA3	Dinesh - 3	Physics
185	85	\N	t	\N	2	29	6	1	10	2	Teacher	2014-07-07 11:51:41.729609	2014-07-10 06:02:26.926031	2014-2015	14	2A	FA3	Prakash - 4	Physics
186	98	\N	t	\N	2	30	6	1	10	2	Teacher	2014-07-07 11:51:41.756731	2014-07-10 06:02:26.948749	2014-2015	14	2A	FA3	Satish - 5	Physics
187	41	\N	t	\N	2	38	6	1	10	2	Teacher	2014-07-07 11:51:41.789029	2014-07-10 06:02:26.967003	2014-2015	14	2A	FA3	Manoj - 13	Physics
188	11	\N	f	\N	2	39	6	1	10	2	Teacher	2014-07-07 11:51:41.819738	2014-07-10 06:02:26.989994	2014-2015	14	2A	FA3	Anuj - 14	Physics
189	8	\N	f	\N	2	40	6	1	10	2	Teacher	2014-07-07 11:51:41.846421	2014-07-10 06:02:27.010525	2014-2015	14	2A	FA3	Swati - 15	Physics
190	76	\N	t	\N	2	41	6	1	10	2	Teacher	2014-07-07 11:51:41.879818	2014-07-10 06:02:27.033929	2014-2015	14	2A	FA3	Rita - 16	Physics
191	37	\N	f	\N	3	26	6	1	10	2	Teacher	2014-07-07 11:51:41.920281	2014-07-10 06:02:27.052338	2014-2015	14	2A	FA3	Ramesh - 1	Chemistry
192	96	\N	t	\N	3	27	6	1	10	2	Teacher	2014-07-07 11:51:41.951378	2014-07-10 06:02:27.076735	2014-2015	14	2A	FA3	Suresh - 2	Chemistry
193	46	\N	t	\N	3	28	6	1	10	2	Teacher	2014-07-07 11:51:41.999405	2014-07-10 06:02:27.096884	2014-2015	14	2A	FA3	Dinesh - 3	Chemistry
194	16	\N	f	\N	3	29	6	1	10	2	Teacher	2014-07-07 11:51:42.032159	2014-07-10 06:02:27.116997	2014-2015	14	2A	FA3	Prakash - 4	Chemistry
195	71	\N	t	\N	3	30	6	1	10	2	Teacher	2014-07-07 11:51:42.072743	2014-07-10 06:02:27.137694	2014-2015	14	2A	FA3	Satish - 5	Chemistry
196	54	\N	t	\N	3	38	6	1	10	2	Teacher	2014-07-07 11:51:42.105901	2014-07-10 06:02:27.160256	2014-2015	14	2A	FA3	Manoj - 13	Chemistry
197	82	\N	t	\N	3	39	6	1	10	2	Teacher	2014-07-07 11:51:42.136939	2014-07-10 06:02:27.180848	2014-2015	14	2A	FA3	Anuj - 14	Chemistry
198	22	\N	f	\N	3	40	6	1	10	2	Teacher	2014-07-07 11:51:42.17369	2014-07-10 06:02:27.202401	2014-2015	14	2A	FA3	Swati - 15	Chemistry
199	2	\N	f	\N	3	41	6	1	10	2	Teacher	2014-07-07 11:51:42.198965	2014-07-10 06:02:27.225178	2014-2015	14	2A	FA3	Rita - 16	Chemistry
38	76	\N	t	Set the remarks here	2	6	4	1	6	2	Teacher	2014-07-04 10:02:25.244917	2014-07-10 06:02:27.928304	2014-2015	6	1A	FA1	Ramesh Sharma - 1	Physics
339	47	\N	f	\N	2	40	5	1	10	2	Teacher	2014-07-15 09:35:20.855977	2014-07-15 09:35:20.855977	2012-2013	14	2A	FA2	Swati - 15	Physics
340	15	\N	f	\N	2	41	5	1	10	2	Teacher	2014-07-15 09:35:20.884312	2014-07-15 09:35:20.884312	2013-2014	14	2A	FA2	Rita - 16	Physics
341	25	\N	f	\N	2	41	5	1	10	2	Teacher	2014-07-15 09:35:20.916252	2014-07-15 09:35:20.916252	2012-2013	14	2A	FA2	Rita - 16	Physics
342	68	\N	t	\N	3	26	5	1	10	2	Teacher	2014-07-15 09:35:20.944335	2014-07-15 09:35:20.944335	2013-2014	14	2A	FA2	Ramesh - 1	Chemistry
120	22	\N	f	\N	1	27	4	1	10	2	Teacher	2014-07-07 11:51:39.21303	2014-07-10 06:02:27.307107	2014-2015	14	2A	FA1	Suresh - 2	Maths
122	14	\N	f	\N	1	29	4	1	10	2	Teacher	2014-07-07 11:51:39.349255	2014-07-10 06:02:27.352126	2014-2015	14	2A	FA1	Prakash - 4	Maths
123	90	\N	t	\N	1	30	4	1	10	2	Teacher	2014-07-07 11:51:39.429542	2014-07-10 06:02:27.372563	2014-2015	14	2A	FA1	Satish - 5	Maths
124	81	\N	t	\N	1	38	4	1	10	2	Teacher	2014-07-07 11:51:39.573754	2014-07-10 06:02:27.394067	2014-2015	14	2A	FA1	Manoj - 13	Maths
125	69	\N	t	\N	1	39	4	1	10	2	Teacher	2014-07-07 11:51:39.612392	2014-07-10 06:02:27.415272	2014-2015	14	2A	FA1	Anuj - 14	Maths
127	50	\N	t	\N	1	41	4	1	10	2	Teacher	2014-07-07 11:51:39.69171	2014-07-10 06:02:27.458069	2014-2015	14	2A	FA1	Rita - 16	Maths
128	76	\N	t	\N	2	26	4	1	10	2	Teacher	2014-07-07 11:51:39.727915	2014-07-10 06:02:27.47869	2014-2015	14	2A	FA1	Ramesh - 1	Physics
129	100	\N	t	\N	2	27	4	1	10	2	Teacher	2014-07-07 11:51:39.766123	2014-07-10 06:02:27.499847	2014-2015	14	2A	FA1	Suresh - 2	Physics
131	8	\N	f	\N	2	29	4	1	10	2	Teacher	2014-07-07 11:51:39.860733	2014-07-10 06:02:27.541408	2014-2015	14	2A	FA1	Prakash - 4	Physics
132	39	\N	f	\N	2	30	4	1	10	2	Teacher	2014-07-07 11:51:39.908191	2014-07-10 06:02:27.568708	2014-2015	14	2A	FA1	Satish - 5	Physics
133	8	\N	f	\N	2	38	4	1	10	2	Teacher	2014-07-07 11:51:39.951551	2014-07-10 06:02:27.592435	2014-2015	14	2A	FA1	Manoj - 13	Physics
134	35	\N	f	\N	2	39	4	1	10	2	Teacher	2014-07-07 11:51:39.993375	2014-07-10 06:02:27.615227	2014-2015	14	2A	FA1	Anuj - 14	Physics
58	43	\N	t	Set the remarks here	1	8	5	1	6	2	Teacher	2014-07-04 10:02:25.935101	2014-07-10 06:02:27.662222	2014-2015	6	1A	FA2	Dinesh - 3	Maths
59	36	\N	f	Set the remarks here	1	9	5	1	6	2	Teacher	2014-07-04 10:02:25.970334	2014-07-10 06:02:27.68207	2014-2015	6	1A	FA2	Prakash - 4	Maths
60	49	\N	t	Set the remarks here	1	10	5	1	6	2	Teacher	2014-07-04 10:02:26.000943	2014-07-10 06:02:27.710613	2014-2015	6	1A	FA2	Satish - 5	Maths
30	62	\N	t	Set the remarks here	1	7	4	1	6	2	Teacher	2014-07-04 10:02:24.919039	2014-07-10 06:02:27.7571	2014-2015	6	1A	FA1	Suresh - 2	Maths
31	30	\N	f	Set the remarks here	1	8	4	1	6	2	Teacher	2014-07-04 10:02:24.961782	2014-07-10 06:02:27.781464	2014-2015	6	1A	FA1	Dinesh - 3	Maths
32	14	\N	f	Set the remarks here	1	9	4	1	6	2	Teacher	2014-07-04 10:02:24.994403	2014-07-10 06:02:27.80273	2014-2015	6	1A	FA1	Prakash - 4	Maths
33	4	\N	f	Set the remarks here	1	10	4	1	6	2	Teacher	2014-07-04 10:02:25.039698	2014-07-10 06:02:27.824347	2014-2015	6	1A	FA1	Satish - 5	Maths
34	81	\N	t	Set the remarks here	1	19	4	1	6	2	Teacher	2014-07-04 10:02:25.081732	2014-07-10 06:02:27.845065	2014-2015	6	1A	FA1	Anuj - 14	Maths
36	92	\N	t	Set the remarks here	1	21	4	1	6	2	Teacher	2014-07-04 10:02:25.151832	2014-07-10 06:02:27.885983	2014-2015	6	1A	FA1	Rita - 16	Maths
37	50	\N	t	Set the remarks here	1	22	4	1	6	2	Teacher	2014-07-04 10:02:25.187022	2014-07-10 06:02:27.907333	2014-2015	6	1A	FA1	Mona - 17	Maths
39	48	\N	t	Set the remarks here	2	7	4	1	6	2	Teacher	2014-07-04 10:02:25.275573	2014-07-10 06:02:27.949945	2014-2015	6	1A	FA1	Suresh - 2	Physics
41	8	\N	f	Set the remarks here	2	9	4	1	6	2	Teacher	2014-07-04 10:02:25.332918	2014-07-10 06:02:27.994084	2014-2015	6	1A	FA1	Prakash - 4	Physics
42	39	\N	f	Set the remarks here	2	10	4	1	6	2	Teacher	2014-07-04 10:02:25.36165	2014-07-10 06:02:28.012306	2014-2015	6	1A	FA1	Satish - 5	Physics
43	8	\N	f	Set the remarks here	2	19	4	1	6	2	Teacher	2014-07-04 10:02:25.39105	2014-07-10 06:02:28.033403	2014-2015	6	1A	FA1	Anuj - 14	Physics
44	35	\N	f	Set the remarks here	2	20	4	1	6	2	Teacher	2014-07-04 10:02:25.420645	2014-07-10 06:02:28.058894	2014-2015	6	1A	FA1	Swati - 15	Physics
46	0	\N	f	Set the remarks here	2	22	4	1	6	2	Teacher	2014-07-04 10:02:25.488086	2014-07-10 06:02:28.114837	2014-2015	6	1A	FA1	Mona - 17	Physics
48	30	\N	f	Set the remarks here	3	7	4	1	6	2	Teacher	2014-07-04 10:02:25.586406	2014-07-10 06:02:28.163826	2014-2015	6	1A	FA1	Suresh - 2	Chemistry
49	57	\N	t	Set the remarks here	3	8	4	1	6	2	Teacher	2014-07-04 10:02:25.61488	2014-07-10 06:02:28.185205	2014-2015	6	1A	FA1	Dinesh - 3	Chemistry
51	49	\N	t	Set the remarks here	3	10	4	1	6	2	Teacher	2014-07-04 10:02:25.676295	2014-07-10 06:02:28.225995	2014-2015	6	1A	FA1	Satish - 5	Chemistry
52	84	\N	t	Set the remarks here	3	19	4	1	6	2	Teacher	2014-07-04 10:02:25.726618	2014-07-10 06:02:28.247858	2014-2015	6	1A	FA1	Anuj - 14	Chemistry
53	71	\N	t	Set the remarks here	3	20	4	1	6	2	Teacher	2014-07-04 10:02:25.757946	2014-07-10 06:02:28.270381	2014-2015	6	1A	FA1	Swati - 15	Chemistry
55	50	\N	t	Set the remarks here	3	22	4	1	6	2	Teacher	2014-07-04 10:02:25.81935	2014-07-10 06:02:28.310422	2014-2015	6	1A	FA1	Mona - 17	Chemistry
57	50	\N	t	Set the remarks here	1	7	5	1	6	2	Teacher	2014-07-04 10:02:25.888077	2014-07-10 06:02:28.353407	2014-2015	6	1A	FA2	Suresh - 2	Maths
61	96	\N	t	Set the remarks here	1	19	5	1	6	2	Teacher	2014-07-04 10:02:26.03864	2014-07-10 06:02:28.372742	2014-2015	6	1A	FA2	Anuj - 14	Maths
62	92	\N	t	Set the remarks here	1	20	5	1	6	2	Teacher	2014-07-04 10:02:26.073926	2014-07-10 06:02:28.39468	2014-2015	6	1A	FA2	Swati - 15	Maths
64	21	\N	f	Set the remarks here	1	22	5	1	6	2	Teacher	2014-07-04 10:02:26.129397	2014-07-10 06:02:28.450839	2014-2015	6	1A	FA2	Mona - 17	Maths
66	81	\N	t	Set the remarks here	2	7	5	1	6	2	Teacher	2014-07-04 10:02:26.194533	2014-07-10 06:02:28.520222	2014-2015	6	1A	FA2	Suresh - 2	Physics
67	9	\N	f	Set the remarks here	2	8	5	1	6	2	Teacher	2014-07-04 10:02:26.223913	2014-07-10 06:02:28.543268	2014-2015	6	1A	FA2	Dinesh - 3	Physics
69	80	\N	t	Set the remarks here	2	10	5	1	6	2	Teacher	2014-07-04 10:02:26.289269	2014-07-10 06:02:28.60253	2014-2015	6	1A	FA2	Satish - 5	Physics
70	82	\N	t	Set the remarks here	2	19	5	1	6	2	Teacher	2014-07-04 10:02:26.31677	2014-07-10 06:02:28.630648	2014-2015	6	1A	FA2	Anuj - 14	Physics
71	73	\N	t	Set the remarks here	2	20	5	1	6	2	Teacher	2014-07-04 10:02:26.351508	2014-07-10 06:02:28.650035	2014-2015	6	1A	FA2	Swati - 15	Physics
47	75	\N	t	Set the remarks here	3	6	4	1	6	2	Teacher	2014-07-04 10:02:25.558732	2014-07-10 06:02:28.141684	2014-2015	6	1A	FA1	Ramesh Sharma - 1	Chemistry
73	5	\N	f	Set the remarks here	2	22	5	1	6	2	Teacher	2014-07-04 10:02:26.425493	2014-07-10 06:02:28.694185	2014-2015	6	1A	FA2	Mona - 17	Physics
75	49	\N	t	Set the remarks here	3	7	5	1	6	2	Teacher	2014-07-04 10:02:26.504804	2014-07-10 06:02:28.742787	2014-2015	6	1A	FA2	Suresh - 2	Chemistry
77	30	\N	f	Set the remarks here	3	9	5	1	6	2	Teacher	2014-07-04 10:02:26.570631	2014-07-10 06:02:28.786003	2014-2015	6	1A	FA2	Prakash - 4	Chemistry
78	19	\N	f	Set the remarks here	3	10	5	1	6	2	Teacher	2014-07-04 10:02:26.60037	2014-07-10 06:02:28.805274	2014-2015	6	1A	FA2	Satish - 5	Chemistry
79	82	\N	t	Set the remarks here	3	19	5	1	6	2	Teacher	2014-07-04 10:02:26.628603	2014-07-10 06:02:28.827832	2014-2015	6	1A	FA2	Anuj - 14	Chemistry
80	59	\N	t	Set the remarks here	3	20	5	1	6	2	Teacher	2014-07-04 10:02:26.659137	2014-07-10 06:02:28.848606	2014-2015	6	1A	FA2	Swati - 15	Chemistry
82	78	\N	t	Set the remarks here	3	22	5	1	6	2	Teacher	2014-07-04 10:02:26.728314	2014-07-10 06:02:28.889619	2014-2015	6	1A	FA2	Mona - 17	Chemistry
84	63	\N	t	Set the remarks here	1	7	6	1	6	2	Teacher	2014-07-04 10:02:26.807403	2014-07-10 06:02:28.942956	2014-2015	6	1A	FA3	Suresh - 2	Maths
85	84	\N	t	Set the remarks here	1	8	6	1	6	2	Teacher	2014-07-04 10:02:26.843703	2014-07-10 06:02:28.960855	2014-2015	6	1A	FA3	Dinesh - 3	Maths
87	27	\N	f	Set the remarks here	1	10	6	1	6	2	Teacher	2014-07-04 10:02:26.903233	2014-07-10 06:02:29.00608	2014-2015	6	1A	FA3	Satish - 5	Maths
88	72	\N	t	Set the remarks here	1	19	6	1	6	2	Teacher	2014-07-04 10:02:26.929804	2014-07-10 06:02:29.034358	2014-2015	6	1A	FA3	Anuj - 14	Maths
89	57	\N	t	Set the remarks here	1	20	6	1	6	2	Teacher	2014-07-04 10:02:26.964002	2014-07-10 06:02:29.063189	2014-2015	6	1A	FA3	Swati - 15	Maths
90	18	\N	f	Set the remarks here	1	21	6	1	6	2	Teacher	2014-07-04 10:02:26.999732	2014-07-10 06:02:29.083201	2014-2015	6	1A	FA3	Rita - 16	Maths
91	57	\N	t	Set the remarks here	1	22	6	1	6	2	Teacher	2014-07-04 10:02:27.02815	2014-07-10 06:02:29.106584	2014-2015	6	1A	FA3	Mona - 17	Maths
93	76	\N	t	Set the remarks here	2	7	6	1	6	2	Teacher	2014-07-04 10:02:27.083417	2014-07-10 06:02:29.154023	2014-2015	6	1A	FA3	Suresh - 2	Physics
94	63	\N	t	Set the remarks here	2	8	6	1	6	2	Teacher	2014-07-04 10:02:27.112366	2014-07-10 06:02:29.174488	2014-2015	6	1A	FA3	Dinesh - 3	Physics
95	85	\N	t	Set the remarks here	2	9	6	1	6	2	Teacher	2014-07-04 10:02:27.140852	2014-07-10 06:02:29.199032	2014-2015	6	1A	FA3	Prakash - 4	Physics
96	98	\N	t	Set the remarks here	2	10	6	1	6	2	Teacher	2014-07-04 10:02:27.172096	2014-07-10 06:02:29.219124	2014-2015	6	1A	FA3	Satish - 5	Physics
98	11	\N	f	Set the remarks here	2	20	6	1	6	2	Teacher	2014-07-04 10:02:27.228685	2014-07-10 06:02:29.267444	2014-2015	6	1A	FA3	Swati - 15	Physics
99	8	\N	f	Set the remarks here	2	21	6	1	6	2	Teacher	2014-07-04 10:02:27.263195	2014-07-10 06:02:29.289569	2014-2015	6	1A	FA3	Rita - 16	Physics
100	76	\N	t	Set the remarks here	2	22	6	1	6	2	Teacher	2014-07-04 10:02:27.299302	2014-07-10 06:02:29.30918	2014-2015	6	1A	FA3	Mona - 17	Physics
103	46	\N	t	Set the remarks here	3	8	6	1	6	2	Teacher	2014-07-04 10:02:27.391002	2014-07-10 06:02:29.373095	2014-2015	6	1A	FA3	Dinesh - 3	Chemistry
104	16	\N	f	Set the remarks here	3	9	6	1	6	2	Teacher	2014-07-04 10:02:27.427034	2014-07-10 06:02:29.394866	2014-2015	6	1A	FA3	Prakash - 4	Chemistry
105	71	\N	t	Set the remarks here	3	10	6	1	6	2	Teacher	2014-07-04 10:02:27.462923	2014-07-10 06:02:29.414179	2014-2015	6	1A	FA3	Satish - 5	Chemistry
107	82	\N	t	Set the remarks here	3	20	6	1	6	2	Teacher	2014-07-04 10:02:27.523594	2014-07-10 06:02:29.456174	2014-2015	6	1A	FA3	Swati - 15	Chemistry
108	22	\N	f	Set the remarks here	3	21	6	1	6	2	Teacher	2014-07-04 10:02:27.553308	2014-07-10 06:02:29.478406	2014-2015	6	1A	FA3	Rita - 16	Chemistry
109	2	\N	f	Set the remarks here	3	22	6	1	6	2	Teacher	2014-07-04 10:02:27.581833	2014-07-10 06:02:29.501123	2014-2015	6	1A	FA3	Mona - 17	Chemistry
136	0	\N	f	\N	2	41	4	1	10	2	Teacher	2014-07-07 11:51:40.064315	2014-07-10 06:02:29.52043	2014-2015	14	2A	FA1	Rita - 16	Physics
137	75	\N	t	\N	3	26	4	1	10	2	Teacher	2014-07-07 11:51:40.13848	2014-07-10 06:02:29.540803	2014-2015	14	2A	FA1	Ramesh - 1	Chemistry
139	57	\N	t	\N	3	28	4	1	10	2	Teacher	2014-07-07 11:51:40.218632	2014-07-10 06:02:29.58544	2014-2015	14	2A	FA1	Dinesh - 3	Chemistry
140	100	\N	t	\N	3	29	4	1	10	2	Teacher	2014-07-07 11:51:40.26015	2014-07-10 06:02:29.613841	2014-2015	14	2A	FA1	Prakash - 4	Chemistry
141	100	\N	t	\N	3	30	4	1	10	2	Teacher	2014-07-07 11:51:40.293498	2014-07-10 06:02:29.633244	2014-2015	14	2A	FA1	Satish - 5	Chemistry
143	71	\N	t	\N	3	39	4	1	10	2	Teacher	2014-07-07 11:51:40.371442	2014-07-10 06:02:29.67698	2014-2015	14	2A	FA1	Anuj - 14	Chemistry
144	54	\N	t	\N	3	40	4	1	10	2	Teacher	2014-07-07 11:51:40.409573	2014-07-10 06:02:29.696204	2014-2015	14	2A	FA1	Swati - 15	Chemistry
145	50	\N	t	\N	3	41	4	1	10	2	Teacher	2014-07-07 11:51:40.445674	2014-07-10 06:02:29.724093	2014-2015	14	2A	FA1	Rita - 16	Chemistry
147	100	\N	t	\N	1	27	5	1	10	2	Teacher	2014-07-07 11:51:40.53079	2014-07-10 06:02:29.769674	2014-2015	14	2A	FA2	Suresh - 2	Maths
148	100	\N	t	\N	1	28	5	1	10	2	Teacher	2014-07-07 11:51:40.564355	2014-07-10 06:02:29.790443	2014-2015	14	2A	FA2	Dinesh - 3	Maths
149	36	\N	f	\N	1	29	5	1	10	2	Teacher	2014-07-07 11:51:40.599046	2014-07-10 06:02:29.813928	2014-2015	14	2A	FA2	Prakash - 4	Maths
150	49	\N	t	\N	1	30	5	1	10	2	Teacher	2014-07-07 11:51:40.631199	2014-07-10 06:02:29.833554	2014-2015	14	2A	FA2	Satish - 5	Maths
152	92	\N	t	\N	1	39	5	1	10	2	Teacher	2014-07-07 11:51:40.706452	2014-07-10 06:02:29.874714	2014-2015	14	2A	FA2	Anuj - 14	Maths
153	59	\N	t	\N	1	40	5	1	10	2	Teacher	2014-07-07 11:51:40.744517	2014-07-10 06:02:29.896154	2014-2015	14	2A	FA2	Swati - 15	Maths
154	21	\N	f	\N	1	41	5	1	10	2	Teacher	2014-07-07 11:51:40.780913	2014-07-10 06:02:29.917509	2014-2015	14	2A	FA2	Rita - 16	Maths
155	86	\N	t	\N	2	26	5	1	10	2	Teacher	2014-07-07 11:51:40.817373	2014-07-10 06:02:29.937293	2014-2015	14	2A	FA2	Ramesh - 1	Physics
157	9	\N	f	\N	2	28	5	1	10	2	Teacher	2014-07-07 11:51:40.878511	2014-07-10 06:02:29.980673	2014-2015	14	2A	FA2	Dinesh - 3	Physics
251	30	\N	f	\N	1	48	4	1	12	2	Teacher	2014-07-07 12:09:55.507232	2014-07-10 06:02:30.055215	2014-2015	16	3A	FA1	Dinesh - 3	Maths
252	14	\N	f	\N	1	49	4	1	12	2	Teacher	2014-07-07 12:09:55.539457	2014-07-10 06:02:30.083028	2014-2015	16	3A	FA1	Prakash - 4	Maths
253	90	\N	t	\N	1	50	4	1	12	2	Teacher	2014-07-07 12:09:55.571222	2014-07-10 06:02:30.102624	2014-2015	16	3A	FA1	Satish - 5	Maths
254	81	\N	t	\N	1	59	4	1	12	2	Teacher	2014-07-07 12:09:55.610253	2014-07-10 06:02:30.122938	2014-2015	16	3A	FA1	Anuj - 14	Maths
256	92	\N	t	\N	1	61	4	1	12	2	Teacher	2014-07-07 12:09:55.675834	2014-07-10 06:02:30.166616	2014-2015	16	3A	FA1	Rita - 16	Maths
257	50	\N	t	\N	1	62	4	1	12	2	Teacher	2014-07-07 12:09:55.704268	2014-07-10 06:02:30.185548	2014-2015	16	3A	FA1	Mona - 17	Maths
258	76	\N	t	\N	2	46	4	1	12	2	Teacher	2014-07-07 12:09:55.740106	2014-07-10 06:02:30.208098	2014-2015	16	3A	FA1	Ramesh - 1	Physics
260	100	\N	t	\N	2	48	4	1	12	2	Teacher	2014-07-07 12:09:55.853328	2014-07-10 06:02:30.249904	2014-2015	16	3A	FA1	Dinesh - 3	Physics
261	8	\N	f	\N	2	49	4	1	12	2	Teacher	2014-07-07 12:09:55.944121	2014-07-10 06:02:30.271099	2014-2015	16	3A	FA1	Prakash - 4	Physics
262	39	\N	f	\N	2	50	4	1	12	2	Teacher	2014-07-07 12:09:56.03212	2014-07-10 06:02:30.291435	2014-2015	16	3A	FA1	Satish - 5	Physics
263	8	\N	f	\N	2	59	4	1	12	2	Teacher	2014-07-07 12:09:56.07583	2014-07-10 06:02:30.312214	2014-2015	16	3A	FA1	Anuj - 14	Physics
265	17	\N	f	\N	2	61	4	1	12	2	Teacher	2014-07-07 12:09:56.147755	2014-07-10 06:02:30.355011	2014-2015	16	3A	FA1	Rita - 16	Physics
266	0	\N	f	\N	2	62	4	1	12	2	Teacher	2014-07-07 12:09:56.194488	2014-07-10 06:02:30.386577	2014-2015	16	3A	FA1	Mona - 17	Physics
267	75	\N	t	\N	3	46	4	1	12	2	Teacher	2014-07-07 12:09:56.227532	2014-07-10 06:02:30.413747	2014-2015	16	3A	FA1	Ramesh - 1	Chemistry
269	57	\N	t	\N	3	48	4	1	12	2	Teacher	2014-07-07 12:09:56.296667	2014-07-10 06:02:30.457457	2014-2015	16	3A	FA1	Dinesh - 3	Chemistry
270	100	\N	t	\N	3	49	4	1	12	2	Teacher	2014-07-07 12:09:56.336167	2014-07-10 06:02:30.477344	2014-2015	16	3A	FA1	Prakash - 4	Chemistry
271	100	\N	t	\N	3	50	4	1	12	2	Teacher	2014-07-07 12:09:56.372551	2014-07-10 06:02:30.505201	2014-2015	16	3A	FA1	Satish - 5	Chemistry
273	71	\N	t	\N	3	60	4	1	12	2	Teacher	2014-07-07 12:09:56.440146	2014-07-10 06:02:30.550214	2014-2015	16	3A	FA1	Swati - 15	Chemistry
274	54	\N	t	\N	3	61	4	1	12	2	Teacher	2014-07-07 12:09:56.476211	2014-07-10 06:02:30.568503	2014-2015	16	3A	FA1	Rita - 16	Chemistry
275	50	\N	t	\N	3	62	4	1	12	2	Teacher	2014-07-07 12:09:56.516094	2014-07-10 06:02:30.590593	2014-2015	16	3A	FA1	Mona - 17	Chemistry
276	70	\N	t	\N	1	46	5	1	12	2	Teacher	2014-07-07 12:09:56.556218	2014-07-10 06:02:30.612906	2014-2015	16	3A	FA2	Ramesh - 1	Maths
278	100	\N	t	\N	1	48	5	1	12	2	Teacher	2014-07-07 12:09:56.627464	2014-07-10 06:02:30.654804	2014-2015	16	3A	FA2	Dinesh - 3	Maths
279	36	\N	f	\N	1	49	5	1	12	2	Teacher	2014-07-07 12:09:56.661622	2014-07-10 06:02:30.682817	2014-2015	16	3A	FA2	Prakash - 4	Maths
280	49	\N	t	\N	1	50	5	1	12	2	Teacher	2014-07-07 12:09:56.694885	2014-07-10 06:02:30.702987	2014-2015	16	3A	FA2	Satish - 5	Maths
281	96	\N	t	\N	1	59	5	1	12	2	Teacher	2014-07-07 12:09:56.73763	2014-07-10 06:02:30.725027	2014-2015	16	3A	FA2	Anuj - 14	Maths
283	59	\N	t	\N	1	61	5	1	12	2	Teacher	2014-07-07 12:09:56.809803	2014-07-10 06:02:30.765713	2014-2015	16	3A	FA2	Rita - 16	Maths
284	21	\N	f	\N	1	62	5	1	12	2	Teacher	2014-07-07 12:09:56.846312	2014-07-10 06:02:30.789472	2014-2015	16	3A	FA2	Mona - 17	Maths
285	86	\N	t	\N	2	46	5	1	12	2	Teacher	2014-07-07 12:09:56.874468	2014-07-10 06:02:30.807547	2014-2015	16	3A	FA2	Ramesh - 1	Physics
286	81	\N	t	\N	2	47	5	1	12	2	Teacher	2014-07-07 12:09:56.903163	2014-07-10 06:02:30.82949	2014-2015	16	3A	FA2	Suresh - 2	Physics
288	86	\N	t	\N	2	49	5	1	12	2	Teacher	2014-07-07 12:09:56.972764	2014-07-10 06:02:30.884152	2014-2015	16	3A	FA2	Prakash - 4	Physics
289	80	\N	t	\N	2	50	5	1	12	2	Teacher	2014-07-07 12:09:57.002319	2014-07-10 06:02:30.909275	2014-2015	16	3A	FA2	Satish - 5	Physics
290	82	\N	t	\N	2	59	5	1	12	2	Teacher	2014-07-07 12:09:57.032952	2014-07-10 06:02:30.929122	2014-2015	16	3A	FA2	Anuj - 14	Physics
292	27	\N	f	\N	2	61	5	1	12	2	Teacher	2014-07-07 12:09:57.108074	2014-07-10 06:02:30.971378	2014-2015	16	3A	FA2	Rita - 16	Physics
293	5	\N	f	\N	2	62	5	1	12	2	Teacher	2014-07-07 12:09:57.144688	2014-07-10 06:02:30.993561	2014-2015	16	3A	FA2	Mona - 17	Physics
294	78	\N	t	\N	3	46	5	1	12	2	Teacher	2014-07-07 12:09:57.185245	2014-07-10 06:02:31.015619	2014-2015	16	3A	FA2	Ramesh - 1	Chemistry
296	96	\N	t	\N	3	48	5	1	12	2	Teacher	2014-07-07 12:09:57.248394	2014-07-10 06:02:31.0571	2014-2015	16	3A	FA2	Dinesh - 3	Chemistry
297	30	\N	f	\N	3	49	5	1	12	2	Teacher	2014-07-07 12:09:57.279525	2014-07-10 06:02:31.078036	2014-2015	16	3A	FA2	Prakash - 4	Chemistry
298	19	\N	f	\N	3	50	5	1	12	2	Teacher	2014-07-07 12:09:57.316164	2014-07-10 06:02:31.098733	2014-2015	16	3A	FA2	Satish - 5	Chemistry
299	82	\N	t	\N	3	59	5	1	12	2	Teacher	2014-07-07 12:09:57.345257	2014-07-10 06:02:31.119487	2014-2015	16	3A	FA2	Anuj - 14	Chemistry
301	31	\N	f	\N	3	61	5	1	12	2	Teacher	2014-07-07 12:09:57.419727	2014-07-10 06:02:31.188181	2014-2015	16	3A	FA2	Rita - 16	Chemistry
302	78	\N	t	\N	3	62	5	1	12	2	Teacher	2014-07-07 12:09:57.455126	2014-07-10 06:02:31.218812	2014-2015	16	3A	FA2	Mona - 17	Chemistry
303	76	\N	t	\N	1	46	6	1	12	2	Teacher	2014-07-07 12:09:57.486516	2014-07-10 06:02:31.246302	2014-2015	16	3A	FA3	Ramesh - 1	Maths
305	84	\N	t	\N	1	48	6	1	12	2	Teacher	2014-07-07 12:09:57.54679	2014-07-10 06:02:31.288305	2014-2015	16	3A	FA3	Dinesh - 3	Maths
306	76	\N	t	\N	1	49	6	1	12	2	Teacher	2014-07-07 12:09:57.58947	2014-07-10 06:02:31.308042	2014-2015	16	3A	FA3	Prakash - 4	Maths
307	27	\N	f	\N	1	50	6	1	12	2	Teacher	2014-07-07 12:09:57.618929	2014-07-10 06:02:31.331807	2014-2015	16	3A	FA3	Satish - 5	Maths
308	72	\N	t	\N	1	59	6	1	12	2	Teacher	2014-07-07 12:09:57.645352	2014-07-10 06:02:31.360259	2014-2015	16	3A	FA3	Anuj - 14	Maths
310	18	\N	f	\N	1	61	6	1	12	2	Teacher	2014-07-07 12:09:57.711398	2014-07-10 06:02:31.399472	2014-2015	16	3A	FA3	Rita - 16	Maths
311	100	\N	t	\N	1	62	6	1	12	2	Teacher	2014-07-07 12:09:57.747767	2014-07-10 06:02:31.422519	2014-2015	16	3A	FA3	Mona - 17	Maths
312	100	\N	t	\N	2	46	6	1	12	2	Teacher	2014-07-07 12:09:57.778542	2014-07-10 06:02:31.441841	2014-2015	16	3A	FA3	Ramesh - 1	Physics
313	100	\N	t	\N	2	47	6	1	12	2	Teacher	2014-07-07 12:09:57.809513	2014-07-10 06:02:31.464961	2014-2015	16	3A	FA3	Suresh - 2	Physics
119	38	\N	f	\N	1	26	4	1	10	2	Teacher	2014-07-07 11:51:39.153095	2014-07-10 06:02:27.245839	2014-2015	14	2A	FA1	Ramesh - 1	Maths
121	30	\N	f	\N	1	28	4	1	10	2	Teacher	2014-07-07 11:51:39.254021	2014-07-10 06:02:27.329523	2014-2015	14	2A	FA1	Dinesh - 3	Maths
126	92	\N	t	\N	1	40	4	1	10	2	Teacher	2014-07-07 11:51:39.650251	2014-07-10 06:02:27.437365	2014-2015	14	2A	FA1	Swati - 15	Maths
130	100	\N	t	\N	2	28	4	1	10	2	Teacher	2014-07-07 11:51:39.815182	2014-07-10 06:02:27.520788	2014-2015	14	2A	FA1	Dinesh - 3	Physics
135	17	\N	f	\N	2	40	4	1	10	2	Teacher	2014-07-07 11:51:40.025397	2014-07-10 06:02:27.635239	2014-2015	14	2A	FA1	Swati - 15	Physics
35	69	\N	t	Set the remarks here	1	20	4	1	6	2	Teacher	2014-07-04 10:02:25.114045	2014-07-10 06:02:27.865741	2014-2015	6	1A	FA1	Swati - 15	Maths
40	61	\N	t	Set the remarks here	2	8	4	1	6	2	Teacher	2014-07-04 10:02:25.303659	2014-07-10 06:02:27.969539	2014-2015	6	1A	FA1	Dinesh - 3	Physics
45	17	\N	f	Set the remarks here	2	21	4	1	6	2	Teacher	2014-07-04 10:02:25.45478	2014-07-10 06:02:28.090962	2014-2015	6	1A	FA1	Rita - 16	Physics
50	52	\N	t	Set the remarks here	3	9	4	1	6	2	Teacher	2014-07-04 10:02:25.645186	2014-07-10 06:02:28.207908	2014-2015	6	1A	FA1	Prakash - 4	Chemistry
54	54	\N	t	Set the remarks here	3	21	4	1	6	2	Teacher	2014-07-04 10:02:25.786736	2014-07-10 06:02:28.290001	2014-2015	6	1A	FA1	Rita - 16	Chemistry
63	59	\N	t	Set the remarks here	1	21	5	1	6	2	Teacher	2014-07-04 10:02:26.100661	2014-07-10 06:02:28.416781	2014-2015	6	1A	FA2	Rita - 16	Maths
68	86	\N	t	Set the remarks here	2	9	5	1	6	2	Teacher	2014-07-04 10:02:26.257661	2014-07-10 06:02:28.573189	2014-2015	6	1A	FA2	Prakash - 4	Physics
72	27	\N	f	Set the remarks here	2	21	5	1	6	2	Teacher	2014-07-04 10:02:26.38657	2014-07-10 06:02:28.672997	2014-2015	6	1A	FA2	Rita - 16	Physics
76	96	\N	t	Set the remarks here	3	8	5	1	6	2	Teacher	2014-07-04 10:02:26.537276	2014-07-10 06:02:28.763801	2014-2015	6	1A	FA2	Dinesh - 3	Chemistry
81	31	\N	f	Set the remarks here	3	21	5	1	6	2	Teacher	2014-07-04 10:02:26.689221	2014-07-10 06:02:28.869739	2014-2015	6	1A	FA2	Rita - 16	Chemistry
86	76	\N	t	Set the remarks here	1	9	6	1	6	2	Teacher	2014-07-04 10:02:26.872386	2014-07-10 06:02:28.982336	2014-2015	6	1A	FA3	Prakash - 4	Maths
97	41	\N	t	Set the remarks here	2	19	6	1	6	2	Teacher	2014-07-04 10:02:27.200608	2014-07-10 06:02:29.247103	2014-2015	6	1A	FA3	Anuj - 14	Physics
102	96	\N	t	Set the remarks here	3	7	6	1	6	2	Teacher	2014-07-04 10:02:27.362571	2014-07-10 06:02:29.354265	2014-2015	6	1A	FA3	Suresh - 2	Chemistry
106	54	\N	t	Set the remarks here	3	19	6	1	6	2	Teacher	2014-07-04 10:02:27.496932	2014-07-10 06:02:29.437853	2014-2015	6	1A	FA3	Anuj - 14	Chemistry
138	30	\N	f	\N	3	27	4	1	10	2	Teacher	2014-07-07 11:51:40.183645	2014-07-10 06:02:29.564466	2014-2015	14	2A	FA1	Suresh - 2	Chemistry
142	84	\N	t	\N	3	38	4	1	10	2	Teacher	2014-07-07 11:51:40.33392	2014-07-10 06:02:29.654632	2014-2015	14	2A	FA1	Manoj - 13	Chemistry
146	70	\N	t	\N	1	26	5	1	10	2	Teacher	2014-07-07 11:51:40.481773	2014-07-10 06:02:29.749387	2014-2015	14	2A	FA2	Ramesh - 1	Maths
151	96	\N	t	\N	1	38	5	1	10	2	Teacher	2014-07-07 11:51:40.66943	2014-07-10 06:02:29.854254	2014-2015	14	2A	FA2	Manoj - 13	Maths
156	81	\N	t	\N	2	27	5	1	10	2	Teacher	2014-07-07 11:51:40.84608	2014-07-10 06:02:29.96128	2014-2015	14	2A	FA2	Suresh - 2	Physics
249	38	\N	f	\N	1	46	4	1	12	2	Teacher	2014-07-07 12:09:55.429161	2014-07-10 06:02:30.003325	2014-2015	16	3A	FA1	Ramesh - 1	Maths
250	22	\N	f	\N	1	47	4	1	12	2	Teacher	2014-07-07 12:09:55.46794	2014-07-10 06:02:30.026597	2014-2015	16	3A	FA1	Suresh - 2	Maths
255	69	\N	t	\N	1	60	4	1	12	2	Teacher	2014-07-07 12:09:55.645904	2014-07-10 06:02:30.145324	2014-2015	16	3A	FA1	Swati - 15	Maths
259	100	\N	t	\N	2	47	4	1	12	2	Teacher	2014-07-07 12:09:55.772896	2014-07-10 06:02:30.229344	2014-2015	16	3A	FA1	Suresh - 2	Physics
264	35	\N	f	\N	2	60	4	1	12	2	Teacher	2014-07-07 12:09:56.11581	2014-07-10 06:02:30.333472	2014-2015	16	3A	FA1	Swati - 15	Physics
268	30	\N	f	\N	3	47	4	1	12	2	Teacher	2014-07-07 12:09:56.2592	2014-07-10 06:02:30.433224	2014-2015	16	3A	FA1	Suresh - 2	Chemistry
272	84	\N	t	\N	3	59	4	1	12	2	Teacher	2014-07-07 12:09:56.402109	2014-07-10 06:02:30.526597	2014-2015	16	3A	FA1	Anuj - 14	Chemistry
277	100	\N	t	\N	1	47	5	1	12	2	Teacher	2014-07-07 12:09:56.589917	2014-07-10 06:02:30.631348	2014-2015	16	3A	FA2	Suresh - 2	Maths
282	92	\N	t	\N	1	60	5	1	12	2	Teacher	2014-07-07 12:09:56.778505	2014-07-10 06:02:30.746845	2014-2015	16	3A	FA2	Swati - 15	Maths
287	9	\N	f	\N	2	48	5	1	12	2	Teacher	2014-07-07 12:09:56.936779	2014-07-10 06:02:30.85505	2014-2015	16	3A	FA2	Dinesh - 3	Physics
291	73	\N	t	\N	2	60	5	1	12	2	Teacher	2014-07-07 12:09:57.069944	2014-07-10 06:02:30.951057	2014-2015	16	3A	FA2	Swati - 15	Physics
295	49	\N	t	\N	3	47	5	1	12	2	Teacher	2014-07-07 12:09:57.216777	2014-07-10 06:02:31.034766	2014-2015	16	3A	FA2	Suresh - 2	Chemistry
315	85	\N	t	\N	2	49	6	1	12	2	Teacher	2014-07-07 12:09:57.871171	2014-07-10 06:02:31.505993	2014-2015	16	3A	FA3	Prakash - 4	Physics
316	98	\N	t	\N	2	50	6	1	12	2	Teacher	2014-07-07 12:09:57.906411	2014-07-10 06:02:31.52919	2014-2015	16	3A	FA3	Satish - 5	Physics
318	11	\N	f	\N	2	60	6	1	12	2	Teacher	2014-07-07 12:09:57.964772	2014-07-10 06:02:31.585458	2014-2015	16	3A	FA3	Swati - 15	Physics
319	8	\N	f	\N	2	61	6	1	12	2	Teacher	2014-07-07 12:09:57.99279	2014-07-10 06:02:31.606253	2014-2015	16	3A	FA3	Rita - 16	Physics
320	76	\N	t	\N	2	62	6	1	12	2	Teacher	2014-07-07 12:09:58.023216	2014-07-10 06:02:31.627011	2014-2015	16	3A	FA3	Mona - 17	Physics
321	37	\N	f	\N	3	46	6	1	12	2	Teacher	2014-07-07 12:09:58.049871	2014-07-10 06:02:31.647805	2014-2015	16	3A	FA3	Ramesh - 1	Chemistry
323	46	\N	t	\N	3	48	6	1	12	2	Teacher	2014-07-07 12:09:58.122372	2014-07-10 06:02:31.69619	2014-2015	16	3A	FA3	Dinesh - 3	Chemistry
324	16	\N	f	\N	3	49	6	1	12	2	Teacher	2014-07-07 12:09:58.160699	2014-07-10 06:02:31.723055	2014-2015	16	3A	FA3	Prakash - 4	Chemistry
325	71	\N	t	\N	3	50	6	1	12	2	Teacher	2014-07-07 12:09:58.192874	2014-07-10 06:02:31.749037	2014-2015	16	3A	FA3	Satish - 5	Chemistry
327	82	\N	t	\N	3	60	6	1	12	2	Teacher	2014-07-07 12:09:58.255299	2014-07-10 06:02:31.789533	2014-2015	16	3A	FA3	Swati - 15	Chemistry
328	22	\N	f	\N	3	61	6	1	12	2	Teacher	2014-07-07 12:09:58.287961	2014-07-10 06:02:31.811008	2014-2015	16	3A	FA3	Rita - 16	Chemistry
329	2	\N	f	\N	3	62	6	1	12	2	Teacher	2014-07-07 12:09:58.319501	2014-07-10 06:02:31.832604	2014-2015	16	3A	FA3	Mona - 17	Chemistry
300	59	\N	t	\N	3	60	5	1	12	2	Teacher	2014-07-07 12:09:57.385263	2014-07-10 06:02:31.140146	2014-2015	16	3A	FA2	Swati - 15	Chemistry
304	63	\N	t	\N	1	47	6	1	12	2	Teacher	2014-07-07 12:09:57.512929	2014-07-10 06:02:31.265923	2014-2015	16	3A	FA3	Suresh - 2	Maths
309	57	\N	t	\N	1	60	6	1	12	2	Teacher	2014-07-07 12:09:57.677297	2014-07-10 06:02:31.379894	2014-2015	16	3A	FA3	Swati - 15	Maths
314	63	\N	t	\N	2	48	6	1	12	2	Teacher	2014-07-07 12:09:57.840696	2014-07-10 06:02:31.484045	2014-2015	16	3A	FA3	Dinesh - 3	Physics
317	41	\N	t	\N	2	59	6	1	12	2	Teacher	2014-07-07 12:09:57.935589	2014-07-10 06:02:31.55803	2014-2015	16	3A	FA3	Anuj - 14	Physics
322	96	\N	t	\N	3	47	6	1	12	2	Teacher	2014-07-07 12:09:58.091722	2014-07-10 06:02:31.673312	2014-2015	16	3A	FA3	Suresh - 2	Chemistry
326	54	\N	t	\N	3	59	6	1	12	2	Teacher	2014-07-07 12:09:58.224047	2014-07-10 06:02:31.767476	2014-2015	16	3A	FA3	Anuj - 14	Chemistry
56	70	\N	t	Set the remarks here	1	6	5	1	6	2	Teacher	2014-07-04 10:02:25.856999	2014-07-10 06:02:28.332365	2014-2015	6	1A	FA2	Ramesh Sharma - 1	Maths
65	86	\N	t	Set the remarks here	2	6	5	1	6	2	Teacher	2014-07-04 10:02:26.16194	2014-07-10 06:02:28.499864	2014-2015	6	1A	FA2	Ramesh Sharma - 1	Physics
74	78	\N	t	Set the remarks here	3	6	5	1	6	2	Teacher	2014-07-04 10:02:26.464166	2014-07-10 06:02:28.722013	2014-2015	6	1A	FA2	Ramesh Sharma - 1	Chemistry
83	76	\N	t	Set the remarks here	1	6	6	1	6	2	Teacher	2014-07-04 10:02:26.771243	2014-07-10 06:02:28.91418	2014-2015	6	1A	FA3	Ramesh Sharma - 1	Maths
101	37	\N	f	Set the remarks here	3	6	6	1	6	2	Teacher	2014-07-04 10:02:27.333757	2014-07-10 06:02:29.331179	2014-2015	6	1A	FA3	Ramesh Sharma - 1	Chemistry
29	38	\N	f	Set the remarks here	1	6	4	1	6	2	Teacher	2014-07-04 10:02:24.86484	2014-07-10 06:02:27.730636	2014-2015	6	1A	FA1	Ramesh Sharma - 1	Maths
92	43	\N	t	Set the remarks here	2	6	6	1	6	2	Teacher	2014-07-04 10:02:27.053538	2014-07-10 06:02:29.134332	2014-2015	6	1A	FA3	Ramesh Sharma - 1	Physics
343	58	\N	t	\N	3	26	5	1	10	2	Teacher	2014-07-15 09:35:20.971066	2014-07-15 09:35:20.971066	2012-2013	14	2A	FA2	Ramesh - 1	Chemistry
344	49	\N	t	\N	3	27	5	1	10	2	Teacher	2014-07-15 09:35:21.002515	2014-07-15 09:35:21.002515	2013-2014	14	2A	FA2	Suresh - 2	Chemistry
345	49	\N	t	\N	3	27	5	1	10	2	Teacher	2014-07-15 09:35:21.029731	2014-07-15 09:35:21.029731	2012-2013	14	2A	FA2	Suresh - 2	Chemistry
346	86	\N	t	\N	3	28	5	1	10	2	Teacher	2014-07-15 09:35:21.060651	2014-07-15 09:35:21.060651	2013-2014	14	2A	FA2	Dinesh - 3	Chemistry
347	76	\N	t	\N	3	28	5	1	10	2	Teacher	2014-07-15 09:35:21.089954	2014-07-15 09:35:21.089954	2012-2013	14	2A	FA2	Dinesh - 3	Chemistry
348	40	\N	f	\N	3	29	5	1	10	2	Teacher	2014-07-15 09:35:21.119198	2014-07-15 09:35:21.119198	2013-2014	14	2A	FA2	Prakash - 4	Chemistry
349	40	\N	f	\N	3	29	5	1	10	2	Teacher	2014-07-15 09:35:21.150724	2014-07-15 09:35:21.150724	2012-2013	14	2A	FA2	Prakash - 4	Chemistry
350	29	\N	f	\N	3	30	5	1	10	2	Teacher	2014-07-15 09:35:21.180696	2014-07-15 09:35:21.180696	2013-2014	14	2A	FA2	Satish - 5	Chemistry
351	39	\N	f	\N	3	30	5	1	10	2	Teacher	2014-07-15 09:35:21.211277	2014-07-15 09:35:21.211277	2012-2013	14	2A	FA2	Satish - 5	Chemistry
352	72	\N	t	\N	3	38	5	1	10	2	Teacher	2014-07-15 09:35:21.256758	2014-07-15 09:35:21.256758	2013-2014	14	2A	FA2	Manoj - 13	Chemistry
353	62	\N	t	\N	3	38	5	1	10	2	Teacher	2014-07-15 09:35:21.294366	2014-07-15 09:35:21.294366	2012-2013	14	2A	FA2	Manoj - 13	Chemistry
354	49	\N	t	\N	3	39	5	1	10	2	Teacher	2014-07-15 09:35:21.323437	2014-07-15 09:35:21.323437	2013-2014	14	2A	FA2	Anuj - 14	Chemistry
355	49	\N	t	\N	3	39	5	1	10	2	Teacher	2014-07-15 09:35:21.351974	2014-07-15 09:35:21.351974	2012-2013	14	2A	FA2	Anuj - 14	Chemistry
356	41	\N	f	\N	3	40	5	1	10	2	Teacher	2014-07-15 09:35:21.379769	2014-07-15 09:35:21.379769	2013-2014	14	2A	FA2	Swati - 15	Chemistry
357	41	\N	f	\N	3	40	5	1	10	2	Teacher	2014-07-15 09:35:21.407414	2014-07-15 09:35:21.407414	2012-2013	14	2A	FA2	Swati - 15	Chemistry
358	68	\N	t	\N	3	41	5	1	10	2	Teacher	2014-07-15 09:35:21.43726	2014-07-15 09:35:21.43726	2013-2014	14	2A	FA2	Rita - 16	Chemistry
359	58	\N	t	\N	3	41	5	1	10	2	Teacher	2014-07-15 09:35:21.467241	2014-07-15 09:35:21.467241	2012-2013	14	2A	FA2	Rita - 16	Chemistry
360	66	\N	t	\N	1	26	6	1	10	2	Teacher	2014-07-15 09:35:21.49931	2014-07-15 09:35:21.49931	2013-2014	14	2A	FA3	Ramesh - 1	Maths
361	56	\N	t	\N	1	26	6	1	10	2	Teacher	2014-07-15 09:35:21.524728	2014-07-15 09:35:21.524728	2012-2013	14	2A	FA3	Ramesh - 1	Maths
362	53	\N	t	\N	1	27	6	1	10	2	Teacher	2014-07-15 09:35:21.55413	2014-07-15 09:35:21.55413	2013-2014	14	2A	FA3	Suresh - 2	Maths
363	43	\N	t	\N	1	27	6	1	10	2	Teacher	2014-07-15 09:35:21.584455	2014-07-15 09:35:21.584455	2012-2013	14	2A	FA3	Suresh - 2	Maths
364	74	\N	t	\N	1	28	6	1	10	2	Teacher	2014-07-15 09:35:21.613276	2014-07-15 09:35:21.613276	2013-2014	14	2A	FA3	Dinesh - 3	Maths
365	64	\N	t	\N	1	28	6	1	10	2	Teacher	2014-07-15 09:35:21.6432	2014-07-15 09:35:21.6432	2012-2013	14	2A	FA3	Dinesh - 3	Maths
366	66	\N	t	\N	1	29	6	1	10	2	Teacher	2014-07-15 09:35:21.673709	2014-07-15 09:35:21.673709	2013-2014	14	2A	FA3	Prakash - 4	Maths
367	56	\N	t	\N	1	29	6	1	10	2	Teacher	2014-07-15 09:35:21.705709	2014-07-15 09:35:21.705709	2012-2013	14	2A	FA3	Prakash - 4	Maths
368	37	\N	f	\N	1	30	6	1	10	2	Teacher	2014-07-15 09:35:21.732791	2014-07-15 09:35:21.732791	2013-2014	14	2A	FA3	Satish - 5	Maths
369	47	\N	f	\N	1	30	6	1	10	2	Teacher	2014-07-15 09:35:21.764165	2014-07-15 09:35:21.764165	2012-2013	14	2A	FA3	Satish - 5	Maths
370	62	\N	t	\N	1	38	6	1	10	2	Teacher	2014-07-15 09:35:21.794064	2014-07-15 09:35:21.794064	2013-2014	14	2A	FA3	Manoj - 13	Maths
371	52	\N	t	\N	1	38	6	1	10	2	Teacher	2014-07-15 09:35:21.825331	2014-07-15 09:35:21.825331	2012-2013	14	2A	FA3	Manoj - 13	Maths
372	47	\N	t	\N	1	39	6	1	10	2	Teacher	2014-07-15 09:35:21.853671	2014-07-15 09:35:21.853671	2013-2014	14	2A	FA3	Anuj - 14	Maths
373	47	\N	t	\N	1	39	6	1	10	2	Teacher	2014-07-15 09:35:21.883054	2014-07-15 09:35:21.883054	2012-2013	14	2A	FA3	Anuj - 14	Maths
374	28	\N	f	\N	1	40	6	1	10	2	Teacher	2014-07-15 09:35:21.911156	2014-07-15 09:35:21.911156	2013-2014	14	2A	FA3	Swati - 15	Maths
375	38	\N	f	\N	1	40	6	1	10	2	Teacher	2014-07-15 09:35:21.944025	2014-07-15 09:35:21.944025	2012-2013	14	2A	FA3	Swati - 15	Maths
376	90	\N	t	\N	1	41	6	1	10	2	Teacher	2014-07-15 09:35:21.972396	2014-07-15 09:35:21.972396	2013-2014	14	2A	FA3	Rita - 16	Maths
377	80	\N	t	\N	1	41	6	1	10	2	Teacher	2014-07-15 09:35:22.000483	2014-07-15 09:35:22.000483	2012-2013	14	2A	FA3	Rita - 16	Maths
378	90	\N	t	\N	2	26	6	1	10	2	Teacher	2014-07-15 09:35:22.027904	2014-07-15 09:35:22.027904	2013-2014	14	2A	FA3	Ramesh - 1	Physics
379	80	\N	t	\N	2	26	6	1	10	2	Teacher	2014-07-15 09:35:22.061217	2014-07-15 09:35:22.061217	2012-2013	14	2A	FA3	Ramesh - 1	Physics
380	90	\N	t	\N	2	27	6	1	10	2	Teacher	2014-07-15 09:35:22.088996	2014-07-15 09:35:22.088996	2013-2014	14	2A	FA3	Suresh - 2	Physics
381	80	\N	t	\N	2	27	6	1	10	2	Teacher	2014-07-15 09:35:22.120323	2014-07-15 09:35:22.120323	2012-2013	14	2A	FA3	Suresh - 2	Physics
382	53	\N	t	\N	2	28	6	1	10	2	Teacher	2014-07-15 09:35:22.172939	2014-07-15 09:35:22.172939	2013-2014	14	2A	FA3	Dinesh - 3	Physics
383	43	\N	t	\N	2	28	6	1	10	2	Teacher	2014-07-15 09:35:22.20421	2014-07-15 09:35:22.20421	2012-2013	14	2A	FA3	Dinesh - 3	Physics
384	75	\N	t	\N	2	29	6	1	10	2	Teacher	2014-07-15 09:35:22.230296	2014-07-15 09:35:22.230296	2013-2014	14	2A	FA3	Prakash - 4	Physics
385	65	\N	t	\N	2	29	6	1	10	2	Teacher	2014-07-15 09:35:22.257453	2014-07-15 09:35:22.257453	2012-2013	14	2A	FA3	Prakash - 4	Physics
386	88	\N	t	\N	2	30	6	1	10	2	Teacher	2014-07-15 09:35:22.288074	2014-07-15 09:35:22.288074	2013-2014	14	2A	FA3	Satish - 5	Physics
387	78	\N	t	\N	2	30	6	1	10	2	Teacher	2014-07-15 09:35:22.317558	2014-07-15 09:35:22.317558	2012-2013	14	2A	FA3	Satish - 5	Physics
388	41	\N	t	\N	2	38	6	1	10	2	Teacher	2014-07-15 09:35:22.348889	2014-07-15 09:35:22.348889	2013-2014	14	2A	FA3	Manoj - 13	Physics
389	41	\N	t	\N	2	38	6	1	10	2	Teacher	2014-07-15 09:35:22.375661	2014-07-15 09:35:22.375661	2012-2013	14	2A	FA3	Manoj - 13	Physics
390	21	\N	f	\N	2	39	6	1	10	2	Teacher	2014-07-15 09:35:22.405584	2014-07-15 09:35:22.405584	2013-2014	14	2A	FA3	Anuj - 14	Physics
391	31	\N	f	\N	2	39	6	1	10	2	Teacher	2014-07-15 09:35:22.434914	2014-07-15 09:35:22.434914	2012-2013	14	2A	FA3	Anuj - 14	Physics
392	18	\N	f	\N	2	40	6	1	10	2	Teacher	2014-07-15 09:35:22.465219	2014-07-15 09:35:22.465219	2013-2014	14	2A	FA3	Swati - 15	Physics
393	28	\N	f	\N	2	40	6	1	10	2	Teacher	2014-07-15 09:35:22.494762	2014-07-15 09:35:22.494762	2012-2013	14	2A	FA3	Swati - 15	Physics
394	66	\N	t	\N	2	41	6	1	10	2	Teacher	2014-07-15 09:35:22.522597	2014-07-15 09:35:22.522597	2013-2014	14	2A	FA3	Rita - 16	Physics
395	56	\N	t	\N	2	41	6	1	10	2	Teacher	2014-07-15 09:35:22.55455	2014-07-15 09:35:22.55455	2012-2013	14	2A	FA3	Rita - 16	Physics
396	47	\N	f	\N	3	26	6	1	10	2	Teacher	2014-07-15 09:35:22.583001	2014-07-15 09:35:22.583001	2013-2014	14	2A	FA3	Ramesh - 1	Chemistry
397	47	\N	f	\N	3	26	6	1	10	2	Teacher	2014-07-15 09:35:22.616039	2014-07-15 09:35:22.616039	2012-2013	14	2A	FA3	Ramesh - 1	Chemistry
398	86	\N	t	\N	3	27	6	1	10	2	Teacher	2014-07-15 09:35:22.650441	2014-07-15 09:35:22.650441	2013-2014	14	2A	FA3	Suresh - 2	Chemistry
399	76	\N	t	\N	3	27	6	1	10	2	Teacher	2014-07-15 09:35:22.680716	2014-07-15 09:35:22.680716	2012-2013	14	2A	FA3	Suresh - 2	Chemistry
400	46	\N	t	\N	3	28	6	1	10	2	Teacher	2014-07-15 09:35:22.711365	2014-07-15 09:35:22.711365	2013-2014	14	2A	FA3	Dinesh - 3	Chemistry
401	46	\N	t	\N	3	28	6	1	10	2	Teacher	2014-07-15 09:35:22.741754	2014-07-15 09:35:22.741754	2012-2013	14	2A	FA3	Dinesh - 3	Chemistry
402	26	\N	f	\N	3	29	6	1	10	2	Teacher	2014-07-15 09:35:22.768026	2014-07-15 09:35:22.768026	2013-2014	14	2A	FA3	Prakash - 4	Chemistry
403	36	\N	f	\N	3	29	6	1	10	2	Teacher	2014-07-15 09:35:22.796517	2014-07-15 09:35:22.796517	2012-2013	14	2A	FA3	Prakash - 4	Chemistry
404	61	\N	t	\N	3	30	6	1	10	2	Teacher	2014-07-15 09:35:22.824458	2014-07-15 09:35:22.824458	2013-2014	14	2A	FA3	Satish - 5	Chemistry
405	51	\N	t	\N	3	30	6	1	10	2	Teacher	2014-07-15 09:35:22.856224	2014-07-15 09:35:22.856224	2012-2013	14	2A	FA3	Satish - 5	Chemistry
406	44	\N	t	\N	3	38	6	1	10	2	Teacher	2014-07-15 09:35:22.888748	2014-07-15 09:35:22.888748	2013-2014	14	2A	FA3	Manoj - 13	Chemistry
407	44	\N	t	\N	3	38	6	1	10	2	Teacher	2014-07-15 09:35:22.912123	2014-07-15 09:35:22.912123	2012-2013	14	2A	FA3	Manoj - 13	Chemistry
408	72	\N	t	\N	3	39	6	1	10	2	Teacher	2014-07-15 09:35:22.951104	2014-07-15 09:35:22.951104	2013-2014	14	2A	FA3	Anuj - 14	Chemistry
409	62	\N	t	\N	3	39	6	1	10	2	Teacher	2014-07-15 09:35:22.984997	2014-07-15 09:35:22.984997	2012-2013	14	2A	FA3	Anuj - 14	Chemistry
410	32	\N	f	\N	3	40	6	1	10	2	Teacher	2014-07-15 09:35:23.015734	2014-07-15 09:35:23.015734	2013-2014	14	2A	FA3	Swati - 15	Chemistry
411	42	\N	f	\N	3	40	6	1	10	2	Teacher	2014-07-15 09:35:23.041977	2014-07-15 09:35:23.041977	2012-2013	14	2A	FA3	Swati - 15	Chemistry
412	12	\N	f	\N	3	41	6	1	10	2	Teacher	2014-07-15 09:35:23.075461	2014-07-15 09:35:23.075461	2013-2014	14	2A	FA3	Rita - 16	Chemistry
413	22	\N	f	\N	3	41	6	1	10	2	Teacher	2014-07-15 09:35:23.100995	2014-07-15 09:35:23.100995	2012-2013	14	2A	FA3	Rita - 16	Chemistry
414	66	\N	t	Set the remarks here	2	6	4	1	6	2	Teacher	2014-07-15 09:35:23.131869	2014-07-15 09:35:23.131869	2013-2014	6	1A	FA1	Ramesh Sharma - 1	Physics
415	56	\N	t	Set the remarks here	2	6	4	1	6	2	Teacher	2014-07-15 09:35:23.16102	2014-07-15 09:35:23.16102	2012-2013	6	1A	FA1	Ramesh Sharma - 1	Physics
416	32	\N	f	\N	1	27	4	1	10	2	Teacher	2014-07-15 09:35:23.191203	2014-07-15 09:35:23.191203	2013-2014	14	2A	FA1	Suresh - 2	Maths
417	42	\N	f	\N	1	27	4	1	10	2	Teacher	2014-07-15 09:35:23.228042	2014-07-15 09:35:23.228042	2012-2013	14	2A	FA1	Suresh - 2	Maths
418	24	\N	f	\N	1	29	4	1	10	2	Teacher	2014-07-15 09:35:23.264296	2014-07-15 09:35:23.264296	2013-2014	14	2A	FA1	Prakash - 4	Maths
419	34	\N	f	\N	1	29	4	1	10	2	Teacher	2014-07-15 09:35:23.294789	2014-07-15 09:35:23.294789	2012-2013	14	2A	FA1	Prakash - 4	Maths
420	80	\N	t	\N	1	30	4	1	10	2	Teacher	2014-07-15 09:35:23.325676	2014-07-15 09:35:23.325676	2013-2014	14	2A	FA1	Satish - 5	Maths
421	70	\N	t	\N	1	30	4	1	10	2	Teacher	2014-07-15 09:35:23.355537	2014-07-15 09:35:23.355537	2012-2013	14	2A	FA1	Satish - 5	Maths
422	71	\N	t	\N	1	38	4	1	10	2	Teacher	2014-07-15 09:35:23.384587	2014-07-15 09:35:23.384587	2013-2014	14	2A	FA1	Manoj - 13	Maths
423	61	\N	t	\N	1	38	4	1	10	2	Teacher	2014-07-15 09:35:23.415697	2014-07-15 09:35:23.415697	2012-2013	14	2A	FA1	Manoj - 13	Maths
424	59	\N	t	\N	1	39	4	1	10	2	Teacher	2014-07-15 09:35:23.444656	2014-07-15 09:35:23.444656	2013-2014	14	2A	FA1	Anuj - 14	Maths
425	49	\N	t	\N	1	39	4	1	10	2	Teacher	2014-07-15 09:35:23.474192	2014-07-15 09:35:23.474192	2012-2013	14	2A	FA1	Anuj - 14	Maths
426	40	\N	t	\N	1	41	4	1	10	2	Teacher	2014-07-15 09:35:23.504384	2014-07-15 09:35:23.504384	2013-2014	14	2A	FA1	Rita - 16	Maths
427	40	\N	t	\N	1	41	4	1	10	2	Teacher	2014-07-15 09:35:23.533988	2014-07-15 09:35:23.533988	2012-2013	14	2A	FA1	Rita - 16	Maths
428	66	\N	t	\N	2	26	4	1	10	2	Teacher	2014-07-15 09:35:23.565837	2014-07-15 09:35:23.565837	2013-2014	14	2A	FA1	Ramesh - 1	Physics
429	56	\N	t	\N	2	26	4	1	10	2	Teacher	2014-07-15 09:35:23.594052	2014-07-15 09:35:23.594052	2012-2013	14	2A	FA1	Ramesh - 1	Physics
430	90	\N	t	\N	2	27	4	1	10	2	Teacher	2014-07-15 09:35:23.626189	2014-07-15 09:35:23.626189	2013-2014	14	2A	FA1	Suresh - 2	Physics
431	80	\N	t	\N	2	27	4	1	10	2	Teacher	2014-07-15 09:35:23.652811	2014-07-15 09:35:23.652811	2012-2013	14	2A	FA1	Suresh - 2	Physics
432	18	\N	f	\N	2	29	4	1	10	2	Teacher	2014-07-15 09:35:23.683185	2014-07-15 09:35:23.683185	2013-2014	14	2A	FA1	Prakash - 4	Physics
433	28	\N	f	\N	2	29	4	1	10	2	Teacher	2014-07-15 09:35:23.710536	2014-07-15 09:35:23.710536	2012-2013	14	2A	FA1	Prakash - 4	Physics
434	49	\N	f	\N	2	30	4	1	10	2	Teacher	2014-07-15 09:35:23.742568	2014-07-15 09:35:23.742568	2013-2014	14	2A	FA1	Satish - 5	Physics
435	49	\N	f	\N	2	30	4	1	10	2	Teacher	2014-07-15 09:35:23.772764	2014-07-15 09:35:23.772764	2012-2013	14	2A	FA1	Satish - 5	Physics
436	18	\N	f	\N	2	38	4	1	10	2	Teacher	2014-07-15 09:35:23.798906	2014-07-15 09:35:23.798906	2013-2014	14	2A	FA1	Manoj - 13	Physics
437	28	\N	f	\N	2	38	4	1	10	2	Teacher	2014-07-15 09:35:23.83335	2014-07-15 09:35:23.83335	2012-2013	14	2A	FA1	Manoj - 13	Physics
438	45	\N	f	\N	2	39	4	1	10	2	Teacher	2014-07-15 09:35:23.860465	2014-07-15 09:35:23.860465	2013-2014	14	2A	FA1	Anuj - 14	Physics
439	45	\N	f	\N	2	39	4	1	10	2	Teacher	2014-07-15 09:35:23.889721	2014-07-15 09:35:23.889721	2012-2013	14	2A	FA1	Anuj - 14	Physics
440	43	\N	t	Set the remarks here	1	8	5	1	6	2	Teacher	2014-07-15 09:35:23.921126	2014-07-15 09:35:23.921126	2013-2014	6	1A	FA2	Dinesh - 3	Maths
441	43	\N	t	Set the remarks here	1	8	5	1	6	2	Teacher	2014-07-15 09:35:23.950449	2014-07-15 09:35:23.950449	2012-2013	6	1A	FA2	Dinesh - 3	Maths
442	46	\N	f	Set the remarks here	1	9	5	1	6	2	Teacher	2014-07-15 09:35:23.976991	2014-07-15 09:35:23.976991	2013-2014	6	1A	FA2	Prakash - 4	Maths
443	46	\N	f	Set the remarks here	1	9	5	1	6	2	Teacher	2014-07-15 09:35:24.009569	2014-07-15 09:35:24.009569	2012-2013	6	1A	FA2	Prakash - 4	Maths
444	49	\N	t	Set the remarks here	1	10	5	1	6	2	Teacher	2014-07-15 09:35:24.0371	2014-07-15 09:35:24.0371	2013-2014	6	1A	FA2	Satish - 5	Maths
445	49	\N	t	Set the remarks here	1	10	5	1	6	2	Teacher	2014-07-15 09:35:24.068938	2014-07-15 09:35:24.068938	2012-2013	6	1A	FA2	Satish - 5	Maths
446	52	\N	t	Set the remarks here	1	7	4	1	6	2	Teacher	2014-07-15 09:35:24.101249	2014-07-15 09:35:24.101249	2013-2014	6	1A	FA1	Suresh - 2	Maths
447	42	\N	t	Set the remarks here	1	7	4	1	6	2	Teacher	2014-07-15 09:35:24.134619	2014-07-15 09:35:24.134619	2012-2013	6	1A	FA1	Suresh - 2	Maths
448	40	\N	f	Set the remarks here	1	8	4	1	6	2	Teacher	2014-07-15 09:35:24.165369	2014-07-15 09:35:24.165369	2013-2014	6	1A	FA1	Dinesh - 3	Maths
449	40	\N	f	Set the remarks here	1	8	4	1	6	2	Teacher	2014-07-15 09:35:24.194129	2014-07-15 09:35:24.194129	2012-2013	6	1A	FA1	Dinesh - 3	Maths
450	24	\N	f	Set the remarks here	1	9	4	1	6	2	Teacher	2014-07-15 09:35:24.223798	2014-07-15 09:35:24.223798	2013-2014	6	1A	FA1	Prakash - 4	Maths
451	34	\N	f	Set the remarks here	1	9	4	1	6	2	Teacher	2014-07-15 09:35:24.256413	2014-07-15 09:35:24.256413	2012-2013	6	1A	FA1	Prakash - 4	Maths
452	14	\N	f	Set the remarks here	1	10	4	1	6	2	Teacher	2014-07-15 09:35:24.28547	2014-07-15 09:35:24.28547	2013-2014	6	1A	FA1	Satish - 5	Maths
453	24	\N	f	Set the remarks here	1	10	4	1	6	2	Teacher	2014-07-15 09:35:24.312789	2014-07-15 09:35:24.312789	2012-2013	6	1A	FA1	Satish - 5	Maths
454	71	\N	t	Set the remarks here	1	19	4	1	6	2	Teacher	2014-07-15 09:35:24.343699	2014-07-15 09:35:24.343699	2013-2014	6	1A	FA1	Anuj - 14	Maths
455	61	\N	t	Set the remarks here	1	19	4	1	6	2	Teacher	2014-07-15 09:35:24.37401	2014-07-15 09:35:24.37401	2012-2013	6	1A	FA1	Anuj - 14	Maths
456	82	\N	t	Set the remarks here	1	21	4	1	6	2	Teacher	2014-07-15 09:35:24.405502	2014-07-15 09:35:24.405502	2013-2014	6	1A	FA1	Rita - 16	Maths
457	72	\N	t	Set the remarks here	1	21	4	1	6	2	Teacher	2014-07-15 09:35:24.435752	2014-07-15 09:35:24.435752	2012-2013	6	1A	FA1	Rita - 16	Maths
458	40	\N	t	Set the remarks here	1	22	4	1	6	2	Teacher	2014-07-15 09:35:24.46066	2014-07-15 09:35:24.46066	2013-2014	6	1A	FA1	Mona - 17	Maths
459	40	\N	t	Set the remarks here	1	22	4	1	6	2	Teacher	2014-07-15 09:35:24.492313	2014-07-15 09:35:24.492313	2012-2013	6	1A	FA1	Mona - 17	Maths
460	48	\N	t	Set the remarks here	2	7	4	1	6	2	Teacher	2014-07-15 09:35:24.52302	2014-07-15 09:35:24.52302	2013-2014	6	1A	FA1	Suresh - 2	Physics
461	48	\N	t	Set the remarks here	2	7	4	1	6	2	Teacher	2014-07-15 09:35:24.551321	2014-07-15 09:35:24.551321	2012-2013	6	1A	FA1	Suresh - 2	Physics
462	18	\N	f	Set the remarks here	2	9	4	1	6	2	Teacher	2014-07-15 09:35:24.578017	2014-07-15 09:35:24.578017	2013-2014	6	1A	FA1	Prakash - 4	Physics
463	28	\N	f	Set the remarks here	2	9	4	1	6	2	Teacher	2014-07-15 09:35:24.610367	2014-07-15 09:35:24.610367	2012-2013	6	1A	FA1	Prakash - 4	Physics
464	49	\N	f	Set the remarks here	2	10	4	1	6	2	Teacher	2014-07-15 09:35:24.636864	2014-07-15 09:35:24.636864	2013-2014	6	1A	FA1	Satish - 5	Physics
465	49	\N	f	Set the remarks here	2	10	4	1	6	2	Teacher	2014-07-15 09:35:24.668708	2014-07-15 09:35:24.668708	2012-2013	6	1A	FA1	Satish - 5	Physics
466	18	\N	f	Set the remarks here	2	19	4	1	6	2	Teacher	2014-07-15 09:35:24.698075	2014-07-15 09:35:24.698075	2013-2014	6	1A	FA1	Anuj - 14	Physics
467	28	\N	f	Set the remarks here	2	19	4	1	6	2	Teacher	2014-07-15 09:35:24.727972	2014-07-15 09:35:24.727972	2012-2013	6	1A	FA1	Anuj - 14	Physics
468	45	\N	f	Set the remarks here	2	20	4	1	6	2	Teacher	2014-07-15 09:35:24.756855	2014-07-15 09:35:24.756855	2013-2014	6	1A	FA1	Swati - 15	Physics
469	45	\N	f	Set the remarks here	2	20	4	1	6	2	Teacher	2014-07-15 09:35:24.786947	2014-07-15 09:35:24.786947	2012-2013	6	1A	FA1	Swati - 15	Physics
470	10	\N	f	Set the remarks here	2	22	4	1	6	2	Teacher	2014-07-15 09:35:24.816875	2014-07-15 09:35:24.816875	2013-2014	6	1A	FA1	Mona - 17	Physics
471	20	\N	f	Set the remarks here	2	22	4	1	6	2	Teacher	2014-07-15 09:35:24.847711	2014-07-15 09:35:24.847711	2012-2013	6	1A	FA1	Mona - 17	Physics
472	40	\N	f	Set the remarks here	3	7	4	1	6	2	Teacher	2014-07-15 09:35:24.881809	2014-07-15 09:35:24.881809	2013-2014	6	1A	FA1	Suresh - 2	Chemistry
473	40	\N	f	Set the remarks here	3	7	4	1	6	2	Teacher	2014-07-15 09:35:24.915417	2014-07-15 09:35:24.915417	2012-2013	6	1A	FA1	Suresh - 2	Chemistry
474	47	\N	t	Set the remarks here	3	8	4	1	6	2	Teacher	2014-07-15 09:35:24.942166	2014-07-15 09:35:24.942166	2013-2014	6	1A	FA1	Dinesh - 3	Chemistry
475	47	\N	t	Set the remarks here	3	8	4	1	6	2	Teacher	2014-07-15 09:35:24.970945	2014-07-15 09:35:24.970945	2012-2013	6	1A	FA1	Dinesh - 3	Chemistry
476	49	\N	t	Set the remarks here	3	10	4	1	6	2	Teacher	2014-07-15 09:35:25.00425	2014-07-15 09:35:25.00425	2013-2014	6	1A	FA1	Satish - 5	Chemistry
477	49	\N	t	Set the remarks here	3	10	4	1	6	2	Teacher	2014-07-15 09:35:25.031629	2014-07-15 09:35:25.031629	2012-2013	6	1A	FA1	Satish - 5	Chemistry
478	74	\N	t	Set the remarks here	3	19	4	1	6	2	Teacher	2014-07-15 09:35:25.061515	2014-07-15 09:35:25.061515	2013-2014	6	1A	FA1	Anuj - 14	Chemistry
479	64	\N	t	Set the remarks here	3	19	4	1	6	2	Teacher	2014-07-15 09:35:25.092992	2014-07-15 09:35:25.092992	2012-2013	6	1A	FA1	Anuj - 14	Chemistry
480	61	\N	t	Set the remarks here	3	20	4	1	6	2	Teacher	2014-07-15 09:35:25.123549	2014-07-15 09:35:25.123549	2013-2014	6	1A	FA1	Swati - 15	Chemistry
481	51	\N	t	Set the remarks here	3	20	4	1	6	2	Teacher	2014-07-15 09:35:25.151102	2014-07-15 09:35:25.151102	2012-2013	6	1A	FA1	Swati - 15	Chemistry
482	40	\N	t	Set the remarks here	3	22	4	1	6	2	Teacher	2014-07-15 09:35:25.183258	2014-07-15 09:35:25.183258	2013-2014	6	1A	FA1	Mona - 17	Chemistry
483	40	\N	t	Set the remarks here	3	22	4	1	6	2	Teacher	2014-07-15 09:35:25.211149	2014-07-15 09:35:25.211149	2012-2013	6	1A	FA1	Mona - 17	Chemistry
484	40	\N	t	Set the remarks here	1	7	5	1	6	2	Teacher	2014-07-15 09:35:25.244846	2014-07-15 09:35:25.244846	2013-2014	6	1A	FA2	Suresh - 2	Maths
485	40	\N	t	Set the remarks here	1	7	5	1	6	2	Teacher	2014-07-15 09:35:25.269373	2014-07-15 09:35:25.269373	2012-2013	6	1A	FA2	Suresh - 2	Maths
486	86	\N	t	Set the remarks here	1	19	5	1	6	2	Teacher	2014-07-15 09:35:25.314226	2014-07-15 09:35:25.314226	2013-2014	6	1A	FA2	Anuj - 14	Maths
487	76	\N	t	Set the remarks here	1	19	5	1	6	2	Teacher	2014-07-15 09:35:25.349376	2014-07-15 09:35:25.349376	2012-2013	6	1A	FA2	Anuj - 14	Maths
488	82	\N	t	Set the remarks here	1	20	5	1	6	2	Teacher	2014-07-15 09:35:25.38782	2014-07-15 09:35:25.38782	2013-2014	6	1A	FA2	Swati - 15	Maths
489	72	\N	t	Set the remarks here	1	20	5	1	6	2	Teacher	2014-07-15 09:35:25.425006	2014-07-15 09:35:25.425006	2012-2013	6	1A	FA2	Swati - 15	Maths
490	31	\N	f	Set the remarks here	1	22	5	1	6	2	Teacher	2014-07-15 09:35:25.452292	2014-07-15 09:35:25.452292	2013-2014	6	1A	FA2	Mona - 17	Maths
491	41	\N	f	Set the remarks here	1	22	5	1	6	2	Teacher	2014-07-15 09:35:25.480807	2014-07-15 09:35:25.480807	2012-2013	6	1A	FA2	Mona - 17	Maths
492	71	\N	t	Set the remarks here	2	7	5	1	6	2	Teacher	2014-07-15 09:35:25.511415	2014-07-15 09:35:25.511415	2013-2014	6	1A	FA2	Suresh - 2	Physics
493	61	\N	t	Set the remarks here	2	7	5	1	6	2	Teacher	2014-07-15 09:35:25.539505	2014-07-15 09:35:25.539505	2012-2013	6	1A	FA2	Suresh - 2	Physics
494	19	\N	f	Set the remarks here	2	8	5	1	6	2	Teacher	2014-07-15 09:35:25.57322	2014-07-15 09:35:25.57322	2013-2014	6	1A	FA2	Dinesh - 3	Physics
495	29	\N	f	Set the remarks here	2	8	5	1	6	2	Teacher	2014-07-15 09:35:25.598651	2014-07-15 09:35:25.598651	2012-2013	6	1A	FA2	Dinesh - 3	Physics
496	70	\N	t	Set the remarks here	2	10	5	1	6	2	Teacher	2014-07-15 09:35:25.628816	2014-07-15 09:35:25.628816	2013-2014	6	1A	FA2	Satish - 5	Physics
497	60	\N	t	Set the remarks here	2	10	5	1	6	2	Teacher	2014-07-15 09:35:25.661634	2014-07-15 09:35:25.661634	2012-2013	6	1A	FA2	Satish - 5	Physics
498	72	\N	t	Set the remarks here	2	19	5	1	6	2	Teacher	2014-07-15 09:35:25.690092	2014-07-15 09:35:25.690092	2013-2014	6	1A	FA2	Anuj - 14	Physics
499	62	\N	t	Set the remarks here	2	19	5	1	6	2	Teacher	2014-07-15 09:35:25.721945	2014-07-15 09:35:25.721945	2012-2013	6	1A	FA2	Anuj - 14	Physics
500	63	\N	t	Set the remarks here	2	20	5	1	6	2	Teacher	2014-07-15 09:35:25.748794	2014-07-15 09:35:25.748794	2013-2014	6	1A	FA2	Swati - 15	Physics
501	53	\N	t	Set the remarks here	2	20	5	1	6	2	Teacher	2014-07-15 09:35:25.776347	2014-07-15 09:35:25.776347	2012-2013	6	1A	FA2	Swati - 15	Physics
502	65	\N	t	Set the remarks here	3	6	4	1	6	2	Teacher	2014-07-15 09:35:25.810633	2014-07-15 09:35:25.810633	2013-2014	6	1A	FA1	Ramesh Sharma - 1	Chemistry
503	55	\N	t	Set the remarks here	3	6	4	1	6	2	Teacher	2014-07-15 09:35:25.842427	2014-07-15 09:35:25.842427	2012-2013	6	1A	FA1	Ramesh Sharma - 1	Chemistry
504	15	\N	f	Set the remarks here	2	22	5	1	6	2	Teacher	2014-07-15 09:35:25.869272	2014-07-15 09:35:25.869272	2013-2014	6	1A	FA2	Mona - 17	Physics
505	25	\N	f	Set the remarks here	2	22	5	1	6	2	Teacher	2014-07-15 09:35:25.898167	2014-07-15 09:35:25.898167	2012-2013	6	1A	FA2	Mona - 17	Physics
506	49	\N	t	Set the remarks here	3	7	5	1	6	2	Teacher	2014-07-15 09:35:25.928551	2014-07-15 09:35:25.928551	2013-2014	6	1A	FA2	Suresh - 2	Chemistry
507	49	\N	t	Set the remarks here	3	7	5	1	6	2	Teacher	2014-07-15 09:35:25.957973	2014-07-15 09:35:25.957973	2012-2013	6	1A	FA2	Suresh - 2	Chemistry
508	40	\N	f	Set the remarks here	3	9	5	1	6	2	Teacher	2014-07-15 09:35:25.986194	2014-07-15 09:35:25.986194	2013-2014	6	1A	FA2	Prakash - 4	Chemistry
509	40	\N	f	Set the remarks here	3	9	5	1	6	2	Teacher	2014-07-15 09:35:26.019989	2014-07-15 09:35:26.019989	2012-2013	6	1A	FA2	Prakash - 4	Chemistry
510	29	\N	f	Set the remarks here	3	10	5	1	6	2	Teacher	2014-07-15 09:35:26.044487	2014-07-15 09:35:26.044487	2013-2014	6	1A	FA2	Satish - 5	Chemistry
511	39	\N	f	Set the remarks here	3	10	5	1	6	2	Teacher	2014-07-15 09:35:26.075992	2014-07-15 09:35:26.075992	2012-2013	6	1A	FA2	Satish - 5	Chemistry
512	72	\N	t	Set the remarks here	3	19	5	1	6	2	Teacher	2014-07-15 09:35:26.104031	2014-07-15 09:35:26.104031	2013-2014	6	1A	FA2	Anuj - 14	Chemistry
513	62	\N	t	Set the remarks here	3	19	5	1	6	2	Teacher	2014-07-15 09:35:26.136022	2014-07-15 09:35:26.136022	2012-2013	6	1A	FA2	Anuj - 14	Chemistry
514	49	\N	t	Set the remarks here	3	20	5	1	6	2	Teacher	2014-07-15 09:35:26.165067	2014-07-15 09:35:26.165067	2013-2014	6	1A	FA2	Swati - 15	Chemistry
515	49	\N	t	Set the remarks here	3	20	5	1	6	2	Teacher	2014-07-15 09:35:26.195712	2014-07-15 09:35:26.195712	2012-2013	6	1A	FA2	Swati - 15	Chemistry
516	68	\N	t	Set the remarks here	3	22	5	1	6	2	Teacher	2014-07-15 09:35:26.223441	2014-07-15 09:35:26.223441	2013-2014	6	1A	FA2	Mona - 17	Chemistry
517	58	\N	t	Set the remarks here	3	22	5	1	6	2	Teacher	2014-07-15 09:35:26.254257	2014-07-15 09:35:26.254257	2012-2013	6	1A	FA2	Mona - 17	Chemistry
518	53	\N	t	Set the remarks here	1	7	6	1	6	2	Teacher	2014-07-15 09:35:26.283716	2014-07-15 09:35:26.283716	2013-2014	6	1A	FA3	Suresh - 2	Maths
519	43	\N	t	Set the remarks here	1	7	6	1	6	2	Teacher	2014-07-15 09:35:26.316334	2014-07-15 09:35:26.316334	2012-2013	6	1A	FA3	Suresh - 2	Maths
520	74	\N	t	Set the remarks here	1	8	6	1	6	2	Teacher	2014-07-15 09:35:26.34293	2014-07-15 09:35:26.34293	2013-2014	6	1A	FA3	Dinesh - 3	Maths
521	64	\N	t	Set the remarks here	1	8	6	1	6	2	Teacher	2014-07-15 09:35:26.37517	2014-07-15 09:35:26.37517	2012-2013	6	1A	FA3	Dinesh - 3	Maths
522	37	\N	f	Set the remarks here	1	10	6	1	6	2	Teacher	2014-07-15 09:35:26.403531	2014-07-15 09:35:26.403531	2013-2014	6	1A	FA3	Satish - 5	Maths
523	47	\N	f	Set the remarks here	1	10	6	1	6	2	Teacher	2014-07-15 09:35:26.433446	2014-07-15 09:35:26.433446	2012-2013	6	1A	FA3	Satish - 5	Maths
524	62	\N	t	Set the remarks here	1	19	6	1	6	2	Teacher	2014-07-15 09:35:26.460966	2014-07-15 09:35:26.460966	2013-2014	6	1A	FA3	Anuj - 14	Maths
525	52	\N	t	Set the remarks here	1	19	6	1	6	2	Teacher	2014-07-15 09:35:26.492503	2014-07-15 09:35:26.492503	2012-2013	6	1A	FA3	Anuj - 14	Maths
526	47	\N	t	Set the remarks here	1	20	6	1	6	2	Teacher	2014-07-15 09:35:26.526208	2014-07-15 09:35:26.526208	2013-2014	6	1A	FA3	Swati - 15	Maths
527	47	\N	t	Set the remarks here	1	20	6	1	6	2	Teacher	2014-07-15 09:35:26.559603	2014-07-15 09:35:26.559603	2012-2013	6	1A	FA3	Swati - 15	Maths
528	28	\N	f	Set the remarks here	1	21	6	1	6	2	Teacher	2014-07-15 09:35:26.588729	2014-07-15 09:35:26.588729	2013-2014	6	1A	FA3	Rita - 16	Maths
529	38	\N	f	Set the remarks here	1	21	6	1	6	2	Teacher	2014-07-15 09:35:26.622841	2014-07-15 09:35:26.622841	2012-2013	6	1A	FA3	Rita - 16	Maths
530	47	\N	t	Set the remarks here	1	22	6	1	6	2	Teacher	2014-07-15 09:35:26.654491	2014-07-15 09:35:26.654491	2013-2014	6	1A	FA3	Mona - 17	Maths
531	47	\N	t	Set the remarks here	1	22	6	1	6	2	Teacher	2014-07-15 09:35:26.685641	2014-07-15 09:35:26.685641	2012-2013	6	1A	FA3	Mona - 17	Maths
532	66	\N	t	Set the remarks here	2	7	6	1	6	2	Teacher	2014-07-15 09:35:26.715462	2014-07-15 09:35:26.715462	2013-2014	6	1A	FA3	Suresh - 2	Physics
533	56	\N	t	Set the remarks here	2	7	6	1	6	2	Teacher	2014-07-15 09:35:26.745118	2014-07-15 09:35:26.745118	2012-2013	6	1A	FA3	Suresh - 2	Physics
534	53	\N	t	Set the remarks here	2	8	6	1	6	2	Teacher	2014-07-15 09:35:26.774478	2014-07-15 09:35:26.774478	2013-2014	6	1A	FA3	Dinesh - 3	Physics
535	43	\N	t	Set the remarks here	2	8	6	1	6	2	Teacher	2014-07-15 09:35:26.804236	2014-07-15 09:35:26.804236	2012-2013	6	1A	FA3	Dinesh - 3	Physics
536	75	\N	t	Set the remarks here	2	9	6	1	6	2	Teacher	2014-07-15 09:35:26.842358	2014-07-15 09:35:26.842358	2013-2014	6	1A	FA3	Prakash - 4	Physics
537	65	\N	t	Set the remarks here	2	9	6	1	6	2	Teacher	2014-07-15 09:35:26.873987	2014-07-15 09:35:26.873987	2012-2013	6	1A	FA3	Prakash - 4	Physics
538	88	\N	t	Set the remarks here	2	10	6	1	6	2	Teacher	2014-07-15 09:35:26.902393	2014-07-15 09:35:26.902393	2013-2014	6	1A	FA3	Satish - 5	Physics
539	78	\N	t	Set the remarks here	2	10	6	1	6	2	Teacher	2014-07-15 09:35:26.9325	2014-07-15 09:35:26.9325	2012-2013	6	1A	FA3	Satish - 5	Physics
540	21	\N	f	Set the remarks here	2	20	6	1	6	2	Teacher	2014-07-15 09:35:26.961144	2014-07-15 09:35:26.961144	2013-2014	6	1A	FA3	Swati - 15	Physics
541	31	\N	f	Set the remarks here	2	20	6	1	6	2	Teacher	2014-07-15 09:35:26.992218	2014-07-15 09:35:26.992218	2012-2013	6	1A	FA3	Swati - 15	Physics
542	18	\N	f	Set the remarks here	2	21	6	1	6	2	Teacher	2014-07-15 09:35:27.020448	2014-07-15 09:35:27.020448	2013-2014	6	1A	FA3	Rita - 16	Physics
543	28	\N	f	Set the remarks here	2	21	6	1	6	2	Teacher	2014-07-15 09:35:27.050076	2014-07-15 09:35:27.050076	2012-2013	6	1A	FA3	Rita - 16	Physics
544	66	\N	t	Set the remarks here	2	22	6	1	6	2	Teacher	2014-07-15 09:35:27.080703	2014-07-15 09:35:27.080703	2013-2014	6	1A	FA3	Mona - 17	Physics
545	56	\N	t	Set the remarks here	2	22	6	1	6	2	Teacher	2014-07-15 09:35:27.10958	2014-07-15 09:35:27.10958	2012-2013	6	1A	FA3	Mona - 17	Physics
546	46	\N	t	Set the remarks here	3	8	6	1	6	2	Teacher	2014-07-15 09:35:27.139101	2014-07-15 09:35:27.139101	2013-2014	6	1A	FA3	Dinesh - 3	Chemistry
547	46	\N	t	Set the remarks here	3	8	6	1	6	2	Teacher	2014-07-15 09:35:27.167954	2014-07-15 09:35:27.167954	2012-2013	6	1A	FA3	Dinesh - 3	Chemistry
548	26	\N	f	Set the remarks here	3	9	6	1	6	2	Teacher	2014-07-15 09:35:27.20185	2014-07-15 09:35:27.20185	2013-2014	6	1A	FA3	Prakash - 4	Chemistry
549	36	\N	f	Set the remarks here	3	9	6	1	6	2	Teacher	2014-07-15 09:35:27.228362	2014-07-15 09:35:27.228362	2012-2013	6	1A	FA3	Prakash - 4	Chemistry
550	61	\N	t	Set the remarks here	3	10	6	1	6	2	Teacher	2014-07-15 09:35:27.260733	2014-07-15 09:35:27.260733	2013-2014	6	1A	FA3	Satish - 5	Chemistry
551	51	\N	t	Set the remarks here	3	10	6	1	6	2	Teacher	2014-07-15 09:35:27.28771	2014-07-15 09:35:27.28771	2012-2013	6	1A	FA3	Satish - 5	Chemistry
552	72	\N	t	Set the remarks here	3	20	6	1	6	2	Teacher	2014-07-15 09:35:27.318654	2014-07-15 09:35:27.318654	2013-2014	6	1A	FA3	Swati - 15	Chemistry
553	62	\N	t	Set the remarks here	3	20	6	1	6	2	Teacher	2014-07-15 09:35:27.347587	2014-07-15 09:35:27.347587	2012-2013	6	1A	FA3	Swati - 15	Chemistry
554	32	\N	f	Set the remarks here	3	21	6	1	6	2	Teacher	2014-07-15 09:35:27.382445	2014-07-15 09:35:27.382445	2013-2014	6	1A	FA3	Rita - 16	Chemistry
555	42	\N	f	Set the remarks here	3	21	6	1	6	2	Teacher	2014-07-15 09:35:27.415645	2014-07-15 09:35:27.415645	2012-2013	6	1A	FA3	Rita - 16	Chemistry
556	12	\N	f	Set the remarks here	3	22	6	1	6	2	Teacher	2014-07-15 09:35:27.444365	2014-07-15 09:35:27.444365	2013-2014	6	1A	FA3	Mona - 17	Chemistry
557	22	\N	f	Set the remarks here	3	22	6	1	6	2	Teacher	2014-07-15 09:35:27.474298	2014-07-15 09:35:27.474298	2012-2013	6	1A	FA3	Mona - 17	Chemistry
558	10	\N	f	\N	2	41	4	1	10	2	Teacher	2014-07-15 09:35:27.504149	2014-07-15 09:35:27.504149	2013-2014	14	2A	FA1	Rita - 16	Physics
559	20	\N	f	\N	2	41	4	1	10	2	Teacher	2014-07-15 09:35:27.536665	2014-07-15 09:35:27.536665	2012-2013	14	2A	FA1	Rita - 16	Physics
560	65	\N	t	\N	3	26	4	1	10	2	Teacher	2014-07-15 09:35:27.565388	2014-07-15 09:35:27.565388	2013-2014	14	2A	FA1	Ramesh - 1	Chemistry
561	55	\N	t	\N	3	26	4	1	10	2	Teacher	2014-07-15 09:35:27.595898	2014-07-15 09:35:27.595898	2012-2013	14	2A	FA1	Ramesh - 1	Chemistry
562	47	\N	t	\N	3	28	4	1	10	2	Teacher	2014-07-15 09:35:27.631352	2014-07-15 09:35:27.631352	2013-2014	14	2A	FA1	Dinesh - 3	Chemistry
563	47	\N	t	\N	3	28	4	1	10	2	Teacher	2014-07-15 09:35:27.659696	2014-07-15 09:35:27.659696	2012-2013	14	2A	FA1	Dinesh - 3	Chemistry
564	90	\N	t	\N	3	29	4	1	10	2	Teacher	2014-07-15 09:35:27.689422	2014-07-15 09:35:27.689422	2013-2014	14	2A	FA1	Prakash - 4	Chemistry
565	80	\N	t	\N	3	29	4	1	10	2	Teacher	2014-07-15 09:35:27.719918	2014-07-15 09:35:27.719918	2012-2013	14	2A	FA1	Prakash - 4	Chemistry
566	90	\N	t	\N	3	30	4	1	10	2	Teacher	2014-07-15 09:35:27.749784	2014-07-15 09:35:27.749784	2013-2014	14	2A	FA1	Satish - 5	Chemistry
567	80	\N	t	\N	3	30	4	1	10	2	Teacher	2014-07-15 09:35:27.779015	2014-07-15 09:35:27.779015	2012-2013	14	2A	FA1	Satish - 5	Chemistry
568	61	\N	t	\N	3	39	4	1	10	2	Teacher	2014-07-15 09:35:27.810084	2014-07-15 09:35:27.810084	2013-2014	14	2A	FA1	Anuj - 14	Chemistry
569	51	\N	t	\N	3	39	4	1	10	2	Teacher	2014-07-15 09:35:27.840453	2014-07-15 09:35:27.840453	2012-2013	14	2A	FA1	Anuj - 14	Chemistry
570	44	\N	t	\N	3	40	4	1	10	2	Teacher	2014-07-15 09:35:27.870566	2014-07-15 09:35:27.870566	2013-2014	14	2A	FA1	Swati - 15	Chemistry
571	44	\N	t	\N	3	40	4	1	10	2	Teacher	2014-07-15 09:35:27.899685	2014-07-15 09:35:27.899685	2012-2013	14	2A	FA1	Swati - 15	Chemistry
572	40	\N	t	\N	3	41	4	1	10	2	Teacher	2014-07-15 09:35:27.931859	2014-07-15 09:35:27.931859	2013-2014	14	2A	FA1	Rita - 16	Chemistry
573	40	\N	t	\N	3	41	4	1	10	2	Teacher	2014-07-15 09:35:27.958871	2014-07-15 09:35:27.958871	2012-2013	14	2A	FA1	Rita - 16	Chemistry
574	90	\N	t	\N	1	27	5	1	10	2	Teacher	2014-07-15 09:35:27.992791	2014-07-15 09:35:27.992791	2013-2014	14	2A	FA2	Suresh - 2	Maths
575	80	\N	t	\N	1	27	5	1	10	2	Teacher	2014-07-15 09:35:28.024404	2014-07-15 09:35:28.024404	2012-2013	14	2A	FA2	Suresh - 2	Maths
576	90	\N	t	\N	1	28	5	1	10	2	Teacher	2014-07-15 09:35:28.05474	2014-07-15 09:35:28.05474	2013-2014	14	2A	FA2	Dinesh - 3	Maths
577	80	\N	t	\N	1	28	5	1	10	2	Teacher	2014-07-15 09:35:28.084386	2014-07-15 09:35:28.084386	2012-2013	14	2A	FA2	Dinesh - 3	Maths
578	46	\N	f	\N	1	29	5	1	10	2	Teacher	2014-07-15 09:35:28.115214	2014-07-15 09:35:28.115214	2013-2014	14	2A	FA2	Prakash - 4	Maths
579	46	\N	f	\N	1	29	5	1	10	2	Teacher	2014-07-15 09:35:28.144523	2014-07-15 09:35:28.144523	2012-2013	14	2A	FA2	Prakash - 4	Maths
580	49	\N	t	\N	1	30	5	1	10	2	Teacher	2014-07-15 09:35:28.173037	2014-07-15 09:35:28.173037	2013-2014	14	2A	FA2	Satish - 5	Maths
581	49	\N	t	\N	1	30	5	1	10	2	Teacher	2014-07-15 09:35:28.203906	2014-07-15 09:35:28.203906	2012-2013	14	2A	FA2	Satish - 5	Maths
582	82	\N	t	\N	1	39	5	1	10	2	Teacher	2014-07-15 09:35:28.239968	2014-07-15 09:35:28.239968	2013-2014	14	2A	FA2	Anuj - 14	Maths
583	72	\N	t	\N	1	39	5	1	10	2	Teacher	2014-07-15 09:35:28.270462	2014-07-15 09:35:28.270462	2012-2013	14	2A	FA2	Anuj - 14	Maths
584	49	\N	t	\N	1	40	5	1	10	2	Teacher	2014-07-15 09:35:28.300977	2014-07-15 09:35:28.300977	2013-2014	14	2A	FA2	Swati - 15	Maths
585	49	\N	t	\N	1	40	5	1	10	2	Teacher	2014-07-15 09:35:28.333445	2014-07-15 09:35:28.333445	2012-2013	14	2A	FA2	Swati - 15	Maths
586	31	\N	f	\N	1	41	5	1	10	2	Teacher	2014-07-15 09:35:28.361804	2014-07-15 09:35:28.361804	2013-2014	14	2A	FA2	Rita - 16	Maths
587	41	\N	f	\N	1	41	5	1	10	2	Teacher	2014-07-15 09:35:28.39178	2014-07-15 09:35:28.39178	2012-2013	14	2A	FA2	Rita - 16	Maths
588	76	\N	t	\N	2	26	5	1	10	2	Teacher	2014-07-15 09:35:28.420771	2014-07-15 09:35:28.420771	2013-2014	14	2A	FA2	Ramesh - 1	Physics
589	66	\N	t	\N	2	26	5	1	10	2	Teacher	2014-07-15 09:35:28.449418	2014-07-15 09:35:28.449418	2012-2013	14	2A	FA2	Ramesh - 1	Physics
590	19	\N	f	\N	2	28	5	1	10	2	Teacher	2014-07-15 09:35:28.477594	2014-07-15 09:35:28.477594	2013-2014	14	2A	FA2	Dinesh - 3	Physics
591	29	\N	f	\N	2	28	5	1	10	2	Teacher	2014-07-15 09:35:28.508844	2014-07-15 09:35:28.508844	2012-2013	14	2A	FA2	Dinesh - 3	Physics
592	40	\N	f	\N	1	48	4	1	12	2	Teacher	2014-07-15 09:35:28.539708	2014-07-15 09:35:28.539708	2013-2014	16	3A	FA1	Dinesh - 3	Maths
593	40	\N	f	\N	1	48	4	1	12	2	Teacher	2014-07-15 09:35:28.567639	2014-07-15 09:35:28.567639	2012-2013	16	3A	FA1	Dinesh - 3	Maths
594	24	\N	f	\N	1	49	4	1	12	2	Teacher	2014-07-15 09:35:28.596398	2014-07-15 09:35:28.596398	2013-2014	16	3A	FA1	Prakash - 4	Maths
595	34	\N	f	\N	1	49	4	1	12	2	Teacher	2014-07-15 09:35:28.633061	2014-07-15 09:35:28.633061	2012-2013	16	3A	FA1	Prakash - 4	Maths
596	80	\N	t	\N	1	50	4	1	12	2	Teacher	2014-07-15 09:35:28.666598	2014-07-15 09:35:28.666598	2013-2014	16	3A	FA1	Satish - 5	Maths
597	70	\N	t	\N	1	50	4	1	12	2	Teacher	2014-07-15 09:35:28.697413	2014-07-15 09:35:28.697413	2012-2013	16	3A	FA1	Satish - 5	Maths
598	71	\N	t	\N	1	59	4	1	12	2	Teacher	2014-07-15 09:35:28.728772	2014-07-15 09:35:28.728772	2013-2014	16	3A	FA1	Anuj - 14	Maths
599	61	\N	t	\N	1	59	4	1	12	2	Teacher	2014-07-15 09:35:28.761181	2014-07-15 09:35:28.761181	2012-2013	16	3A	FA1	Anuj - 14	Maths
600	82	\N	t	\N	1	61	4	1	12	2	Teacher	2014-07-15 09:35:28.791445	2014-07-15 09:35:28.791445	2013-2014	16	3A	FA1	Rita - 16	Maths
601	72	\N	t	\N	1	61	4	1	12	2	Teacher	2014-07-15 09:35:28.820236	2014-07-15 09:35:28.820236	2012-2013	16	3A	FA1	Rita - 16	Maths
602	40	\N	t	\N	1	62	4	1	12	2	Teacher	2014-07-15 09:35:28.854535	2014-07-15 09:35:28.854535	2013-2014	16	3A	FA1	Mona - 17	Maths
603	40	\N	t	\N	1	62	4	1	12	2	Teacher	2014-07-15 09:35:28.880813	2014-07-15 09:35:28.880813	2012-2013	16	3A	FA1	Mona - 17	Maths
604	66	\N	t	\N	2	46	4	1	12	2	Teacher	2014-07-15 09:35:28.90998	2014-07-15 09:35:28.90998	2013-2014	16	3A	FA1	Ramesh - 1	Physics
605	56	\N	t	\N	2	46	4	1	12	2	Teacher	2014-07-15 09:35:28.938097	2014-07-15 09:35:28.938097	2012-2013	16	3A	FA1	Ramesh - 1	Physics
606	90	\N	t	\N	2	48	4	1	12	2	Teacher	2014-07-15 09:35:28.969752	2014-07-15 09:35:28.969752	2013-2014	16	3A	FA1	Dinesh - 3	Physics
607	80	\N	t	\N	2	48	4	1	12	2	Teacher	2014-07-15 09:35:28.995001	2014-07-15 09:35:28.995001	2012-2013	16	3A	FA1	Dinesh - 3	Physics
608	18	\N	f	\N	2	49	4	1	12	2	Teacher	2014-07-15 09:35:29.027624	2014-07-15 09:35:29.027624	2013-2014	16	3A	FA1	Prakash - 4	Physics
609	28	\N	f	\N	2	49	4	1	12	2	Teacher	2014-07-15 09:35:29.054595	2014-07-15 09:35:29.054595	2012-2013	16	3A	FA1	Prakash - 4	Physics
610	49	\N	f	\N	2	50	4	1	12	2	Teacher	2014-07-15 09:35:29.084965	2014-07-15 09:35:29.084965	2013-2014	16	3A	FA1	Satish - 5	Physics
611	49	\N	f	\N	2	50	4	1	12	2	Teacher	2014-07-15 09:35:29.112948	2014-07-15 09:35:29.112948	2012-2013	16	3A	FA1	Satish - 5	Physics
612	18	\N	f	\N	2	59	4	1	12	2	Teacher	2014-07-15 09:35:29.1448	2014-07-15 09:35:29.1448	2013-2014	16	3A	FA1	Anuj - 14	Physics
613	28	\N	f	\N	2	59	4	1	12	2	Teacher	2014-07-15 09:35:29.171391	2014-07-15 09:35:29.171391	2012-2013	16	3A	FA1	Anuj - 14	Physics
614	27	\N	f	\N	2	61	4	1	12	2	Teacher	2014-07-15 09:35:29.20385	2014-07-15 09:35:29.20385	2013-2014	16	3A	FA1	Rita - 16	Physics
615	37	\N	f	\N	2	61	4	1	12	2	Teacher	2014-07-15 09:35:29.231528	2014-07-15 09:35:29.231528	2012-2013	16	3A	FA1	Rita - 16	Physics
616	10	\N	f	\N	2	62	4	1	12	2	Teacher	2014-07-15 09:35:29.258982	2014-07-15 09:35:29.258982	2013-2014	16	3A	FA1	Mona - 17	Physics
617	20	\N	f	\N	2	62	4	1	12	2	Teacher	2014-07-15 09:35:29.291413	2014-07-15 09:35:29.291413	2012-2013	16	3A	FA1	Mona - 17	Physics
618	65	\N	t	\N	3	46	4	1	12	2	Teacher	2014-07-15 09:35:29.321424	2014-07-15 09:35:29.321424	2013-2014	16	3A	FA1	Ramesh - 1	Chemistry
619	55	\N	t	\N	3	46	4	1	12	2	Teacher	2014-07-15 09:35:29.369471	2014-07-15 09:35:29.369471	2012-2013	16	3A	FA1	Ramesh - 1	Chemistry
620	47	\N	t	\N	3	48	4	1	12	2	Teacher	2014-07-15 09:35:29.399833	2014-07-15 09:35:29.399833	2013-2014	16	3A	FA1	Dinesh - 3	Chemistry
621	47	\N	t	\N	3	48	4	1	12	2	Teacher	2014-07-15 09:35:29.434463	2014-07-15 09:35:29.434463	2012-2013	16	3A	FA1	Dinesh - 3	Chemistry
622	90	\N	t	\N	3	49	4	1	12	2	Teacher	2014-07-15 09:35:29.463671	2014-07-15 09:35:29.463671	2013-2014	16	3A	FA1	Prakash - 4	Chemistry
623	80	\N	t	\N	3	49	4	1	12	2	Teacher	2014-07-15 09:35:29.491018	2014-07-15 09:35:29.491018	2012-2013	16	3A	FA1	Prakash - 4	Chemistry
624	90	\N	t	\N	3	50	4	1	12	2	Teacher	2014-07-15 09:35:29.522059	2014-07-15 09:35:29.522059	2013-2014	16	3A	FA1	Satish - 5	Chemistry
625	80	\N	t	\N	3	50	4	1	12	2	Teacher	2014-07-15 09:35:29.550069	2014-07-15 09:35:29.550069	2012-2013	16	3A	FA1	Satish - 5	Chemistry
626	61	\N	t	\N	3	60	4	1	12	2	Teacher	2014-07-15 09:35:29.582572	2014-07-15 09:35:29.582572	2013-2014	16	3A	FA1	Swati - 15	Chemistry
627	51	\N	t	\N	3	60	4	1	12	2	Teacher	2014-07-15 09:35:29.614088	2014-07-15 09:35:29.614088	2012-2013	16	3A	FA1	Swati - 15	Chemistry
628	44	\N	t	\N	3	61	4	1	12	2	Teacher	2014-07-15 09:35:29.647043	2014-07-15 09:35:29.647043	2013-2014	16	3A	FA1	Rita - 16	Chemistry
629	44	\N	t	\N	3	61	4	1	12	2	Teacher	2014-07-15 09:35:29.676242	2014-07-15 09:35:29.676242	2012-2013	16	3A	FA1	Rita - 16	Chemistry
630	40	\N	t	\N	3	62	4	1	12	2	Teacher	2014-07-15 09:35:29.705463	2014-07-15 09:35:29.705463	2013-2014	16	3A	FA1	Mona - 17	Chemistry
631	40	\N	t	\N	3	62	4	1	12	2	Teacher	2014-07-15 09:35:29.734883	2014-07-15 09:35:29.734883	2012-2013	16	3A	FA1	Mona - 17	Chemistry
632	60	\N	t	\N	1	46	5	1	12	2	Teacher	2014-07-15 09:35:29.764873	2014-07-15 09:35:29.764873	2013-2014	16	3A	FA2	Ramesh - 1	Maths
633	50	\N	t	\N	1	46	5	1	12	2	Teacher	2014-07-15 09:35:29.796297	2014-07-15 09:35:29.796297	2012-2013	16	3A	FA2	Ramesh - 1	Maths
634	90	\N	t	\N	1	48	5	1	12	2	Teacher	2014-07-15 09:35:29.826878	2014-07-15 09:35:29.826878	2013-2014	16	3A	FA2	Dinesh - 3	Maths
635	80	\N	t	\N	1	48	5	1	12	2	Teacher	2014-07-15 09:35:29.859235	2014-07-15 09:35:29.859235	2012-2013	16	3A	FA2	Dinesh - 3	Maths
636	46	\N	f	\N	1	49	5	1	12	2	Teacher	2014-07-15 09:35:29.889887	2014-07-15 09:35:29.889887	2013-2014	16	3A	FA2	Prakash - 4	Maths
637	46	\N	f	\N	1	49	5	1	12	2	Teacher	2014-07-15 09:35:29.918597	2014-07-15 09:35:29.918597	2012-2013	16	3A	FA2	Prakash - 4	Maths
638	49	\N	t	\N	1	50	5	1	12	2	Teacher	2014-07-15 09:35:29.951588	2014-07-15 09:35:29.951588	2013-2014	16	3A	FA2	Satish - 5	Maths
639	49	\N	t	\N	1	50	5	1	12	2	Teacher	2014-07-15 09:35:29.983071	2014-07-15 09:35:29.983071	2012-2013	16	3A	FA2	Satish - 5	Maths
640	86	\N	t	\N	1	59	5	1	12	2	Teacher	2014-07-15 09:35:30.015138	2014-07-15 09:35:30.015138	2013-2014	16	3A	FA2	Anuj - 14	Maths
641	76	\N	t	\N	1	59	5	1	12	2	Teacher	2014-07-15 09:35:30.044108	2014-07-15 09:35:30.044108	2012-2013	16	3A	FA2	Anuj - 14	Maths
642	49	\N	t	\N	1	61	5	1	12	2	Teacher	2014-07-15 09:35:30.072513	2014-07-15 09:35:30.072513	2013-2014	16	3A	FA2	Rita - 16	Maths
643	49	\N	t	\N	1	61	5	1	12	2	Teacher	2014-07-15 09:35:30.103569	2014-07-15 09:35:30.103569	2012-2013	16	3A	FA2	Rita - 16	Maths
644	31	\N	f	\N	1	62	5	1	12	2	Teacher	2014-07-15 09:35:30.132945	2014-07-15 09:35:30.132945	2013-2014	16	3A	FA2	Mona - 17	Maths
645	41	\N	f	\N	1	62	5	1	12	2	Teacher	2014-07-15 09:35:30.166625	2014-07-15 09:35:30.166625	2012-2013	16	3A	FA2	Mona - 17	Maths
646	76	\N	t	\N	2	46	5	1	12	2	Teacher	2014-07-15 09:35:30.199235	2014-07-15 09:35:30.199235	2013-2014	16	3A	FA2	Ramesh - 1	Physics
647	66	\N	t	\N	2	46	5	1	12	2	Teacher	2014-07-15 09:35:30.227719	2014-07-15 09:35:30.227719	2012-2013	16	3A	FA2	Ramesh - 1	Physics
648	71	\N	t	\N	2	47	5	1	12	2	Teacher	2014-07-15 09:35:30.257978	2014-07-15 09:35:30.257978	2013-2014	16	3A	FA2	Suresh - 2	Physics
649	61	\N	t	\N	2	47	5	1	12	2	Teacher	2014-07-15 09:35:30.285955	2014-07-15 09:35:30.285955	2012-2013	16	3A	FA2	Suresh - 2	Physics
650	76	\N	t	\N	2	49	5	1	12	2	Teacher	2014-07-15 09:35:30.318485	2014-07-15 09:35:30.318485	2013-2014	16	3A	FA2	Prakash - 4	Physics
651	66	\N	t	\N	2	49	5	1	12	2	Teacher	2014-07-15 09:35:30.347464	2014-07-15 09:35:30.347464	2012-2013	16	3A	FA2	Prakash - 4	Physics
652	70	\N	t	\N	2	50	5	1	12	2	Teacher	2014-07-15 09:35:30.376312	2014-07-15 09:35:30.376312	2013-2014	16	3A	FA2	Satish - 5	Physics
653	60	\N	t	\N	2	50	5	1	12	2	Teacher	2014-07-15 09:35:30.404654	2014-07-15 09:35:30.404654	2012-2013	16	3A	FA2	Satish - 5	Physics
654	72	\N	t	\N	2	59	5	1	12	2	Teacher	2014-07-15 09:35:30.436697	2014-07-15 09:35:30.436697	2013-2014	16	3A	FA2	Anuj - 14	Physics
655	62	\N	t	\N	2	59	5	1	12	2	Teacher	2014-07-15 09:35:30.465437	2014-07-15 09:35:30.465437	2012-2013	16	3A	FA2	Anuj - 14	Physics
656	37	\N	f	\N	2	61	5	1	12	2	Teacher	2014-07-15 09:35:30.493546	2014-07-15 09:35:30.493546	2013-2014	16	3A	FA2	Rita - 16	Physics
657	47	\N	f	\N	2	61	5	1	12	2	Teacher	2014-07-15 09:35:30.526746	2014-07-15 09:35:30.526746	2012-2013	16	3A	FA2	Rita - 16	Physics
658	15	\N	f	\N	2	62	5	1	12	2	Teacher	2014-07-15 09:35:30.551004	2014-07-15 09:35:30.551004	2013-2014	16	3A	FA2	Mona - 17	Physics
659	25	\N	f	\N	2	62	5	1	12	2	Teacher	2014-07-15 09:35:30.581423	2014-07-15 09:35:30.581423	2012-2013	16	3A	FA2	Mona - 17	Physics
660	68	\N	t	\N	3	46	5	1	12	2	Teacher	2014-07-15 09:35:30.611951	2014-07-15 09:35:30.611951	2013-2014	16	3A	FA2	Ramesh - 1	Chemistry
661	58	\N	t	\N	3	46	5	1	12	2	Teacher	2014-07-15 09:35:30.680845	2014-07-15 09:35:30.680845	2012-2013	16	3A	FA2	Ramesh - 1	Chemistry
662	86	\N	t	\N	3	48	5	1	12	2	Teacher	2014-07-15 09:35:30.710441	2014-07-15 09:35:30.710441	2013-2014	16	3A	FA2	Dinesh - 3	Chemistry
663	76	\N	t	\N	3	48	5	1	12	2	Teacher	2014-07-15 09:35:30.740897	2014-07-15 09:35:30.740897	2012-2013	16	3A	FA2	Dinesh - 3	Chemistry
664	40	\N	f	\N	3	49	5	1	12	2	Teacher	2014-07-15 09:35:30.771906	2014-07-15 09:35:30.771906	2013-2014	16	3A	FA2	Prakash - 4	Chemistry
665	40	\N	f	\N	3	49	5	1	12	2	Teacher	2014-07-15 09:35:30.799787	2014-07-15 09:35:30.799787	2012-2013	16	3A	FA2	Prakash - 4	Chemistry
666	29	\N	f	\N	3	50	5	1	12	2	Teacher	2014-07-15 09:35:30.827325	2014-07-15 09:35:30.827325	2013-2014	16	3A	FA2	Satish - 5	Chemistry
667	39	\N	f	\N	3	50	5	1	12	2	Teacher	2014-07-15 09:35:30.861545	2014-07-15 09:35:30.861545	2012-2013	16	3A	FA2	Satish - 5	Chemistry
668	72	\N	t	\N	3	59	5	1	12	2	Teacher	2014-07-15 09:35:30.887821	2014-07-15 09:35:30.887821	2013-2014	16	3A	FA2	Anuj - 14	Chemistry
669	62	\N	t	\N	3	59	5	1	12	2	Teacher	2014-07-15 09:35:30.914703	2014-07-15 09:35:30.914703	2012-2013	16	3A	FA2	Anuj - 14	Chemistry
670	41	\N	f	\N	3	61	5	1	12	2	Teacher	2014-07-15 09:35:30.945519	2014-07-15 09:35:30.945519	2013-2014	16	3A	FA2	Rita - 16	Chemistry
671	41	\N	f	\N	3	61	5	1	12	2	Teacher	2014-07-15 09:35:30.973349	2014-07-15 09:35:30.973349	2012-2013	16	3A	FA2	Rita - 16	Chemistry
672	68	\N	t	\N	3	62	5	1	12	2	Teacher	2014-07-15 09:35:31.00544	2014-07-15 09:35:31.00544	2013-2014	16	3A	FA2	Mona - 17	Chemistry
673	58	\N	t	\N	3	62	5	1	12	2	Teacher	2014-07-15 09:35:31.037714	2014-07-15 09:35:31.037714	2012-2013	16	3A	FA2	Mona - 17	Chemistry
674	66	\N	t	\N	1	46	6	1	12	2	Teacher	2014-07-15 09:35:31.06375	2014-07-15 09:35:31.06375	2013-2014	16	3A	FA3	Ramesh - 1	Maths
675	56	\N	t	\N	1	46	6	1	12	2	Teacher	2014-07-15 09:35:31.090548	2014-07-15 09:35:31.090548	2012-2013	16	3A	FA3	Ramesh - 1	Maths
676	74	\N	t	\N	1	48	6	1	12	2	Teacher	2014-07-15 09:35:31.122134	2014-07-15 09:35:31.122134	2013-2014	16	3A	FA3	Dinesh - 3	Maths
677	64	\N	t	\N	1	48	6	1	12	2	Teacher	2014-07-15 09:35:31.153339	2014-07-15 09:35:31.153339	2012-2013	16	3A	FA3	Dinesh - 3	Maths
678	66	\N	t	\N	1	49	6	1	12	2	Teacher	2014-07-15 09:35:31.178859	2014-07-15 09:35:31.178859	2013-2014	16	3A	FA3	Prakash - 4	Maths
679	56	\N	t	\N	1	49	6	1	12	2	Teacher	2014-07-15 09:35:31.208251	2014-07-15 09:35:31.208251	2012-2013	16	3A	FA3	Prakash - 4	Maths
680	37	\N	f	\N	1	50	6	1	12	2	Teacher	2014-07-15 09:35:31.236979	2014-07-15 09:35:31.236979	2013-2014	16	3A	FA3	Satish - 5	Maths
681	47	\N	f	\N	1	50	6	1	12	2	Teacher	2014-07-15 09:35:31.26796	2014-07-15 09:35:31.26796	2012-2013	16	3A	FA3	Satish - 5	Maths
682	62	\N	t	\N	1	59	6	1	12	2	Teacher	2014-07-15 09:35:31.298715	2014-07-15 09:35:31.298715	2013-2014	16	3A	FA3	Anuj - 14	Maths
683	52	\N	t	\N	1	59	6	1	12	2	Teacher	2014-07-15 09:35:31.327606	2014-07-15 09:35:31.327606	2012-2013	16	3A	FA3	Anuj - 14	Maths
684	28	\N	f	\N	1	61	6	1	12	2	Teacher	2014-07-15 09:35:31.358944	2014-07-15 09:35:31.358944	2013-2014	16	3A	FA3	Rita - 16	Maths
685	38	\N	f	\N	1	61	6	1	12	2	Teacher	2014-07-15 09:35:31.388024	2014-07-15 09:35:31.388024	2012-2013	16	3A	FA3	Rita - 16	Maths
686	90	\N	t	\N	1	62	6	1	12	2	Teacher	2014-07-15 09:35:31.417711	2014-07-15 09:35:31.417711	2013-2014	16	3A	FA3	Mona - 17	Maths
687	80	\N	t	\N	1	62	6	1	12	2	Teacher	2014-07-15 09:35:31.449869	2014-07-15 09:35:31.449869	2012-2013	16	3A	FA3	Mona - 17	Maths
688	90	\N	t	\N	2	46	6	1	12	2	Teacher	2014-07-15 09:35:31.475793	2014-07-15 09:35:31.475793	2013-2014	16	3A	FA3	Ramesh - 1	Physics
689	80	\N	t	\N	2	46	6	1	12	2	Teacher	2014-07-15 09:35:31.544918	2014-07-15 09:35:31.544918	2012-2013	16	3A	FA3	Ramesh - 1	Physics
690	90	\N	t	\N	2	47	6	1	12	2	Teacher	2014-07-15 09:35:31.580511	2014-07-15 09:35:31.580511	2013-2014	16	3A	FA3	Suresh - 2	Physics
691	80	\N	t	\N	2	47	6	1	12	2	Teacher	2014-07-15 09:35:31.604065	2014-07-15 09:35:31.604065	2012-2013	16	3A	FA3	Suresh - 2	Physics
692	48	\N	f	\N	1	26	4	1	10	2	Teacher	2014-07-15 09:35:31.634494	2014-07-15 09:35:31.634494	2013-2014	14	2A	FA1	Ramesh - 1	Maths
693	48	\N	f	\N	1	26	4	1	10	2	Teacher	2014-07-15 09:35:31.663454	2014-07-15 09:35:31.663454	2012-2013	14	2A	FA1	Ramesh - 1	Maths
694	40	\N	f	\N	1	28	4	1	10	2	Teacher	2014-07-15 09:35:31.698819	2014-07-15 09:35:31.698819	2013-2014	14	2A	FA1	Dinesh - 3	Maths
695	40	\N	f	\N	1	28	4	1	10	2	Teacher	2014-07-15 09:35:31.735905	2014-07-15 09:35:31.735905	2012-2013	14	2A	FA1	Dinesh - 3	Maths
696	82	\N	t	\N	1	40	4	1	10	2	Teacher	2014-07-15 09:35:31.771813	2014-07-15 09:35:31.771813	2013-2014	14	2A	FA1	Swati - 15	Maths
697	72	\N	t	\N	1	40	4	1	10	2	Teacher	2014-07-15 09:35:31.798149	2014-07-15 09:35:31.798149	2012-2013	14	2A	FA1	Swati - 15	Maths
698	90	\N	t	\N	2	28	4	1	10	2	Teacher	2014-07-15 09:35:31.832243	2014-07-15 09:35:31.832243	2013-2014	14	2A	FA1	Dinesh - 3	Physics
699	80	\N	t	\N	2	28	4	1	10	2	Teacher	2014-07-15 09:35:31.859239	2014-07-15 09:35:31.859239	2012-2013	14	2A	FA1	Dinesh - 3	Physics
700	27	\N	f	\N	2	40	4	1	10	2	Teacher	2014-07-15 09:35:31.889228	2014-07-15 09:35:31.889228	2013-2014	14	2A	FA1	Swati - 15	Physics
701	37	\N	f	\N	2	40	4	1	10	2	Teacher	2014-07-15 09:35:31.919178	2014-07-15 09:35:31.919178	2012-2013	14	2A	FA1	Swati - 15	Physics
702	59	\N	t	Set the remarks here	1	20	4	1	6	2	Teacher	2014-07-15 09:35:31.952331	2014-07-15 09:35:31.952331	2013-2014	6	1A	FA1	Swati - 15	Maths
703	49	\N	t	Set the remarks here	1	20	4	1	6	2	Teacher	2014-07-15 09:35:31.979799	2014-07-15 09:35:31.979799	2012-2013	6	1A	FA1	Swati - 15	Maths
704	51	\N	t	Set the remarks here	2	8	4	1	6	2	Teacher	2014-07-15 09:35:32.009412	2014-07-15 09:35:32.009412	2013-2014	6	1A	FA1	Dinesh - 3	Physics
705	41	\N	t	Set the remarks here	2	8	4	1	6	2	Teacher	2014-07-15 09:35:32.037705	2014-07-15 09:35:32.037705	2012-2013	6	1A	FA1	Dinesh - 3	Physics
706	27	\N	f	Set the remarks here	2	21	4	1	6	2	Teacher	2014-07-15 09:35:32.068483	2014-07-15 09:35:32.068483	2013-2014	6	1A	FA1	Rita - 16	Physics
707	37	\N	f	Set the remarks here	2	21	4	1	6	2	Teacher	2014-07-15 09:35:32.097503	2014-07-15 09:35:32.097503	2012-2013	6	1A	FA1	Rita - 16	Physics
708	42	\N	t	Set the remarks here	3	9	4	1	6	2	Teacher	2014-07-15 09:35:32.131588	2014-07-15 09:35:32.131588	2013-2014	6	1A	FA1	Prakash - 4	Chemistry
709	42	\N	t	Set the remarks here	3	9	4	1	6	2	Teacher	2014-07-15 09:35:32.170899	2014-07-15 09:35:32.170899	2012-2013	6	1A	FA1	Prakash - 4	Chemistry
710	44	\N	t	Set the remarks here	3	21	4	1	6	2	Teacher	2014-07-15 09:35:32.238532	2014-07-15 09:35:32.238532	2013-2014	6	1A	FA1	Rita - 16	Chemistry
711	44	\N	t	Set the remarks here	3	21	4	1	6	2	Teacher	2014-07-15 09:35:32.271055	2014-07-15 09:35:32.271055	2012-2013	6	1A	FA1	Rita - 16	Chemistry
712	49	\N	t	Set the remarks here	1	21	5	1	6	2	Teacher	2014-07-15 09:35:32.337882	2014-07-15 09:35:32.337882	2013-2014	6	1A	FA2	Rita - 16	Maths
713	49	\N	t	Set the remarks here	1	21	5	1	6	2	Teacher	2014-07-15 09:35:32.367627	2014-07-15 09:35:32.367627	2012-2013	6	1A	FA2	Rita - 16	Maths
714	76	\N	t	Set the remarks here	2	9	5	1	6	2	Teacher	2014-07-15 09:35:32.398424	2014-07-15 09:35:32.398424	2013-2014	6	1A	FA2	Prakash - 4	Physics
715	66	\N	t	Set the remarks here	2	9	5	1	6	2	Teacher	2014-07-15 09:35:32.426802	2014-07-15 09:35:32.426802	2012-2013	6	1A	FA2	Prakash - 4	Physics
716	37	\N	f	Set the remarks here	2	21	5	1	6	2	Teacher	2014-07-15 09:35:32.457126	2014-07-15 09:35:32.457126	2013-2014	6	1A	FA2	Rita - 16	Physics
717	47	\N	f	Set the remarks here	2	21	5	1	6	2	Teacher	2014-07-15 09:35:32.486062	2014-07-15 09:35:32.486062	2012-2013	6	1A	FA2	Rita - 16	Physics
718	86	\N	t	Set the remarks here	3	8	5	1	6	2	Teacher	2014-07-15 09:35:32.516306	2014-07-15 09:35:32.516306	2013-2014	6	1A	FA2	Dinesh - 3	Chemistry
719	76	\N	t	Set the remarks here	3	8	5	1	6	2	Teacher	2014-07-15 09:35:32.546379	2014-07-15 09:35:32.546379	2012-2013	6	1A	FA2	Dinesh - 3	Chemistry
720	41	\N	f	Set the remarks here	3	21	5	1	6	2	Teacher	2014-07-15 09:35:32.576036	2014-07-15 09:35:32.576036	2013-2014	6	1A	FA2	Rita - 16	Chemistry
721	41	\N	f	Set the remarks here	3	21	5	1	6	2	Teacher	2014-07-15 09:35:32.603887	2014-07-15 09:35:32.603887	2012-2013	6	1A	FA2	Rita - 16	Chemistry
722	66	\N	t	Set the remarks here	1	9	6	1	6	2	Teacher	2014-07-15 09:35:32.636043	2014-07-15 09:35:32.636043	2013-2014	6	1A	FA3	Prakash - 4	Maths
723	56	\N	t	Set the remarks here	1	9	6	1	6	2	Teacher	2014-07-15 09:35:32.670922	2014-07-15 09:35:32.670922	2012-2013	6	1A	FA3	Prakash - 4	Maths
724	41	\N	t	Set the remarks here	2	19	6	1	6	2	Teacher	2014-07-15 09:35:32.700628	2014-07-15 09:35:32.700628	2013-2014	6	1A	FA3	Anuj - 14	Physics
725	41	\N	t	Set the remarks here	2	19	6	1	6	2	Teacher	2014-07-15 09:35:32.732107	2014-07-15 09:35:32.732107	2012-2013	6	1A	FA3	Anuj - 14	Physics
726	86	\N	t	Set the remarks here	3	7	6	1	6	2	Teacher	2014-07-15 09:35:32.760882	2014-07-15 09:35:32.760882	2013-2014	6	1A	FA3	Suresh - 2	Chemistry
727	76	\N	t	Set the remarks here	3	7	6	1	6	2	Teacher	2014-07-15 09:35:32.788051	2014-07-15 09:35:32.788051	2012-2013	6	1A	FA3	Suresh - 2	Chemistry
728	44	\N	t	Set the remarks here	3	19	6	1	6	2	Teacher	2014-07-15 09:35:32.817764	2014-07-15 09:35:32.817764	2013-2014	6	1A	FA3	Anuj - 14	Chemistry
729	44	\N	t	Set the remarks here	3	19	6	1	6	2	Teacher	2014-07-15 09:35:32.851034	2014-07-15 09:35:32.851034	2012-2013	6	1A	FA3	Anuj - 14	Chemistry
730	40	\N	f	\N	3	27	4	1	10	2	Teacher	2014-07-15 09:35:32.884211	2014-07-15 09:35:32.884211	2013-2014	14	2A	FA1	Suresh - 2	Chemistry
731	40	\N	f	\N	3	27	4	1	10	2	Teacher	2014-07-15 09:35:32.914024	2014-07-15 09:35:32.914024	2012-2013	14	2A	FA1	Suresh - 2	Chemistry
732	74	\N	t	\N	3	38	4	1	10	2	Teacher	2014-07-15 09:35:32.945853	2014-07-15 09:35:32.945853	2013-2014	14	2A	FA1	Manoj - 13	Chemistry
733	64	\N	t	\N	3	38	4	1	10	2	Teacher	2014-07-15 09:35:32.971999	2014-07-15 09:35:32.971999	2012-2013	14	2A	FA1	Manoj - 13	Chemistry
734	60	\N	t	\N	1	26	5	1	10	2	Teacher	2014-07-15 09:35:33.001055	2014-07-15 09:35:33.001055	2013-2014	14	2A	FA2	Ramesh - 1	Maths
735	50	\N	t	\N	1	26	5	1	10	2	Teacher	2014-07-15 09:35:33.029403	2014-07-15 09:35:33.029403	2012-2013	14	2A	FA2	Ramesh - 1	Maths
736	86	\N	t	\N	1	38	5	1	10	2	Teacher	2014-07-15 09:35:33.059961	2014-07-15 09:35:33.059961	2013-2014	14	2A	FA2	Manoj - 13	Maths
737	76	\N	t	\N	1	38	5	1	10	2	Teacher	2014-07-15 09:35:33.088405	2014-07-15 09:35:33.088405	2012-2013	14	2A	FA2	Manoj - 13	Maths
738	71	\N	t	\N	2	27	5	1	10	2	Teacher	2014-07-15 09:35:33.12027	2014-07-15 09:35:33.12027	2013-2014	14	2A	FA2	Suresh - 2	Physics
739	61	\N	t	\N	2	27	5	1	10	2	Teacher	2014-07-15 09:35:33.147585	2014-07-15 09:35:33.147585	2012-2013	14	2A	FA2	Suresh - 2	Physics
740	48	\N	f	\N	1	46	4	1	12	2	Teacher	2014-07-15 09:35:33.178597	2014-07-15 09:35:33.178597	2013-2014	16	3A	FA1	Ramesh - 1	Maths
741	48	\N	f	\N	1	46	4	1	12	2	Teacher	2014-07-15 09:35:33.209147	2014-07-15 09:35:33.209147	2012-2013	16	3A	FA1	Ramesh - 1	Maths
742	32	\N	f	\N	1	47	4	1	12	2	Teacher	2014-07-15 09:35:33.237007	2014-07-15 09:35:33.237007	2013-2014	16	3A	FA1	Suresh - 2	Maths
743	42	\N	f	\N	1	47	4	1	12	2	Teacher	2014-07-15 09:35:33.264564	2014-07-15 09:35:33.264564	2012-2013	16	3A	FA1	Suresh - 2	Maths
744	59	\N	t	\N	1	60	4	1	12	2	Teacher	2014-07-15 09:35:33.292389	2014-07-15 09:35:33.292389	2013-2014	16	3A	FA1	Swati - 15	Maths
745	49	\N	t	\N	1	60	4	1	12	2	Teacher	2014-07-15 09:35:33.322077	2014-07-15 09:35:33.322077	2012-2013	16	3A	FA1	Swati - 15	Maths
746	90	\N	t	\N	2	47	4	1	12	2	Teacher	2014-07-15 09:35:33.353278	2014-07-15 09:35:33.353278	2013-2014	16	3A	FA1	Suresh - 2	Physics
747	80	\N	t	\N	2	47	4	1	12	2	Teacher	2014-07-15 09:35:33.382106	2014-07-15 09:35:33.382106	2012-2013	16	3A	FA1	Suresh - 2	Physics
748	45	\N	f	\N	2	60	4	1	12	2	Teacher	2014-07-15 09:35:33.410785	2014-07-15 09:35:33.410785	2013-2014	16	3A	FA1	Swati - 15	Physics
749	45	\N	f	\N	2	60	4	1	12	2	Teacher	2014-07-15 09:35:33.4405	2014-07-15 09:35:33.4405	2012-2013	16	3A	FA1	Swati - 15	Physics
750	40	\N	f	\N	3	47	4	1	12	2	Teacher	2014-07-15 09:35:33.469769	2014-07-15 09:35:33.469769	2013-2014	16	3A	FA1	Suresh - 2	Chemistry
751	40	\N	f	\N	3	47	4	1	12	2	Teacher	2014-07-15 09:35:33.499697	2014-07-15 09:35:33.499697	2012-2013	16	3A	FA1	Suresh - 2	Chemistry
752	74	\N	t	\N	3	59	4	1	12	2	Teacher	2014-07-15 09:35:33.538001	2014-07-15 09:35:33.538001	2013-2014	16	3A	FA1	Anuj - 14	Chemistry
753	64	\N	t	\N	3	59	4	1	12	2	Teacher	2014-07-15 09:35:33.56709	2014-07-15 09:35:33.56709	2012-2013	16	3A	FA1	Anuj - 14	Chemistry
754	90	\N	t	\N	1	47	5	1	12	2	Teacher	2014-07-15 09:35:33.600585	2014-07-15 09:35:33.600585	2013-2014	16	3A	FA2	Suresh - 2	Maths
755	80	\N	t	\N	1	47	5	1	12	2	Teacher	2014-07-15 09:35:33.623755	2014-07-15 09:35:33.623755	2012-2013	16	3A	FA2	Suresh - 2	Maths
756	82	\N	t	\N	1	60	5	1	12	2	Teacher	2014-07-15 09:35:33.654504	2014-07-15 09:35:33.654504	2013-2014	16	3A	FA2	Swati - 15	Maths
757	72	\N	t	\N	1	60	5	1	12	2	Teacher	2014-07-15 09:35:33.684325	2014-07-15 09:35:33.684325	2012-2013	16	3A	FA2	Swati - 15	Maths
758	19	\N	f	\N	2	48	5	1	12	2	Teacher	2014-07-15 09:35:33.71616	2014-07-15 09:35:33.71616	2013-2014	16	3A	FA2	Dinesh - 3	Physics
759	29	\N	f	\N	2	48	5	1	12	2	Teacher	2014-07-15 09:35:33.74147	2014-07-15 09:35:33.74147	2012-2013	16	3A	FA2	Dinesh - 3	Physics
760	63	\N	t	\N	2	60	5	1	12	2	Teacher	2014-07-15 09:35:33.770995	2014-07-15 09:35:33.770995	2013-2014	16	3A	FA2	Swati - 15	Physics
761	53	\N	t	\N	2	60	5	1	12	2	Teacher	2014-07-15 09:35:33.801268	2014-07-15 09:35:33.801268	2012-2013	16	3A	FA2	Swati - 15	Physics
762	49	\N	t	\N	3	47	5	1	12	2	Teacher	2014-07-15 09:35:33.832027	2014-07-15 09:35:33.832027	2013-2014	16	3A	FA2	Suresh - 2	Chemistry
763	49	\N	t	\N	3	47	5	1	12	2	Teacher	2014-07-15 09:35:33.860046	2014-07-15 09:35:33.860046	2012-2013	16	3A	FA2	Suresh - 2	Chemistry
764	75	\N	t	\N	2	49	6	1	12	2	Teacher	2014-07-15 09:35:33.893754	2014-07-15 09:35:33.893754	2013-2014	16	3A	FA3	Prakash - 4	Physics
765	65	\N	t	\N	2	49	6	1	12	2	Teacher	2014-07-15 09:35:33.927697	2014-07-15 09:35:33.927697	2012-2013	16	3A	FA3	Prakash - 4	Physics
766	88	\N	t	\N	2	50	6	1	12	2	Teacher	2014-07-15 09:35:33.954707	2014-07-15 09:35:33.954707	2013-2014	16	3A	FA3	Satish - 5	Physics
767	78	\N	t	\N	2	50	6	1	12	2	Teacher	2014-07-15 09:35:33.986173	2014-07-15 09:35:33.986173	2012-2013	16	3A	FA3	Satish - 5	Physics
768	21	\N	f	\N	2	60	6	1	12	2	Teacher	2014-07-15 09:35:34.014495	2014-07-15 09:35:34.014495	2013-2014	16	3A	FA3	Swati - 15	Physics
769	31	\N	f	\N	2	60	6	1	12	2	Teacher	2014-07-15 09:35:34.044245	2014-07-15 09:35:34.044245	2012-2013	16	3A	FA3	Swati - 15	Physics
770	18	\N	f	\N	2	61	6	1	12	2	Teacher	2014-07-15 09:35:34.074189	2014-07-15 09:35:34.074189	2013-2014	16	3A	FA3	Rita - 16	Physics
771	28	\N	f	\N	2	61	6	1	12	2	Teacher	2014-07-15 09:35:34.104043	2014-07-15 09:35:34.104043	2012-2013	16	3A	FA3	Rita - 16	Physics
772	66	\N	t	\N	2	62	6	1	12	2	Teacher	2014-07-15 09:35:34.134693	2014-07-15 09:35:34.134693	2013-2014	16	3A	FA3	Mona - 17	Physics
773	56	\N	t	\N	2	62	6	1	12	2	Teacher	2014-07-15 09:35:34.165835	2014-07-15 09:35:34.165835	2012-2013	16	3A	FA3	Mona - 17	Physics
774	47	\N	f	\N	3	46	6	1	12	2	Teacher	2014-07-15 09:35:34.198298	2014-07-15 09:35:34.198298	2013-2014	16	3A	FA3	Ramesh - 1	Chemistry
775	47	\N	f	\N	3	46	6	1	12	2	Teacher	2014-07-15 09:35:34.224776	2014-07-15 09:35:34.224776	2012-2013	16	3A	FA3	Ramesh - 1	Chemistry
776	46	\N	t	\N	3	48	6	1	12	2	Teacher	2014-07-15 09:35:34.254717	2014-07-15 09:35:34.254717	2013-2014	16	3A	FA3	Dinesh - 3	Chemistry
777	46	\N	t	\N	3	48	6	1	12	2	Teacher	2014-07-15 09:35:34.286529	2014-07-15 09:35:34.286529	2012-2013	16	3A	FA3	Dinesh - 3	Chemistry
778	26	\N	f	\N	3	49	6	1	12	2	Teacher	2014-07-15 09:35:34.319388	2014-07-15 09:35:34.319388	2013-2014	16	3A	FA3	Prakash - 4	Chemistry
779	36	\N	f	\N	3	49	6	1	12	2	Teacher	2014-07-15 09:35:34.349749	2014-07-15 09:35:34.349749	2012-2013	16	3A	FA3	Prakash - 4	Chemistry
780	61	\N	t	\N	3	50	6	1	12	2	Teacher	2014-07-15 09:35:34.381009	2014-07-15 09:35:34.381009	2013-2014	16	3A	FA3	Satish - 5	Chemistry
781	51	\N	t	\N	3	50	6	1	12	2	Teacher	2014-07-15 09:35:34.408419	2014-07-15 09:35:34.408419	2012-2013	16	3A	FA3	Satish - 5	Chemistry
782	72	\N	t	\N	3	60	6	1	12	2	Teacher	2014-07-15 09:35:34.43934	2014-07-15 09:35:34.43934	2013-2014	16	3A	FA3	Swati - 15	Chemistry
783	62	\N	t	\N	3	60	6	1	12	2	Teacher	2014-07-15 09:35:34.469625	2014-07-15 09:35:34.469625	2012-2013	16	3A	FA3	Swati - 15	Chemistry
784	32	\N	f	\N	3	61	6	1	12	2	Teacher	2014-07-15 09:35:34.499084	2014-07-15 09:35:34.499084	2013-2014	16	3A	FA3	Rita - 16	Chemistry
785	42	\N	f	\N	3	61	6	1	12	2	Teacher	2014-07-15 09:35:34.528461	2014-07-15 09:35:34.528461	2012-2013	16	3A	FA3	Rita - 16	Chemistry
786	12	\N	f	\N	3	62	6	1	12	2	Teacher	2014-07-15 09:35:34.557954	2014-07-15 09:35:34.557954	2013-2014	16	3A	FA3	Mona - 17	Chemistry
787	22	\N	f	\N	3	62	6	1	12	2	Teacher	2014-07-15 09:35:34.586983	2014-07-15 09:35:34.586983	2012-2013	16	3A	FA3	Mona - 17	Chemistry
788	49	\N	t	\N	3	60	5	1	12	2	Teacher	2014-07-15 09:35:34.617005	2014-07-15 09:35:34.617005	2013-2014	16	3A	FA2	Swati - 15	Chemistry
789	49	\N	t	\N	3	60	5	1	12	2	Teacher	2014-07-15 09:35:34.648674	2014-07-15 09:35:34.648674	2012-2013	16	3A	FA2	Swati - 15	Chemistry
790	53	\N	t	\N	1	47	6	1	12	2	Teacher	2014-07-15 09:35:34.677442	2014-07-15 09:35:34.677442	2013-2014	16	3A	FA3	Suresh - 2	Maths
791	43	\N	t	\N	1	47	6	1	12	2	Teacher	2014-07-15 09:35:34.710615	2014-07-15 09:35:34.710615	2012-2013	16	3A	FA3	Suresh - 2	Maths
792	47	\N	t	\N	1	60	6	1	12	2	Teacher	2014-07-15 09:35:34.7443	2014-07-15 09:35:34.7443	2013-2014	16	3A	FA3	Swati - 15	Maths
793	47	\N	t	\N	1	60	6	1	12	2	Teacher	2014-07-15 09:35:34.774958	2014-07-15 09:35:34.774958	2012-2013	16	3A	FA3	Swati - 15	Maths
794	53	\N	t	\N	2	48	6	1	12	2	Teacher	2014-07-15 09:35:34.80361	2014-07-15 09:35:34.80361	2013-2014	16	3A	FA3	Dinesh - 3	Physics
795	43	\N	t	\N	2	48	6	1	12	2	Teacher	2014-07-15 09:35:34.832708	2014-07-15 09:35:34.832708	2012-2013	16	3A	FA3	Dinesh - 3	Physics
796	41	\N	t	\N	2	59	6	1	12	2	Teacher	2014-07-15 09:35:34.866025	2014-07-15 09:35:34.866025	2013-2014	16	3A	FA3	Anuj - 14	Physics
797	41	\N	t	\N	2	59	6	1	12	2	Teacher	2014-07-15 09:35:34.892034	2014-07-15 09:35:34.892034	2012-2013	16	3A	FA3	Anuj - 14	Physics
798	86	\N	t	\N	3	47	6	1	12	2	Teacher	2014-07-15 09:35:34.922317	2014-07-15 09:35:34.922317	2013-2014	16	3A	FA3	Suresh - 2	Chemistry
799	76	\N	t	\N	3	47	6	1	12	2	Teacher	2014-07-15 09:35:34.951589	2014-07-15 09:35:34.951589	2012-2013	16	3A	FA3	Suresh - 2	Chemistry
800	44	\N	t	\N	3	59	6	1	12	2	Teacher	2014-07-15 09:35:34.98152	2014-07-15 09:35:34.98152	2013-2014	16	3A	FA3	Anuj - 14	Chemistry
801	44	\N	t	\N	3	59	6	1	12	2	Teacher	2014-07-15 09:35:35.0143	2014-07-15 09:35:35.0143	2012-2013	16	3A	FA3	Anuj - 14	Chemistry
802	60	\N	t	Set the remarks here	1	6	5	1	6	2	Teacher	2014-07-15 09:35:35.043024	2014-07-15 09:35:35.043024	2013-2014	6	1A	FA2	Ramesh Sharma - 1	Maths
803	50	\N	t	Set the remarks here	1	6	5	1	6	2	Teacher	2014-07-15 09:35:35.075461	2014-07-15 09:35:35.075461	2012-2013	6	1A	FA2	Ramesh Sharma - 1	Maths
804	76	\N	t	Set the remarks here	2	6	5	1	6	2	Teacher	2014-07-15 09:35:35.108379	2014-07-15 09:35:35.108379	2013-2014	6	1A	FA2	Ramesh Sharma - 1	Physics
805	66	\N	t	Set the remarks here	2	6	5	1	6	2	Teacher	2014-07-15 09:35:35.137945	2014-07-15 09:35:35.137945	2012-2013	6	1A	FA2	Ramesh Sharma - 1	Physics
806	68	\N	t	Set the remarks here	3	6	5	1	6	2	Teacher	2014-07-15 09:35:35.169231	2014-07-15 09:35:35.169231	2013-2014	6	1A	FA2	Ramesh Sharma - 1	Chemistry
807	58	\N	t	Set the remarks here	3	6	5	1	6	2	Teacher	2014-07-15 09:35:35.202418	2014-07-15 09:35:35.202418	2012-2013	6	1A	FA2	Ramesh Sharma - 1	Chemistry
808	66	\N	t	Set the remarks here	1	6	6	1	6	2	Teacher	2014-07-15 09:35:35.235088	2014-07-15 09:35:35.235088	2013-2014	6	1A	FA3	Ramesh Sharma - 1	Maths
809	56	\N	t	Set the remarks here	1	6	6	1	6	2	Teacher	2014-07-15 09:35:35.268429	2014-07-15 09:35:35.268429	2012-2013	6	1A	FA3	Ramesh Sharma - 1	Maths
810	47	\N	f	Set the remarks here	3	6	6	1	6	2	Teacher	2014-07-15 09:35:35.294574	2014-07-15 09:35:35.294574	2013-2014	6	1A	FA3	Ramesh Sharma - 1	Chemistry
811	47	\N	f	Set the remarks here	3	6	6	1	6	2	Teacher	2014-07-15 09:35:35.324268	2014-07-15 09:35:35.324268	2012-2013	6	1A	FA3	Ramesh Sharma - 1	Chemistry
812	48	\N	f	Set the remarks here	1	6	4	1	6	2	Teacher	2014-07-15 09:35:35.354085	2014-07-15 09:35:35.354085	2013-2014	6	1A	FA1	Ramesh Sharma - 1	Maths
813	48	\N	f	Set the remarks here	1	6	4	1	6	2	Teacher	2014-07-15 09:35:35.38467	2014-07-15 09:35:35.38467	2012-2013	6	1A	FA1	Ramesh Sharma - 1	Maths
814	43	\N	t	Set the remarks here	2	6	6	1	6	2	Teacher	2014-07-15 09:35:35.414959	2014-07-15 09:35:35.414959	2013-2014	6	1A	FA3	Ramesh Sharma - 1	Physics
815	43	\N	t	Set the remarks here	2	6	6	1	6	2	Teacher	2014-07-15 09:35:35.444214	2014-07-15 09:35:35.444214	2012-2013	6	1A	FA3	Ramesh Sharma - 1	Physics
\.


--
-- Data for Name: test_results_from_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY test_results_from_files (id, name, school_branch_id, test_result_ids, status, status_msg, creator_id, creator_type, created_at, updated_at, parsing_errors) FROM stdin;
14	test_result_sample_new.csv	1	{}	2	Successfully fed test result into the system	2	Teacher	2014-07-07 11:51:38.809749	2014-07-07 11:51:42.243267	--- []\n
16	test_result_sample_3.csv	1	{}	2	Successfully fed test result into the system	2	Teacher	2014-07-07 12:09:55.340856	2014-07-07 12:09:58.353349	--- []\n
6	test_result_sample.csv	1	{}	2	Successfully fed test result into the system	2	Teacher	2014-07-04 10:01:09.520639	2014-07-04 10:02:27.617458	--- []\n
\.


--
-- Name: test_results_from_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('test_results_from_files_id_seq', 16, true);


--
-- Name: test_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('test_results_id_seq', 815, true);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: class_room_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY class_room_students
    ADD CONSTRAINT class_room_students_pkey PRIMARY KEY (id);


--
-- Name: class_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY class_rooms
    ADD CONSTRAINT class_rooms_pkey PRIMARY KEY (id);


--
-- Name: class_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY class_tests
    ADD CONSTRAINT class_tests_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: managers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (id);


--
-- Name: mock_test_takens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mock_test_takens
    ADD CONSTRAINT mock_test_takens_pkey PRIMARY KEY (id);


--
-- Name: mock_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mock_tests
    ADD CONSTRAINT mock_tests_pkey PRIMARY KEY (id);


--
-- Name: my_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY my_details
    ADD CONSTRAINT my_details_pkey PRIMARY KEY (id);


--
-- Name: ques_and_ans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ques_and_ans
    ADD CONSTRAINT ques_and_ans_pkey PRIMARY KEY (id);


--
-- Name: schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: school_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY school_branches
    ADD CONSTRAINT school_branches_pkey PRIMARY KEY (id);


--
-- Name: school_controllers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY school_controllers
    ADD CONSTRAINT school_controllers_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: searches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY searches
    ADD CONSTRAINT searches_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: test_results_from_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY test_results_from_files
    ADD CONSTRAINT test_results_from_files_pkey PRIMARY KEY (id);


--
-- Name: test_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY test_results
    ADD CONSTRAINT test_results_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_admins_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_confirmation_token ON admins USING btree (confirmation_token);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: index_admins_on_unlock_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_unlock_token ON admins USING btree (unlock_token);


--
-- Name: index_class_room_students_on_class_room_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_room_students_on_class_room_id ON class_room_students USING btree (class_room_id);


--
-- Name: index_class_room_students_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_room_students_on_creator_id_and_creator_type ON class_room_students USING btree (creator_id, creator_type);


--
-- Name: index_class_room_students_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_room_students_on_school_branch_id ON class_room_students USING btree (school_branch_id);


--
-- Name: index_class_room_students_on_student_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_room_students_on_student_id ON class_room_students USING btree (student_id);


--
-- Name: index_class_rooms_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_rooms_on_creator_id_and_creator_type ON class_rooms USING btree (creator_id, creator_type);


--
-- Name: index_class_rooms_on_document_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_rooms_on_document_id ON class_rooms USING btree (document_id);


--
-- Name: index_class_rooms_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_rooms_on_school_branch_id ON class_rooms USING btree (school_branch_id);


--
-- Name: index_class_rooms_on_school_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_rooms_on_school_id ON class_rooms USING btree (school_id);


--
-- Name: index_class_tests_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_tests_on_creator_id_and_creator_type ON class_tests USING btree (creator_id, creator_type);


--
-- Name: index_class_tests_on_document_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_tests_on_document_id ON class_tests USING btree (document_id);


--
-- Name: index_class_tests_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_tests_on_school_branch_id ON class_tests USING btree (school_branch_id);


--
-- Name: index_class_tests_on_school_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_class_tests_on_school_id ON class_tests USING btree (school_id);


--
-- Name: index_comments_on_comentator_id_and_comentator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_comments_on_comentator_id_and_comentator_type ON comments USING btree (comentator_id, comentator_type);


--
-- Name: index_comments_on_comment_for_id_and_comment_for_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_comments_on_comment_for_id_and_comment_for_type ON comments USING btree (comment_for_id, comment_for_type);


--
-- Name: index_documents_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_documents_on_creator_id_and_creator_type ON documents USING btree (creator_id, creator_type);


--
-- Name: index_documents_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_documents_on_school_branch_id ON documents USING btree (school_branch_id);


--
-- Name: index_managers_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_managers_on_confirmation_token ON managers USING btree (confirmation_token);


--
-- Name: index_managers_on_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_managers_on_creator_id ON managers USING btree (creator_id);


--
-- Name: index_managers_on_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_managers_on_creator_type ON managers USING btree (creator_type);


--
-- Name: index_managers_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_managers_on_email ON managers USING btree (email);


--
-- Name: index_managers_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_managers_on_reset_password_token ON managers USING btree (reset_password_token);


--
-- Name: index_managers_on_unlock_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_managers_on_unlock_token ON managers USING btree (unlock_token);


--
-- Name: index_mock_test_takens_on_mock_test_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_test_takens_on_mock_test_id ON mock_test_takens USING btree (mock_test_id);


--
-- Name: index_mock_test_takens_on_ques_and_ans_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_test_takens_on_ques_and_ans_id ON mock_test_takens USING btree (ques_and_ans_id);


--
-- Name: index_mock_test_takens_on_student_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_test_takens_on_student_id ON mock_test_takens USING btree (student_id);


--
-- Name: index_mock_tests_on_class_room_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_tests_on_class_room_id ON mock_tests USING btree (class_room_id);


--
-- Name: index_mock_tests_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_tests_on_creator_id_and_creator_type ON mock_tests USING btree (creator_id, creator_type);


--
-- Name: index_mock_tests_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_tests_on_school_branch_id ON mock_tests USING btree (school_branch_id);


--
-- Name: index_mock_tests_on_subject_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_mock_tests_on_subject_id ON mock_tests USING btree (subject_id);


--
-- Name: index_my_details_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_my_details_on_school_branch_id ON my_details USING btree (school_branch_id);


--
-- Name: index_my_details_on_whoami_id_and_whoami_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_my_details_on_whoami_id_and_whoami_type ON my_details USING btree (whoami_id, whoami_type);


--
-- Name: index_ques_and_ans_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_ques_and_ans_on_creator_id_and_creator_type ON ques_and_ans USING btree (creator_id, creator_type);


--
-- Name: index_ques_and_ans_on_mock_test_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_ques_and_ans_on_mock_test_id ON ques_and_ans USING btree (mock_test_id);


--
-- Name: index_schedules_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schedules_on_creator_id_and_creator_type ON schedules USING btree (creator_id, creator_type);


--
-- Name: index_schedules_on_end_time; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schedules_on_end_time ON schedules USING btree (end_time);


--
-- Name: index_schedules_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schedules_on_school_branch_id ON schedules USING btree (school_branch_id);


--
-- Name: index_schedules_on_start_time; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schedules_on_start_time ON schedules USING btree (start_time);


--
-- Name: index_school_branches_on_school_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_school_branches_on_school_id ON school_branches USING btree (school_id);


--
-- Name: index_school_controllers_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_school_controllers_on_confirmation_token ON school_controllers USING btree (confirmation_token);


--
-- Name: index_school_controllers_on_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_school_controllers_on_creator_id ON school_controllers USING btree (creator_id);


--
-- Name: index_school_controllers_on_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_school_controllers_on_creator_type ON school_controllers USING btree (creator_type);


--
-- Name: index_school_controllers_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_school_controllers_on_email ON school_controllers USING btree (email);


--
-- Name: index_school_controllers_on_manager_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_school_controllers_on_manager_id ON school_controllers USING btree (manager_id);


--
-- Name: index_school_controllers_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_school_controllers_on_reset_password_token ON school_controllers USING btree (reset_password_token);


--
-- Name: index_school_controllers_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_school_controllers_on_school_branch_id ON school_controllers USING btree (school_branch_id);


--
-- Name: index_school_controllers_on_unlock_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_school_controllers_on_unlock_token ON school_controllers USING btree (unlock_token);


--
-- Name: index_schools_on_manager_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schools_on_manager_id ON schools USING btree (manager_id);


--
-- Name: index_schools_on_school_controller_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_schools_on_school_controller_id ON schools USING btree (school_controller_id);


--
-- Name: index_searches_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_searches_on_school_branch_id ON searches USING btree (school_branch_id);


--
-- Name: index_searches_on_searcher_id_and_searcher_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_searches_on_searcher_id_and_searcher_type ON searches USING btree (searcher_id, searcher_type);


--
-- Name: index_students_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_students_on_creator_id_and_creator_type ON students USING btree (creator_id, creator_type);


--
-- Name: index_students_on_document_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_students_on_document_id ON students USING btree (document_id);


--
-- Name: index_students_on_year; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_students_on_year ON students USING btree (year);


--
-- Name: index_subjects_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_subjects_on_creator_id_and_creator_type ON subjects USING btree (creator_id, creator_type);


--
-- Name: index_subjects_on_document_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_subjects_on_document_id ON subjects USING btree (document_id);


--
-- Name: index_subjects_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_subjects_on_school_branch_id ON subjects USING btree (school_branch_id);


--
-- Name: index_teachers_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_teachers_on_confirmation_token ON teachers USING btree (confirmation_token);


--
-- Name: index_teachers_on_creator_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_teachers_on_creator_id ON teachers USING btree (creator_id);


--
-- Name: index_teachers_on_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_teachers_on_creator_type ON teachers USING btree (creator_type);


--
-- Name: index_teachers_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_teachers_on_email ON teachers USING btree (email);


--
-- Name: index_teachers_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_teachers_on_reset_password_token ON teachers USING btree (reset_password_token);


--
-- Name: index_teachers_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_teachers_on_school_branch_id ON teachers USING btree (school_branch_id);


--
-- Name: index_teachers_on_school_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_teachers_on_school_id ON teachers USING btree (school_id);


--
-- Name: index_teachers_on_unlock_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_teachers_on_unlock_token ON teachers USING btree (unlock_token);


--
-- Name: index_test_results_from_files_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_from_files_on_creator_id_and_creator_type ON test_results_from_files USING btree (creator_id, creator_type);


--
-- Name: index_test_results_from_files_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_from_files_on_school_branch_id ON test_results_from_files USING btree (school_branch_id);


--
-- Name: index_test_results_on_class_room_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_class_room_id ON test_results USING btree (class_room_id);


--
-- Name: index_test_results_on_class_test_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_class_test_id ON test_results USING btree (class_test_id);


--
-- Name: index_test_results_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_creator_id_and_creator_type ON test_results USING btree (creator_id, creator_type);


--
-- Name: index_test_results_on_school_branch_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_school_branch_id ON test_results USING btree (school_branch_id);


--
-- Name: index_test_results_on_student_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_student_id ON test_results USING btree (student_id);


--
-- Name: index_test_results_on_subject_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_subject_id ON test_results USING btree (subject_id);


--
-- Name: index_test_results_on_test_results_from_file_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_test_results_from_file_id ON test_results USING btree (test_results_from_file_id);


--
-- Name: index_test_results_on_year; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_test_results_on_year ON test_results USING btree (year);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

