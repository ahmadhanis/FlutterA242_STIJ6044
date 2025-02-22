<?php
header("Access-Control-Allow-Origin: *");
include_once('dbconnect.php');
//district=$selectedDistrict&field=$selectedField

$district = $_GET['district'];
$field = $_GET['field'];

if ($district == "All" && $field == "All") {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs";
} else if ($district == "All" && $field != "All") {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_field = '$field'";
} else if ($district != "All" && $field == "All") {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_location = '$district'";
} else {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_location = '$district' AND tukang_field = '$field'";
}

// $sqlloadtukang = "SELECT * FROM tbl_tukangs";
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