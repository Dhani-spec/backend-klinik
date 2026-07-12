--
-- PostgreSQL database dump
--

\restrict WyYGm5tYYRBuagnRNLDF0FfybSPlXgoylarqzWg4eSWB7kwEpx1UkEGn4aZ00dq

-- Dumped from database version 18.4 (709c4c3)
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-12 11:27:19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16526)
-- Name: neon_auth; Type: SCHEMA; Schema: -; Owner: neon_auth
--

CREATE SCHEMA neon_auth;


ALTER SCHEMA neon_auth OWNER TO neon_auth;

--
-- TOC entry 6 (class 2615 OID 49155)
-- Name: public; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO neondb_owner;

--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: neondb_owner
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16567)
-- Name: account; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" uuid NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamp with time zone,
    "refreshTokenExpiresAt" timestamp with time zone,
    scope text,
    password text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE neon_auth.account OWNER TO neon_auth;

--
-- TOC entry 227 (class 1259 OID 16652)
-- Name: invitation; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.invitation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    email text NOT NULL,
    role text,
    status text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "inviterId" uuid NOT NULL
);


ALTER TABLE neon_auth.invitation OWNER TO neon_auth;

--
-- TOC entry 224 (class 1259 OID 16603)
-- Name: jwks; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.jwks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "publicKey" text NOT NULL,
    "privateKey" text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "expiresAt" timestamp with time zone
);


ALTER TABLE neon_auth.jwks OWNER TO neon_auth;

--
-- TOC entry 226 (class 1259 OID 16629)
-- Name: member; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.member (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL
);


ALTER TABLE neon_auth.member OWNER TO neon_auth;

--
-- TOC entry 225 (class 1259 OID 16615)
-- Name: organization; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.organization (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    logo text,
    "createdAt" timestamp with time zone NOT NULL,
    metadata text
);


ALTER TABLE neon_auth.organization OWNER TO neon_auth;

--
-- TOC entry 228 (class 1259 OID 16678)
-- Name: project_config; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.project_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    endpoint_id text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    trusted_origins jsonb NOT NULL,
    social_providers jsonb NOT NULL,
    email_provider jsonb,
    email_and_password jsonb,
    allow_localhost boolean NOT NULL,
    plugin_configs jsonb,
    webhook_config jsonb
);


ALTER TABLE neon_auth.project_config OWNER TO neon_auth;

--
-- TOC entry 221 (class 1259 OID 16545)
-- Name: session; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.session (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "userId" uuid NOT NULL,
    "impersonatedBy" text,
    "activeOrganizationId" text
);


ALTER TABLE neon_auth.session OWNER TO neon_auth;

--
-- TOC entry 220 (class 1259 OID 16527)
-- Name: user; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "emailVerified" boolean NOT NULL,
    image text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role text,
    banned boolean,
    "banReason" text,
    "banExpires" timestamp with time zone
);


ALTER TABLE neon_auth."user" OWNER TO neon_auth;

--
-- TOC entry 223 (class 1259 OID 16587)
-- Name: verification; Type: TABLE; Schema: neon_auth; Owner: neon_auth
--

CREATE TABLE neon_auth.verification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE neon_auth.verification OWNER TO neon_auth;

