<?php

require_once ('../modelo/Persona.php');
require_once ('../dataSource/DataSource.php');
require_once ('../util/Encriptador.php');

class PersonaDao {
    
    function agregar(Persona $persona)
    {
        $dataSource = new DataSource();
        $parametros = array($persona->getUsuario(),$persona->getClave(),$persona->getNombre(),$persona->getApellido());

        $sql = "SELECT agregarPersona($1,$2,$3,$4)";
        $dataSource->ejecutar($sql,$parametros);
    }
    
    function login(Persona $persona)
    {
        $ret = false;
        $dataSource = new DataSource();
        $parametros = array($persona->getUsuario(),$persona->getClave());
        $sql = "SELECT COUNT (*) AS res FROM persona WHERE clave = MD5($2) AND usuario = $1";
        $datos = $dataSource->consultar($sql,$parametros);
        
        foreach ($datos as $fila) {
            $resultado = $fila["res"];
            if ($resultado == 1){
                $ret = true;
                $parametros = array($persona->getUsuario());
                $sql = "SELECT * FROM persona WHERE usuario = $1";
                $datos2 = $dataSource->consultar($sql,$parametros);

                foreach ($datos2 as $fila2) {
                    $persona->setNombre($fila2["nombre"]);
                    $persona->setApellido($fila2["apellido"]);
                }
            }
        }
        return $ret;
    }
    
    function cambiarContraseña(Persona $persona)
    {
        $dataSource = new DataSource();
        $parametros = array($persona->getUsuario(),encryptPwd($persona->getClave()));

        $sql = "SELECT cambiarContrasena($1,$2)";
        $dataSource->ejecutar($sql,$parametros);
    }
}
