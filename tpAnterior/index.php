<html>
    <head>
        <?php
            include('./templates/header.html');
        ?>
        <title>TP2 Bases de Datos - Iniciar Sesi&oacute;n</title>
    </head>
    <body>
        <?php
            require ('./php/util/Session.php');
            if(!isLogged()) {
                include('./templates/signInUp.html');
            } else {
                $newURL = 'listarPelisVistas.php';
                header('Location: '.$newURL);
            }                
            include('./templates/footer.html');
        ?>
    </body>
</html>
