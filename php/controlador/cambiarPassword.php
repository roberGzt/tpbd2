<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaService.php');
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
    $PersonaService = new PersonaService();
    $persona->setClave($passwordNuevo);
    $PersonaService->cambiarContraseña($persona);
    $URL.= '?success=Constraseña actualizada con éxito.';
}
header('Location: '.$URL);

