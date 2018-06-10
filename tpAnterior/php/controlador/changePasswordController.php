<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');
require_once ('../util/Session.php');

$newURL = '../../changePassword.php';

$passwordNuevo = filter_input(INPUT_POST, "passwordNuevo");
$passwordConfirmacion = filter_input(INPUT_POST, "passwordConfirmacion");

if($passwordNuevo != $passwordConfirmacion)
{
    $newURL.= '?error=Error al actualizar: Las contraseñas ingresadas difieren.';
}
else
{
    $persona = new Persona(getUserName(),null,null,$passwordActual);
    $personaDao = new PersonaDao();
    $persona->setClave($passwordNuevo);
    $personaDao->cambiarContraseña($persona);
    $newURL.= '?success=Constraseña actualizada con éxito.';
}
header('Location: '.$newURL);

