
        <?php
            require_once ('../util/Session.php');
            require_once ('../modelo/Pelicula.php');
            require_once ('../servicio/PelisQueVioService.php');
            $html = "";
            $PelisQueVioService = new PelisQueVioService();
            $peliculas = $PelisQueVioService->listarPelisDe(getUserName());
            if (count($peliculas) > 0 ){
                foreach($peliculas as $pelicula){
                    $html.= "<li class=\"list-group-item\">" . $pelicula->getNombre() . "</li>";
                }
            } else {
                $html.="<h1>:-(<h1><h2>No viste ninguna peli!<h2>"
            }
            echo $html;            
        ?>

