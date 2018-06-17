<html>
    <head>
        <?php
            include('./templates/header.html');
        ?>
        <title>TP2 Bases de Datos - Logout</title>
    </head>
    <body>
        <?php
            require ('./php/util/Session.php');
            logout();            
            include('./templates/login.html');
            include('./templates/footer.html');
        ?>
    </body>
</html>
