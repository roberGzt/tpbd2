<?php

class DataSource 
{
    private $_host;
    private $_credentials;
    private $_dbname;
    private $_cn;
    private $_port;
    private $_band;

    public function __construct() {
        $this->_host = "host=127.0.0.1";
        $this->_port = "port=5434";
        $this->_credentials = "user=tp2bd2 password=tp2bd2";
        $this->_dbname = "dbname=tp2bd2";
        $this->_band = 0;
    }

    public function ejecutar($consulta,$parametros) {
        $this->abrir();        
        $ret = pg_query_params($this->_cn,$consulta,$parametros);
        $this->cerrar();
        return $ret? true :false;
    }
    
    public function consultar($consulta,$parametros)
    {
        $this->abrir();       
        $datos = array();
        $resultado = pg_query_params($this->_cn,$consulta,$parametros);
        if($resultado) {
            while ($row = pg_fetch_array($resultado, NULL, PGSQL_ASSOC)) {
                $datos[] = $row;      
            }
            pg_free_result($resultado);
        } else {
            return $resultado;
        }
        $this->cerrar();
        return $datos;
    }
    
    public function getLastError(){
        if (pg_last_error()){
            return pg_last_error();
        } else {
            return false;
        }
    }

    private function abrir() {
        if($this->_band == 1) return;
        $stringConnection = "$this->_host $this->_port $this->_dbname $this->_credentials";
        $this->_cn = pg_connect($stringConnection)
                or die('No se ha podido conectar: ' . pg_last_error());
        $this->_band = 1;
    }

    private function cerrar() {
        if($this->_band == 0) return;
        pg_close($this->_cn);
        $this->_band = 0;
    }
    
   
}
