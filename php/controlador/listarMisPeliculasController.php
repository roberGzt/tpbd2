
        <?php
            require_once ('../util/Session.php');
            require_once ('../modelo/Pelicula.php');
            require_once ('../servicio/PelisQueVioService.php');
            $html = "";
            $PelisQueVioService = new PelisQueVioService();
            $peliculas = $PelisQueVioService->listarPelisDe(getUserName());
            $html.="Peliculas de " . getUserName();
            $html.=" Cantidad: " . count($peliculas);
            $html.=" peliculas: " . $peliculas;
            foreach($pelicula as $peliculas){
                $html.= "<li class=\"list-group-item\">" . $pelicula->getNombre() . "</li>";
            }
            echo $html;            
        ?>

