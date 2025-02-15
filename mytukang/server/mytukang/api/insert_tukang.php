<?php
header("Access-Control-Allow-Origin: *");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$district = $_POST['district'];
$field = $_POST['field'];
$desc = $_POST['desc'];
$image = $_POST['image'];
$encoded_string = base64_decode($image);
$otp = rand(10000,99999);
$rawpassword = randomString(10);
$shapass = sha1($rawpassword);

include_once('dbconnect.php');

$sqlinsert = "INSERT INTO `tbl_tukangs`(`tukang_name`, `tukang_phone`, `tukang_email`, `tukang_location`, `tukang_field`,`tukang_desc`,`tukang_otp`, `tukang_pass`) 
VALUES ('$name','$phone','$email','$district','$field','$desc','$otp','$shapass')";

try{
    if ($conn->query($sqlinsert) === TRUE) {
        $last_id = $conn->insert_id;
        $path = "../assets/".$last_id.".png";
        file_put_contents($path, $encoded_string);
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}catch(Exception $e){
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function randomString($length = 10)
{
    $characters =
        "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $charactersLength = strlen($characters);
    $randomString = "";
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>