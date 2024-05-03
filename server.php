<?php

$dsn = 'mysql:host=0.0.0.0;dbname=%s';
$pdoOptions = [
    PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => false,
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
];

if ($_SERVER['REQUEST_URI'] == '/_health') {
    $health = ['status' => 'ok'];

    try {
        new PDO(sprintf($dsn, getenv('BUFFER_DATABASE')), getenv('BUFFER_USER'), getenv('BUFFER_PASSWORD'), $pdoOptions);
    } catch (\PDOException $exception) {
        http_response_code(503);
        $health['status'] = 'error';
        $health['message'] = $exception->getMessage();
    }

    die(json_encode($health).PHP_EOL);
}

$headers = getallheaders();
$query = file_get_contents('php://input');
$tokenError = 'Authorization token is not valid.'.PHP_EOL;
$accessToken = null;
$options = filter_input(INPUT_GET, 'options');

if (isset($headers['Authorization'])) {
    $authorizationHeader = $headers['Authorization'];
    $matches = array();
    if (preg_match('/Bearer (.+)/', $authorizationHeader, $matches)) {
        if (isset($matches[1])) {
            $accessToken = json_decode(base64_decode($matches[1]), true);
        }
    }
}

if (empty($accessToken) || empty($accessToken['password'])) {
    http_response_code(401);
    die($tokenError);
}

$database = $accessToken['database'] ?? getenv('BUFFER_DATABASE');
$username = $accessToken['username'] ?? getenv('BUFFER_USER');
$password = $accessToken['password'];

try {
    $pdo = new PDO(sprintf($dsn, $database), $username, $password, $pdoOptions);
} catch (\PDOException $exception) {
    http_response_code(401);
    die($tokenError);
}

try {
    $unbufferedResult = $pdo->query($query);
    $dataset = $unbufferedResult->fetchAll(PDO::FETCH_ASSOC);
} catch (\PDOException $exception) {
    http_response_code(422);
    die($exception->getMessage().PHP_EOL);
}

$output = array();
foreach ($dataset as $row) {
    $outputRow = array();
    foreach ($row as $cell) {
        $outputRow[] = $cell;
    }
    $output[] = $outputRow;
}

echo json_encode($output, JSON_PRETTY_PRINT);
