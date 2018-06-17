
                                 -- primero, seleccionamos todos los pares de usuarios para los cuales se cumple que 
                                                                                            -- usuario 1 < usuario 2
select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2 
from pelis_que_vio pqv1, pelis_que_vio pqv2  
where pqv1.usuario < pqv2.usuario 

and not exists                          -- (1) NO existe película vista por usuario 1 que el usuario 2  NO haya visto
    (select *  
    from pelis_que_vio pqv3 
    where pqv1.usuario = pqv3.usuario
    and not exists                            --                         (2) por cada pelicula vista por el usuario 1
        (select *                             --                    se verifica que haya sido vista por el usuario 2.
        from pelis_que_vio pqv4               --  si no fue vista, esta query devuelve empty => not exists (2) = true
        where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id --         => not exists (1) =  false 
        )                                                                       --  (pues la query no devolvió vácio)
    )                                                                           --            => se descarta la tupla
                                                                                
and not exists                             -- NO existe película vista por usuario 2 que el usuario 1  NO haya visto.
    (select *                              --                                    Explicación analoga a query anterior
    from pelis_que_vio pqv5 
    where pqv2.usuario = pqv5.usuario        
    and not exists  
        (select *           
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