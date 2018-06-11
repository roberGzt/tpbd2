﻿select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2
from pelis_que_vio pqv1, pelis_que_vio pqv2
where pqv1.usuario < pqv2.usuario and not exists
( select * from pelis_que_vio pqv3 where pqv1.usuario = pqv3.usuario and 
not exists (select * from pelis_que_vio pqv4 where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id))
and not exists ( select * from pelis_que_vio pqv3 where pqv2.usuario = pqv3.usuario and not exists 
(select * from pelis_que_vio pqv4 where pqv1.usuario = pqv4.usuario and pqv3.pelicula_id = pqv4.pelicula_id));

union




select * from pelis_que_vio;

select * from persona;


select distinct p1.usuario as usuario1, p2.usuario as usuario2
from persona p1, persona p2
where p1.usuario < p2.usuario
and not exists
(
	select * from pelis_que_vio pqv1 where pqv1.usuario = p1.usuario 
	and not exists 
	(
		select * from pelis_que_vio pqv2 where pqv2.usuario = p2.usuario 
	)
);

select usuarios_que_no_vieron_nada_1.usuario,usuarios_que_no_vieron_nada_2.usuario
from
(select p.usuario as usuario 
from persona p
where not exists
(
	select * from pelis_que_vio pqv where pqv.usuario = p.usuario 
)) as usuarios_que_no_vieron_nada_1
, 
(select p.usuario  as usuario
from persona p
where not exists
(
	select * from pelis_que_vio pqv where pqv.usuario = p.usuario 
)) as usuarios_que_no_vieron_nada_2

where usuarios_que_no_vieron_nada_1.usuario <> usuarios_que_no_vieron_nada_2.usuario
;