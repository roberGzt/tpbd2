<?php

require_once ('../util/Session.php');

logout();

$URL = '../../index.php';

header('Location: '.$URL);