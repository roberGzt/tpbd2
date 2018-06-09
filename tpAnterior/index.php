<html>
    <head>
        <?php
            include('./includes/head.php');
        ?>
        <title>TP2 Bases de Datos asdasd</title>
    </head>
    <body>
        <?php
            require_once ('./app/util/Sesion.php');
            init();
            if(!isLogged())
            {
                include('./includes/signInUp.php');
            }
            else
            {
                $newURL = 'listarPelisVistas.php';
                header('Location: '.$newURL);
            }                
        ?>
        
    </body>
</html>
