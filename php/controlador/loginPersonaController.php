<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');
require_once ('../util/Session.php');

$user = filter_input(INPUT_POST, "username");
$clave = filter_input(INPUT_POST, "password");

$URL = '../../index.php';

$persona = new Persona($user,null,null,$clave);
$personaDao = new PersonaDao();
if(!$personaDao->login($persona)) {
    $URL.= "?error=El usuario o la contraseña son incorrectos.";
} else {
    login($persona->getUsuario(),$persona->getNombre(),$persona->getApellido());
}

header('Location: '.$URL);