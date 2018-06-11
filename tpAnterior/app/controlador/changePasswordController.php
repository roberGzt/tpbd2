<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');
require_once ('../util/Session.php');

$URL = '../../changePassword.php';

$passwordActual = filter_input(INPUT_POST, "passwordActual");
$passwordNueva = filter_input(INPUT_POST, "passwordNueva");
$passwordConfirmada = filter_input(INPUT_POST, "passwordConfirmar");

if($passwordNueva != $passwordConfirmada)
{
    $URL.= '?error=Las claves nuevas no coinciden';
}
else
{
    if($passwordActual == $passwordNueva)
    {
        $URL.= '?error=La clave actual no puede ser igual a la nueva';
    }
    else
    {
        $persona = new Persona(getUserName(),null,null,$passwordActual);
        $personaDao = new PersonaDao();
        if(!$personaDao->login($persona))
        {
            $URL.= '?error=La clave actual es erronea';
        }
        else
        {
            $persona->setClave($passwordNueva);
            $personaDao->cambiarContraseña($persona);
            $URL.= '?success=Clave cambiada con exito';
        }
    }
    
}
header('Location: '.$URL);

