<?php

require_once ('../modelo/Persona.php');
require_once ('../dataAccess/DataAccess.php');
require_once ('../util/Encriptador.php');

class PersonaDao {
    
    function agregar(Persona $persona)
    {
        $cn = new DataAccess();
        $parametros = array($persona->getUsuario(),$persona->getClave(),$persona->getNombre(),$persona->getApellido());

        $sql = "SELECT agregarPersona($1,$2,$3,$4)";
        $cn->ejecutar($sql,$parametros);
    }
    
    function login(Persona $persona)
    {
        $band = false;
        $cn = new DataAccess();
        $parametros = array($persona->getUsuario(),$persona->getClave());
        $sql = "SELECT COUNT (*) AS res FROM persona WHERE clave = MD5($2) AND usuario = $1";
        $datos = $cn->consultar($sql,$parametros);
        
        //$resultado = ($datos[0])["res"];

        foreach ($datos as $fila) {
            $resultado = $fila["res"];
            if ($resultado == 1){
                $band = true;
                echo "Clave verificada";

                $parametros = array($persona->getUsuario());
                $sql = "SELECT * FROM persona WHERE usuario = $1";
                $datos2 = $cn->consultar($sql,$parametros);

                foreach ($datos2 as $fila2) {
                    $persona->setNombre($fila2["nombre"]);
                    $persona->setApellido($fila2["apellido"]);
                }
            }
        }
        return $band;
    }
    
    function cambiarContraseña(Persona $persona)
    {
        $cn = new DataAccess();
        $parametros = array($persona->getUsuario(),encryptPwd($persona->getClave()));

        $sql = "SELECT cambiarContrasena($1,$2)";
        $cn->ejecutar($sql,$parametros);
    }
}
