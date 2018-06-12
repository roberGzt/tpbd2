select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2
from pelis_que_vio pqv1, pelis_que_vio pqv2 
where pqv1.usuario < pqv2.usuario and not exists



--pqv1.juan, pqv2.maria
(select * 
from pelis_que_vio pqv3 
where pqv1.usuario = pqv3.usuario  -- pqv3.usuario = juan, osea las pelis que vio juan
and not exists 
    (select * 
    from pelis_que_vio pqv4
    where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id))-- pqv4.usuario = maria, todas las pelis que vieron juan y maria 
    and not exists 
        (select *  -- todas las peliculas que vio el usuario 2 pero no vio el usuario 1
        from pelis_que_vio pqv3 
        where pqv2.usuario = pqv3.usuario
        and not exists  // que no vieron la misma pelicula
            (select *
            from pelis_que_vio pqv4
            where pqv1.usuario = pqv4.usuario and pqv3.pelicula_id = pqv4.pelicula_id)); -- pqv1.usuario = juan, todas las pelis que vieron juan y maria 

CREATE OR REPLACE FUNCTION superQuery()
RETURNS SETOF col_tabla AS
$BODY$
declare
tabla col_tabla%rowtype;
begin
for tabla in select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2
from pelis_que_vio pqv1, pelis_que_vio pqv2
where pqv1.usuario <> pqv2.usuario and not exists
(select * 
from pelis_que_vio pqv3
where pqv1.usuario = pqv3.usuario and 
not exists (select * from pelis_que_vio pqv4 where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id))
and not exists ( select * from pelis_que_vio pqv3 where pqv2.usuario = pqv3.usuario and not exists 
(select * from pelis_que_vio pqv4 where pqv1.usuario = pqv4.usuario and pqv3.pelicula_id = pqv4.pelicula_id)); 
from col_tabla loop
return next tabla;
end loop;
return;
end
$BODY$
LANGUAGE 'plpgsql';
