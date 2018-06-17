<?php

require_once ('../modelo/Tupla.php');
require_once ('../modelo/Pelicula.php');
require_once ('../dataSource/DataSource.php');

class PelisQueVioService {
    
    function listarVistas() {
        $tuplas = array();
        $tupla = new Tupla(null, null);
        $cn = new DataSource();
        $parametros = array();        
        
        $sql = "
                select distinct pqv1.usuario as usuario1, pqv2.usuario as usuario2 
                from pelis_que_vio pqv1, pelis_que_vio pqv2  
                where pqv1.usuario < pqv2.usuario 
                and not exists
                (select *  
                from pelis_que_vio pqv3 
                where pqv1.usuario = pqv3.usuario
                and not exists
                    (select *
                    from pelis_que_vio pqv4
                    where pqv2.usuario = pqv4.usuario and pqv3.pelicula_id=pqv4.pelicula_id
                    )                                                                      
                )                                                                      
                and not exists                      
                (select *                           
                from pelis_que_vio pqv5 
                where pqv2.usuario = pqv5.usuario        
                and not exists  
                    (select *           
                    from pelis_que_vio pqv6
                    where pqv1.usuario = pqv6.usuario and pqv5.pelicula_id = pqv6.pelicula_id
                    )
                )
                union
                select usuarios_que_no_vieron_nada_1.usuario,usuarios_que_no_vieron_nada_2.usuario
                from
                (select p.usuario as usuario 
                from persona p
                where not exists
                    (select * from pelis_que_vio pqv where pqv.usuario = p.usuario)
                ) as usuarios_que_no_vieron_nada_1
                , 
                (select p.usuario  as usuario
                from persona p
                where not exists
                    (select * from pelis_que_vio pqv where pqv.usuario = p.usuario)
                ) as usuarios_que_no_vieron_nada_2
                where usuarios_que_no_vieron_nada_1.usuario < usuarios_que_no_vieron_nada_2.usuario
                ";
        $datos = $cn->consultar($sql,$parametros);
        foreach ($datos as $fila) {
            $tupla = new Tupla($fila["usuario1"],$fila["usuario2"]);
            $tuplas[] = $tupla;
       
        }
        return $tuplas;
    }

    function listarPelisDe($userName) {
        $peliculas = array();       
        $cn = new DataSource();
        $parametros = array($userName);        
        
        $sql = "select p.pelicula_nombre as nombre
                from pelicula p
                inner join pelis_que_vio pqv
                on p.pelicula_id = pvq.pelicula_id
                where pvq.usuario = $1";

        $datos = $cn->consultar($sql,$parametros);
        foreach ($datos as $fila) {
            $pelicula = new Pelicula($fila["nombre"]);
            $peliculas[] = $pelicula;       
        }
        return $peliculas;
    }
}