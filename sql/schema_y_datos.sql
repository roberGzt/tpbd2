drop table if exists pelis_que_vio;
drop table if exists persona;
drop table if exists pelicula;

create table persona
(
	usuario varchar(30) primary key,
	clave varchar,	
	nombre varchar(30),
	apellido varchar(30)
);

create table pelicula
(
	pelicula_id serial primary key,
	pelicula_nombre varchar(30)
);
create table pelis_que_vio
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

insert into persona values ('misael',MD5('misael'),'Misael','Britos');
insert into persona values ('rober',MD5('rober'),'Rober','Gerszenswit');
insert into persona values ('maxi',MD5('maxi'),'Maximiliano','Lucero Correa');
insert into persona values ('maria',MD5('maria'),'Maria','Jimenez');
insert into persona values ('pedro',MD5('pedro'),'Pedro','Fernandez');
insert into persona values ('lucia',MD5('lucia'),'Lucía','Perez');
insert into persona values ('juan',MD5('juan'),'Juan','Quito');
insert into persona values ('franco',MD5('franco'),'Franco','Pepin');

insert into pelicula values (1,'Avengers');
insert into pelicula values (2,'Rocky');
insert into pelicula values (3,'Buscando a Nemo');
insert into pelicula values (4,'Esperando la Carroza');
insert into pelicula values (5,'Star Trek');


insert into pelis_que_vio values (1,'misael');
insert into pelis_que_vio values (1,'rober');
insert into pelis_que_vio values (1,'maxi');
insert into pelis_que_vio values (2,'misael');
insert into pelis_que_vio values (2,'rober');
insert into pelis_que_vio values (2,'maxi');
insert into pelis_que_vio values (3,'misael');
insert into pelis_que_vio values (3,'rober');
insert into pelis_que_vio values (3,'maxi');

insert into pelis_que_vio values (3,'maria');
insert into pelis_que_vio values (3,'pedro');
insert into pelis_que_vio values (4,'maria');
insert into pelis_que_vio values (4,'pedro');

insert into pelis_que_vio values (1,'franco');
insert into pelis_que_vio values (2,'franco');
insert into pelis_que_vio values (3,'franco');
insert into pelis_que_vio values (4,'franco');
insert into pelis_que_vio values (5,'franco');


--Crear USUARIOS
DROP USER IF EXISTS tp2bd2;
CREATE USER tp2bd2 WITH PASSWORD 'tp2bd2';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tp2bd2;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tp2bd2;

DROP USER IF EXISTS demo;
CREATE USER demo WITH PASSWORD 'demo';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO demo;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO demo;