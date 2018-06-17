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


SET search_path = public, pg_catalog;

--
-- Name: agregarpersona(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION agregarpersona(_usuario character varying, _clave character varying, _apellido character varying, _nombre character varying) RETURNS void
    LANGUAGE sql
    AS $$

INSERT INTO Persona (usuario,clave,nombre,apellido) VALUES (_usuario, MD5(_clave), _nombre, _apellido);
$$;


ALTER FUNCTION public.agregarpersona(_usuario character varying, _clave character varying, _apellido character varying, _nombre character varying) OWNER TO postgres;

--
-- Name: cambiarcontrasena(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cambiarcontrasena(_usuario character varying, _clave character varying) RETURNS void
    LANGUAGE sql
    AS $$

UPDATE persona SET clave = MD5(_clave) WHERE usuario = _usuario;

$$;


ALTER FUNCTION public.cambiarcontrasena(_usuario character varying, _clave character varying) OWNER TO postgres;

--
-- Name: loginpersona(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION loginpersona(_usuario character varying) RETURNS TABLE(usuario character varying, clave character varying, nombre character varying, apellido character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
   	SELECT p.usuario, p.clave, p.nombre, p.apellido FROM persona p WHERE p.usuario = _usuario;
END;
$$;


ALTER FUNCTION public.loginpersona(_usuario character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: pelicula; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pelicula (
    pelicula_id integer NOT NULL,
    pelicula_nombre character varying(30)
);


ALTER TABLE public.pelicula OWNER TO postgres;

--
-- Name: pelicula_pelicula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pelicula_pelicula_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pelicula_pelicula_id_seq OWNER TO postgres;

--
-- Name: pelicula_pelicula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pelicula_pelicula_id_seq OWNED BY pelicula.pelicula_id;


--
-- Name: pelis_que_vio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pelis_que_vio (
    pelicula_id integer NOT NULL,
    usuario character varying(20) NOT NULL
);


ALTER TABLE public.pelis_que_vio OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persona (
    usuario character varying(30) NOT NULL,
    clave character varying,
    apellido character varying(30),
    nombre character varying(30)
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: pelicula_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pelicula ALTER COLUMN pelicula_id SET DEFAULT nextval('pelicula_pelicula_id_seq'::regclass);


--
-- Data for Name: pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pelicula (pelicula_id, pelicula_nombre) FROM stdin;
1	Titanic
2	Rocky
3	Furia
4	Peli
5	WHAT
\.


--
-- Name: pelicula_pelicula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pelicula_pelicula_id_seq', 1, false);


--
-- Data for Name: pelis_que_vio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pelis_que_vio (pelicula_id, usuario) FROM stdin;
1	juan
1	maria
2	juan
2	maria
3	lucas
3	pocho
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY persona (usuario, clave, apellido, nombre) FROM stdin;
juan	a94652aa97c7211ba8954dd15a3cf838	Juan	Perez
maria	263bce650e68ab4e23f28263760b9fa5	Maria	Ibanies
lucas	dc53fc4f621c80bdc2fa0329a6123708	Lucas	Miranda
pocho	aadbedfb57be855d768d409863552766	Pocho	Querido
julio	dc53fc4f621c80bdc2fa0329a6123708	asdasd	Miranda
pedro	aadbedfb57be855d768d409863552766	asdasdads	Querido
\.


--
-- Name: pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (pelicula_id);


--
-- Name: pelis_que_vio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pelis_que_vio
    ADD CONSTRAINT pelis_que_vio_pkey PRIMARY KEY (pelicula_id, usuario);


--
-- Name: persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (usuario);


--
-- Name: uq_pelicula_nombrerepetido; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pelicula
    ADD CONSTRAINT uq_pelicula_nombrerepetido UNIQUE (pelicula_nombre);


--
-- Name: uq_persona_nombreduplicado; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT uq_persona_nombreduplicado UNIQUE (apellido, nombre);


--
-- Name: pelis_que_vio_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pelis_que_vio
    ADD CONSTRAINT pelis_que_vio_pelicula_id_fkey FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id);


--
-- Name: pelis_que_vio_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pelis_que_vio
    ADD CONSTRAINT pelis_que_vio_usuario_fkey FOREIGN KEY (usuario) REFERENCES persona(usuario);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: pelicula; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pelicula FROM PUBLIC;
REVOKE ALL ON TABLE pelicula FROM postgres;
GRANT ALL ON TABLE pelicula TO postgres;
GRANT ALL ON TABLE pelicula TO tp2bdii;
GRANT ALL ON TABLE pelicula TO demo;


--
-- Name: pelicula_pelicula_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE pelicula_pelicula_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE pelicula_pelicula_id_seq FROM postgres;
GRANT ALL ON SEQUENCE pelicula_pelicula_id_seq TO postgres;
GRANT ALL ON SEQUENCE pelicula_pelicula_id_seq TO tp2bdii;
GRANT ALL ON SEQUENCE pelicula_pelicula_id_seq TO demo;


--
-- Name: pelis_que_vio; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pelis_que_vio FROM PUBLIC;
REVOKE ALL ON TABLE pelis_que_vio FROM postgres;
GRANT ALL ON TABLE pelis_que_vio TO postgres;
GRANT ALL ON TABLE pelis_que_vio TO tp2bdii;
GRANT ALL ON TABLE pelis_que_vio TO demo;


--
-- Name: persona; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persona FROM PUBLIC;
REVOKE ALL ON TABLE persona FROM postgres;
GRANT ALL ON TABLE persona TO postgres;
GRANT ALL ON TABLE persona TO tp2bdii;
GRANT ALL ON TABLE persona TO demo;


--
-- PostgreSQL database dump complete
--

