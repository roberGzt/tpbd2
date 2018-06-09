<html>
    <head>
        <?php
            include('./includes/head.php');
        ?>
        <title>TP2 Bases de Datos</title>
    </head>
    <body>
        <?php
            require ('./app/util/Session.php');
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
