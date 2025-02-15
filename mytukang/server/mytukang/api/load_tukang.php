<?php
header("Access-Control-Allow-Origin: *");
include_once('dbconnect.php');

$sqlloadtukang = "SELECT * FROM tbl_tukangs";
$result = $conn->query($sqlloadtukang);

if ($result->num_rows > 0) {
    $sentArray = array();
    while ($row = $result->fetch_assoc()) {
        $sentArray[] = $row;
    }
    $response = array('status' => 'success', 'data' => $sentArray);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);    
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>