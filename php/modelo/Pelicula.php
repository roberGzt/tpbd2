<?php

class Pelicula{
    private $_nombre;    
    
    public function __construct($nombre) {
        $this->_nombre = $nombre;
    }
    function getNombre() {
        return $this->_nombre;
    }

    function setNombre($nombre) {
        $this->_nombre = $nombre;
    }

}

