<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaService.php');
require_once ('../util/Session.php');

$user = filter_input(INPUT_POST, "username");
$clave = filter_input(INPUT_POST, "password");

$URL = '../../index.php';

$persona = new Persona($user,null,null,$clave);
$PersonaService = new PersonaService();
if(!$PersonaService->login($persona)) {
    $URL.= "?error=El usuario o la contraseña son incorrectos.";
} else {
    login($persona->getUsuario(),$persona->getNombre(),$persona->getApellido());
}

header('Location: '.$URL);
