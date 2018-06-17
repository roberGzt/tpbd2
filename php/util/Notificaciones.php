<?php
    $success = filter_input(INPUT_GET, "success");
    $error = filter_input(INPUT_GET, "error");
    if(!is_null($success) && $success){
        echo "<script>mensaje={};mensaje.success='".$success."';console.log(mensaje.success);</script>";
    }else{
        echo "<script>mensaje={};mensaje.error='".$error."';console.log(mensaje.error);</script>";
    }
?>