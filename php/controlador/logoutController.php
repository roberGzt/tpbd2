<?php

require_once ('../util/Session.php');

logout();

$URL = '../../index.php?success=Sesión finalizada.';

header('Location: '.$URL);