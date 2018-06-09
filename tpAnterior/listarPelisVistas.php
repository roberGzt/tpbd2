<html>
    <head>
        <?php
            include('./templates/header.html');
        ?>
        <title>TP2BDII - Cambiar Contraseña</title>
    </head>
    <body>
        <?php
            require_once ('./app/util/Sesion.php');
            if(!isLogged())
            {
                $newURL = 'index.php';
                header('Location: '.$newURL);
            }
            else
            {
                include('./templates/navBar.html');
                include('./templates/listarPelisQueVieronView.html');
            }
                
        ?>
        
    </body>
</html>