--
-- TOC entry 229 (class 1259 OID 49156)
-- Name: antrian; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.antrian (
    id integer NOT NULL,
    nama character varying(100) NOT NULL,
    keluhan text,
    usia integer,
    jk character varying(20),
    diagnosa text,
    resep_obat text,
    dokter character varying(100),
    status character varying(50),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.antrian OWNER TO neondb_owner;

--
-- TOC entry 230 (class 1259 OID 49164)
-- Name: antrian_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.antrian_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 230
-- Name: antrian_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.antrian_id_seq OWNED BY public.antrian.id;


--
-- TOC entry 231 (class 1259 OID 49165)
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    nama character varying(100) NOT NULL,
    role character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- TOC entry 232 (class 1259 OID 49175)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 233 (class 1259 OID 49176)
-- Name: vital_sign; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.vital_sign (
    id integer NOT NULL,
    pasien_id character varying(50) NOT NULL,
    tensi character varying(20),
    suhu character varying(20),
    nadi character varying(20),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.vital_sign OWNER TO neondb_owner;

--
-- TOC entry 234 (class 1259 OID 49182)
-- Name: vital_sign_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.vital_sign_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vital_sign_id_seq OWNER TO neondb_owner;

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 234
-- Name: vital_sign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.vital_sign_id_seq OWNED BY public.vital_sign.id;


--
-- TOC entry 3334 (class 2604 OID 49183)
-- Name: antrian id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.antrian ALTER COLUMN id SET DEFAULT nextval('public.antrian_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 49184)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3337 (class 2604 OID 49185)
-- Name: vital_sign id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.vital_sign ALTER COLUMN id SET DEFAULT nextval('public.vital_sign_id_seq'::regclass);


--
-- TOC entry 3539 (class 0 OID 16567)
-- Dependencies: 222
-- Data for Name: account; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.account (id, "accountId", "providerId", "userId", "accessToken", "refreshToken", "idToken", "accessTokenExpiresAt", "refreshTokenExpiresAt", scope, password, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3544 (class 0 OID 16652)
-- Dependencies: 227
-- Data for Name: invitation; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.invitation (id, "organizationId", email, role, status, "expiresAt", "createdAt", "inviterId") FROM stdin;
\.


--
-- TOC entry 3541 (class 0 OID 16603)
-- Dependencies: 224
-- Data for Name: jwks; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.jwks (id, "publicKey", "privateKey", "createdAt", "expiresAt") FROM stdin;
\.


--
-- TOC entry 3543 (class 0 OID 16629)
-- Dependencies: 226
-- Data for Name: member; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.member (id, "organizationId", "userId", role, "createdAt") FROM stdin;
\.


--
-- TOC entry 3542 (class 0 OID 16615)
-- Dependencies: 225
-- Data for Name: organization; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.organization (id, name, slug, logo, "createdAt", metadata) FROM stdin;
\.


--
-- TOC entry 3545 (class 0 OID 16678)
-- Dependencies: 228
-- Data for Name: project_config; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.project_config (id, name, endpoint_id, created_at, updated_at, trusted_origins, social_providers, email_provider, email_and_password, allow_localhost, plugin_configs, webhook_config) FROM stdin;
24fbf2a4-8c50-4da4-bb40-a7ff3e6c8789	klinik	ep-shiny-violet-aoskovsd	2026-07-09 08:36:50.65+00	2026-07-09 08:36:50.65+00	[]	[{"id": "google", "isShared": true}]	{"type": "shared"}	{"enabled": true, "disableSignUp": false, "emailVerificationMethod": "otp", "requireEmailVerification": false, "autoSignInAfterVerification": true, "sendVerificationEmailOnSignIn": false, "sendVerificationEmailOnSignUp": false}	t	{"magicLink": {"config": {"expiresIn": 5, "disableSignUp": false}, "enabled": false}, "phoneNumber": {"config": {"otp_expires_in": 300}, "enabled": false}, "organization": {"config": {"creatorRole": "owner", "membershipLimit": 100, "organizationLimit": 10, "sendInvitationEmail": false}, "enabled": true}}	{"enabled": false, "enabledEvents": [], "timeoutSeconds": 5}
\.


--
-- TOC entry 3538 (class 0 OID 16545)
-- Dependencies: 221
-- Data for Name: session; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.session (id, "expiresAt", token, "createdAt", "updatedAt", "ipAddress", "userAgent", "userId", "impersonatedBy", "activeOrganizationId") FROM stdin;
\.


--
-- TOC entry 3537 (class 0 OID 16527)
-- Dependencies: 220
-- Data for Name: user; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth."user" (id, name, email, "emailVerified", image, "createdAt", "updatedAt", role, banned, "banReason", "banExpires") FROM stdin;
\.


--
-- TOC entry 3540 (class 0 OID 16587)
-- Dependencies: 223
-- Data for Name: verification; Type: TABLE DATA; Schema: neon_auth; Owner: neon_auth
--

COPY neon_auth.verification (id, identifier, value, "expiresAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3546 (class 0 OID 49156)
-- Dependencies: 229
-- Data for Name: antrian; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.antrian (id, nama, keluhan, usia, jk, diagnosa, resep_obat, dokter, status, created_at) FROM stdin;
2	Gina	Pusing dan sakit Kepala	19	Perempuan	\N	\N	\N	Menunggu	2026-07-08 19:35:57.487463+00
4	Kidung	Demam	19	Laki-laki	\N	\N	\N	Menunggu	2026-07-08 20:23:04.236522+00
1	Dhani	Sakit Kepala	20	Laki-laki	hipertensi	Amlodipin	Dhani	Selesai	2026-07-08 19:27:37.85013+00
5	Halda	Demam	22	Perempuan	DBD	Rujug Rs Melati Indah, paracetamol 3x1	Dhani	Selesai	2026-07-08 20:38:42.192511+00
6	Farah	Demam	15	Perempuan	DBD	Rujug Rs Melati Indah	Dhani	Selesai	2026-07-08 21:14:16.907782+00
3	Bagas	Sakit Kepala	21	Laki-laki	Amnessia	amlodipin 3x1	Dhani	Selesai	2026-07-08 20:10:48.803433+00
7	Panjul	Mual-mual	15	laki-laki	\N	\N	\N	Menunggu	2026-07-09 10:36:01.306506+00
8	Herman	Diare	32	Laki-laki	\N	\N	\N	Menunggu	2026-07-09 22:51:08.422532+00
10	Lula	Batuk	24	Perempuan	Flu	Vitamin C	string	Ke Apotek	2026-07-11 01:24:00.328403+00
9	Talitha	Sakit Kepala	20	Perempuan	Hipertensi	Amlodipin 2x1	Dr. Dhani Hafiddudin	Ke Apotek	2026-07-11 00:47:00.398876+00
\.


--
-- TOC entry 3548 (class 0 OID 49165)
-- Dependencies: 231
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, nama, role) FROM stdin;
1	sarah12@gmail.com	123	Sarah Amelia	suster
2	Andipratama@gmail.com	123	Dr. Andi Pratama	dokter
3	Rian12@gmail.com	123	Rian Apoteker	apoteker
23	Dhani07@gmail.com	123	Dr. Dhani Hafiddudin	dokter
\.


--
-- TOC entry 3550 (class 0 OID 49176)
-- Dependencies: 233
-- Data for Name: vital_sign; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.vital_sign (id, pasien_id, tensi, suhu, nadi, created_at) FROM stdin;
1	null	110/90	35	80	2026-07-08 19:28:11.178512+00
2	5	110/90	35.0	90	2026-07-08 20:39:34.510679+00
3	6	110/90	35.0	80	2026-07-08 21:14:37.275478+00
4	8	110/90	35	96	2026-07-09 22:51:31.204729+00
5	9	120/100	36	90	2026-07-11 00:47:24.15686+00
6	9	120/100	36	90	2026-07-11 00:51:54.191384+00
\.


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 230
-- Name: antrian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.antrian_id_seq', 10, true);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 23, true);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 234
-- Name: vital_sign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.vital_sign_id_seq', 6, true);


--
-- TOC entry 3349 (class 2606 OID 16581)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 16667)
-- Name: invitation invitation_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (id);


--
-- TOC entry 3355 (class 2606 OID 16614)
-- Name: jwks jwks_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 16641)
-- Name: member member_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- TOC entry 3357 (class 2606 OID 16626)
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- TOC entry 3359 (class 2606 OID 16628)
-- Name: organization organization_slug_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_slug_key UNIQUE (slug);


--
-- TOC entry 3370 (class 2606 OID 16697)
-- Name: project_config project_config_endpoint_id_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_endpoint_id_key UNIQUE (endpoint_id);


--
-- TOC entry 3372 (class 2606 OID 16695)
-- Name: project_config project_config_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 16559)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16561)
-- Name: session session_token_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_token_key UNIQUE (token);


