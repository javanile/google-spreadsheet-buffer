<?php

$headers = getallheaders();
$query = file_get_contents('php://input');
$database = 'mysql';
$password = getenv('MARIADB_ROOT_PASSWORD');
$accessToken = null;

if (isset($headers['Authorization'])) {
    $authorizationHeader = $headers['Authorization'];
    $matches = array();
    if (preg_match('/Bearer (.+)/', $authorizationHeader, $matches)) {
        if (isset($matches[1])) {
            $accessToken = json_decode(base64_decode($matches[1]), true);
        }
    }
}

if (empty($accessToken)) {
    http_response_code(401);
    exit;
}

var_dump($accessToken);

exit;

$pdo = new PDO("mysql:host=0.0.0.0;dbname={$database}", 'root', $password);
$pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, false);

$unbufferedResult = $pdo->query($query);

foreach ($unbufferedResult as $row) {
    var_dump($row);
}
