<?php

require_once ('../util/Session.php');

logout();

$newURL = '../../index.php';

header('Location: '.$newURL);