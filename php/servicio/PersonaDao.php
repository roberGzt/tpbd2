<?php

require_once ('../modelo/Persona.php');
require_once ('../dataSource/DataSource.php');

class PersonaDao {
    private $mensajeError;
    
    public function agregar(Persona $persona)
    {
        $dataSource = new DataSource();
        $parametros = array($persona->getUsuario(),$persona->getClave(),$persona->getNombre(),$persona->getApellido());
        $sql = "INSERT INTO Persona (usuario,clave,nombre,apellido) VALUES ($1, MD5($2), $3, $4)";
        $ret =  $dataSource->ejecutar($sql,$parametros)? true : false;
        if (!$ret){
            $mensajeError = $dataSource->getLastError();
        }
        return $ret;
    }
    
    public function login(Persona $persona)
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
        if (!$ret){
            $mensajeError = $dataSource->getLastError();
        }
        return $ret;
    }
    
    public function cambiarContraseña(Persona $persona)
    {
        $dataSource = new DataSource();
        $parametros = array($persona->getUsuario(),$persona->getClave());        

        $sql = "UPDATE persona SET clave = MD5($2) WHERE usuario = $1";
        $ret =  $dataSource->ejecutar($sql,$parametros)? true : false;
        if (!$ret){
            $mensajeError = $dataSource->getLastError();
        }
        return $ret;
    }

    public function getmensajeError(){
        return $mensajeError;
    }

}
