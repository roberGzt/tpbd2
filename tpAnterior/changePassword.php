<html>
    <head>
        <?php
            include('./templates/header.html');
        ?>
        <title>TP2 Bases de Datos - Cambiar Contraseña</title>
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
                include('./templates/changePasswordView.html');
            }
                
        ?>
        
    </body>
</html>