
        <?php
            require_once ('../util/Session.php');
            require_once ('../modelo/Pelicula.php');
            require_once ('../servicio/PelisQueVioService.php');
            $html = "";
            $PelisQueVioService = new PelisQueVioService();
            $peliculas = $PelisQueVioService->listarPelisDe(getUserName());
            foreach($pelicula as $peliculas){
                $html.= "<li class=\"list-group-item\">" . $pelicula->getNombre() . "</li>";
            }
            echo $html;            
            
        ?>

