<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaService.php');



$user = $_POST["user"];
$nombre = $_POST["firstname"];
$apellido = $_POST["lastname"];
$clave = $_POST["passwd"];
$URL = '../../index.php';


$persona = new Persona($user,$nombre,$apellido,$clave);
$PersonaService = new PersonaService();
$URL .= $PersonaService->agregar($persona)? "?success=Usuario creado con éxito." :  "?error=Ocurrió un error al crear el usuario.";

header('Location: '.$URL);

