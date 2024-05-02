<?php

$headers = getallheaders();
$query = file_get_contents('php://input');
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
    die('Authorization token is not valid.'.PHP_EOL);
}

$database = $accessToken['database'] ?? 'mysql';
$username = $accessToken['username'] ?? 'root';

$pdo = new PDO("mysql:host=0.0.0.0;dbname={$database}", $username, $password);
$pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, false);

$unbufferedResult = $pdo->query($query);

$dataset = $unbufferedResult->fetchAll(PDO::FETCH_ASSOC);

$output = array();
foreach ($dataset as $row) {
    $outputRow = array();
    foreach ($row as $cell) {
        $outputRow[] = $cell;
    }
    $output[] = $outputRow;
}

echo json_encode($output, JSON_PRETTY_PRINT);
