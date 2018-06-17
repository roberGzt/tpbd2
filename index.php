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
                include('./templates/login.html');
            } else {
                $URL = 'listarPelisVistas.php';
                header('Location: '.$URL);
            }
            include('./php/util/Notificaciones.php');                
            include('./templates/footer.html');
        ?>
    <script src="js/app/ui/notificaciones.js"></script>
</body>

</html>