drop table if exists pelis_que_vio;
drop table if exists persona;
drop table if exists pelicula;

create table persona
(
	usuario varchar(30) primary key,
	clave varchar,
	apellido varchar(30),
	nombre varchar(30)
);

create table pelicula
(
	pelicula_id serial primary key,
	pelicula_nombre varchar(30)
);
create table PELIS_QUE_VIO
(
	pelicula_id int references pelicula(pelicula_id),
	usuario varchar(20) references persona(usuario),
	primary key(pelicula_id,usuario)	
);

alter  table if exists persona
add constraint UQ_persona_nombreDuplicado
unique (apellido,nombre);

alter table if exists pelicula
add constraint UQ_pelicula_NombreRepetido
unique (pelicula_nombre);

insert into persona values ('juan',MD5('juan'),'Juan','Perez');
insert into persona values ('maria',MD5('maria'),'Maria','Ibanies');
insert into persona values ('lucas',MD5('lucas'),'Lucas','Miranda');
insert into persona values ('pocho',MD5('lapantera'),'Pocho','Querido');
insert into persona values ('julio',MD5('lucas'),'asdasd','Miranda');
insert into persona values ('pedro',MD5('lapantera'),'asdasdads','Querido');

insert into pelicula values (1,'Titanic');
insert into pelicula values (2,'Rocky');
insert into pelicula values (3,'Furia');
insert into pelicula values (4,'Peli');
insert into pelicula values (5,'WHAT');


insert into pelis_que_vio values (1,'juan');
insert into pelis_que_vio values (1,'maria');
insert into pelis_que_vio values (2,'juan');
insert into pelis_que_vio values (2,'maria');
insert into pelis_que_vio values (3,'lucas');
insert into pelis_que_vio values (3,'pocho');


--Crear USUARIOS
DROP USER IF EXISTS tp2bd2;
CREATE USER tp2bd2 WITH PASSWORD 'tp2bd2';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tp2bd2;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tp2bd2;

DROP USER IF EXISTS demo;
CREATE USER demo WITH PASSWORD 'demo';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO demo;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO demo;

-- PROCEDURES

DROP FUNCTION IF EXISTS agregarPersona (
	_usuario VARCHAR(30), 
	_clave VARCHAR, 
	_apellido VARCHAR(30),
	_nombre VARCHAR(30)) CASCADE;

CREATE FUNCTION agregarPersona(
	_usuario VARCHAR(30), 
	_clave VARCHAR, 
	_apellido VARCHAR(30),
	_nombre VARCHAR(30))

RETURNS void AS $$

INSERT INTO Persona (usuario,clave,nombre,apellido) VALUES (_usuario, MD5(_clave), _nombre, _apellido);
$$
LANGUAGE SQL;

DROP FUNCTION IF EXISTS loginPersona
(
	_usuario varchar(30)
);

CREATE FUNCTION loginPersona
(
	_usuario varchar(30)
)

RETURNS TABLE ("usuario" varchar, "clave" varchar, "nombre" varchar, "apellido" varchar) AS
$$
BEGIN
	RETURN QUERY
   	SELECT p.usuario, p.clave, p.nombre, p.apellido FROM persona p WHERE p.usuario = _usuario;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS cambiarContrasena(
	_usuario VARCHAR(30), 
	_clave VARCHAR
);

CREATE FUNCTION cambiarContrasena(
	_usuario VARCHAR(30), 
	_clave VARCHAR
)
RETURNS void AS $$

UPDATE persona SET clave = MD5(_clave) WHERE usuario = _usuario;

$$
LANGUAGE SQL;