--
-- TOC entry 3340 (class 2606 OID 16544)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3342 (class 2606 OID 16542)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3353 (class 2606 OID 16602)
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 49187)
-- Name: antrian antrian_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.antrian
    ADD CONSTRAINT antrian_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 49189)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3380 (class 2606 OID 49191)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3383 (class 2606 OID 49193)
-- Name: vital_sign vital_sign_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.vital_sign
    ADD CONSTRAINT vital_sign_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 1259 OID 16699)
-- Name: account_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX "account_userId_idx" ON neon_auth.account USING btree ("userId");


--
-- TOC entry 3365 (class 1259 OID 16705)
-- Name: invitation_email_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX invitation_email_idx ON neon_auth.invitation USING btree (email);


--
-- TOC entry 3366 (class 1259 OID 16704)
-- Name: invitation_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX "invitation_organizationId_idx" ON neon_auth.invitation USING btree ("organizationId");


--
-- TOC entry 3361 (class 1259 OID 16702)
-- Name: member_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX "member_organizationId_idx" ON neon_auth.member USING btree ("organizationId");


--
-- TOC entry 3364 (class 1259 OID 16703)
-- Name: member_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX "member_userId_idx" ON neon_auth.member USING btree ("userId");


--
-- TOC entry 3360 (class 1259 OID 16701)
-- Name: organization_slug_uidx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE UNIQUE INDEX organization_slug_uidx ON neon_auth.organization USING btree (slug);


--
-- TOC entry 3347 (class 1259 OID 16698)
-- Name: session_userId_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX "session_userId_idx" ON neon_auth.session USING btree ("userId");


--
-- TOC entry 3351 (class 1259 OID 16700)
-- Name: verification_identifier_idx; Type: INDEX; Schema: neon_auth; Owner: neon_auth
--

CREATE INDEX verification_identifier_idx ON neon_auth.verification USING btree (identifier);


--
-- TOC entry 3375 (class 1259 OID 49194)
-- Name: ix_antrian_id; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX ix_antrian_id ON public.antrian USING btree (id);


--
-- TOC entry 3376 (class 1259 OID 49195)
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- TOC entry 3381 (class 1259 OID 49196)
-- Name: ix_vital_sign_id; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX ix_vital_sign_id ON public.vital_sign USING btree (id);


--
-- TOC entry 3385 (class 2606 OID 16582)
-- Name: account account_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3388 (class 2606 OID 16673)
-- Name: invitation invitation_inviterId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3389 (class 2606 OID 16668)
-- Name: invitation invitation_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- TOC entry 3386 (class 2606 OID 16642)
-- Name: member member_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- TOC entry 3387 (class 2606 OID 16647)
-- Name: member member_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3384 (class 2606 OID 16562)
-- Name: session session_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: neon_auth
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: neondb_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-07-12 11:27:22

--
-- PostgreSQL database dump complete
--

\unrestrict WyYGm5tYYRBuagnRNLDF0FfybSPlXgoylarqzWg4eSWB7kwEpx1UkEGn4aZ00dq

