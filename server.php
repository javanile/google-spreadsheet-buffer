<?php

echo "Hello, World!";

$password = getenv('MARIADB_ROOT_PASSWORD');
$query = file_get_contents('php://input');

$pdo = new PDO("mysql:host=0.0.0.0;dbname=mysql", 'root', $password);
$pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, false);

$unbufferedResult = $pdo->query("SHOW TABLES");

foreach ($unbufferedResult as $row) {
    var_dump($row);
}

var_dump($query);