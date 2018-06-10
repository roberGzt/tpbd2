<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');
require_once ('../util/Session.php');

$newURL = '../../changePassword.php';

$passwordNueva = filter_input(INPUT_POST, "passwordNueva");
$passwordConfirmada = filter_input(INPUT_POST, "passwordConfirmacion");

if($passwordNueva != $passwordConfirmada)
{
    $newURL.= '?error=Las claves son distintas';
}
else
{
    $persona = new Persona(getUserName(),null,null,$passwordActual);
    $personaDao = new PersonaDao();
    $persona->setClave($passwordNueva);
    $personaDao->cambiarContraseña($persona);
    $newURL.= '?success=Clave cambiada con exito';
}
header('Location: '.$newURL);

