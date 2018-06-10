<?php

require_once ('../util/Session.php');

logout();

$newURL = '../../index.php?success=Sesión finalizada.';

header('Location: '.$newURL);