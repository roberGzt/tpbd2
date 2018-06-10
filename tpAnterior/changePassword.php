<html>

<head>
    <?php
            include('./templates/header.html');
        ?>
    <title>TP2 Bases de Datos - Cambiar Contraseña</title>
</head>

<body>
    <?php
            require_once ('./php/util/Session.php');
            if(!isLogged()) {
                $newURL = 'index.php';
                header('Location: '.$newURL);
            } else {
                include('./templates/navBar.html');
                include('./templates/changePasswordView.html');
            }
            include('./php/util/Notificaciones.php');                
            include('./templates/footer.html');
        ?>
    <script src="js/app/ui/notificaciones.js"></script>
</body>

</html>