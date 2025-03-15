<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
include_once('dbconnect.php');

if (!isset($_GET['fav']) || empty($_GET['fav'])) {
    $response = array('status' => 'failed', 'message' => 'No favorite IDs provided');
    sendJsonResponse($response);
    exit;
}

$fav = json_decode($_GET['fav'], true);

if (!is_array($fav) || empty($fav)) {
    $response = array('status' => 'failed', 'message' => 'Invalid favorite IDs');
    sendJsonResponse($response);
    exit;
}

// Sanitize IDs
$fav_sanitized = array_map('intval', $fav);
$placeholders = implode(',', $fav_sanitized);

// Execute query without prepared statement
$sql = "SELECT * FROM tbl_tukangs WHERE tukang_id IN ($placeholders)";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $sentArray = array();
    while ($row = $result->fetch_assoc()) {
        $sentArray[] = $row;
    }
    $response = array('status' => 'success', 'data' => $sentArray);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null, 'message' => 'No matching records found');
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray) {
    echo json_encode($sentArray);
}
?>