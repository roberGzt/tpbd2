<?php

require_once ('../modelo/Persona.php');
require_once ('../servicio/PersonaDao.php');



$user = $_POST["user"];
$nombre = $_POST["firstname"];
$apellido = $_POST["lastname"];
$clave = $_POST["passwd"];
$URL = '../../index.php';


$persona = new Persona($user,$nombre,$apellido,$clave);
$personaDao = new PersonaDao();
$URL .= $personaDao->agregar($persona)? "?success=Usuario creado con éxito." :  "?error=Ocurrió un error al crear el usuario.";

header('Location: '.$URL);

