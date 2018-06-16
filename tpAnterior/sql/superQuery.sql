
select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2   ----- 1 p1, 2 p1 , 3 p2: 
from pelis_que_vio pqv1, pelis_que_vio pqv2  --<1,p1;2,p1>,<1,p1;3,p2>
                                             --<2,p1;3,p2>

where pqv1.usuario < pqv2.usuario and not exists

(select *  
from pelis_que_vio pqv3 
where pqv1.usuario = pqv3.usuario  -- pqv3.usuario = 1, osea las pelis que vio 1

and not exists 
    (select * -- todas las peliculas que vio el usuario 2 de la lista de pelis que vio el usuario 1
    from pelis_que_vio pqv4
    where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id))-- pqv4.usuario = maria, todas las pelis que vieron juan y maria 
   
and not exists 
        (select *  -- todas las peliculas que vio el usuario 2 pero no vio el usuario 1
        from pelis_que_vio pqv5 
        where pqv2.usuario = pqv5.usuario        
        
        and not exists  
            (select * --seleccionar todas las pelis que vio el usuario 1, de la lista de pelis que vio el usuario 2.
            from pelis_que_vio pqv6
            where pqv1.usuario = pqv6.usuario and pqv5.pelicula_id = pqv6.pelicula_id));

union


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

