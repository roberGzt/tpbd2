<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');
require_once ('../util/Session.php');

$URL = '../../changePassword.php';

$passwordNuevo = filter_input(INPUT_POST, "passwordNuevo");
$passwordConfirmacion = filter_input(INPUT_POST, "passwordConfirmacion");

if($passwordNuevo != $passwordConfirmacion)
{
    $URL.= '?error=Error al actualizar: Las contraseñas ingresadas difieren.';
}
else
{
    $persona = new Persona(getUserName(),null,null,$passwordActual);
    $personaDao = new PersonaDao();
    $persona->setClave($passwordNuevo);
    $personaDao->cambiarContraseña($persona);
    $URL.= '?success=Constraseña actualizada con éxito.';
}
header('Location: '.$URL);

