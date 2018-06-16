
-- primero, seleccionamos todos los pares de usuarios para los cuales se cumple que 
-- usuario 1 < usuario 2
select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2 
from pelis_que_vio pqv1, pelis_que_vio pqv2  
where pqv1.usuario < pqv2.usuario 

and not exists -- no se cumple que si el usuario 1 NO vio una pelicula entonces el usuario 2 TAMPOCO la vio.
    (select *  
    from pelis_que_vio pqv3 
    where pqv1.usuario = pqv3.usuario
    and not exists 
        (select * -- todas las peliculas que vio el usuario 2 de la lista de pelis que vio el usuario 1
        from pelis_que_vio pqv4
        where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id
        )
    )
and not exists -- no se cumple que si el usuario 2 NO vio una pelicula entonces el usuario 1 TAMPOCO la vio.
    (select *
    from pelis_que_vio pqv5 
    where pqv2.usuario = pqv5.usuario        
    and not exists  
        (select * -- todas las peliculas que vio el usuario 1 de la lista de pelis que vio el usuario 2
        from pelis_que_vio pqv6
        where pqv1.usuario = pqv6.usuario and pqv5.pelicula_id = pqv6.pelicula_id
        )
    )

union

-- luego, seleccionamos todos los pares de usuarios que no vieron ninguna pelicula
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
where usuarios_que_no_vieron_nada_1.usuario < usuarios_que_no_vieron_nada_2.usuario;