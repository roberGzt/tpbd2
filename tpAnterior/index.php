<html>
    <head>
        <?php
            include('./includes/head.php');
        ?>
        <title>TP2BDII</title>
    </head>
    <body>
        <?php
            logout();
            require_once ('./app/util/Sesion.php');
            require_once ('./app/util/Logger.php');
            log("Is logged?: " + islogged());
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
