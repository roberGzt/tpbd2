<?php

class DataAccess 
{
    private $_host;
    private $_credentials;
    private $_dbname;
    private $_cn;
    private $_port;
    private $_band;

    public function __construct()
    {
        $this->_host = "host=127.0.0.1";
        $this->_port = "port=5434";
        $this->_credentials = "user=tp2bdii password=tp2bdii";
        $this->_dbname = "dbname=tp2bdii";
        $this->_band = 0;
    }

    private function abrir()
    {
        if($this->_band == 1) return;
        $stringConnection = "$this->_host $this->_port $this->_dbname $this->_credentials";
        $this->_cn = pg_connect($stringConnection)
                or die('No se ha podido conectar: ' . pg_last_error());
        $this->_band = 1;
    }

    private function cerrar()
    {
        if($this->_band == 0) return;
        pg_close($this->_cn);
        $this->_band = 0;
    }
    
    public function ejecutar($consulta,$parametros)
    {
        $this->abrir();
        $this->comprobarConexion();
        pg_query_params($this->_cn,$consulta,$parametros) or die('La consulta fallo: ' . pg_last_error());
        $this->cerrar();
    }
    
    public function consultar($consulta,$parametros)
    {
        $this->abrir();
        $this->comprobarConexion();
        $datos = array();
        $resultado = pg_query_params($this->_cn,$consulta,$parametros) or die('La consulta fallo: ' . pg_last_error());
        if($resultado)
        {
            while ($row = pg_fetch_array($resultado, NULL, PGSQL_ASSOC))
            {
                $datos[] = $row;      
            }
            pg_free_result($resultado);
        }
        $this->cerrar();
        return $datos;
    }
    
    private function comprobarConexion()
    {
        if(pg_last_error())
        {
            echo "Failed to connect to PostgreSQL: " . pg_last_error();
        }
    }
}
