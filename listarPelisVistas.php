<html>

<head>
    <?php
            include('./templates/header.html');
        ?>
    <title>TP2 Bases de Datos - Vista Principal</title>
</head>

<body>
    <?php
            require_once ('./php/util/Session.php');
            if(!isLogged()) {
                $URL = 'index.php';
                header('Location: '.$URL);
            } else {
                include('./templates/navBar.html');
                include('./templates/listarPelisQueVieronView.html');
                include('./templates/listarMisPeliculas.html');
            }
            include('./templates/footer.html');
        ?>
    <script src="js/app/service/pelisVistas.js"></script>
    <script src="js/app/ui/pelisVistas.js"></script>
</body>

</html>