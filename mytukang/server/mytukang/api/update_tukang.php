<?php
header( 'Access-Control-Allow-Origin: *' );
$tukangid = $_POST[ 'tukangid' ];
$name = $_POST[ 'name' ];
$email = $_POST[ 'email' ];
$phone = $_POST[ 'phone' ];
$district = $_POST[ 'district' ];
$field = $_POST[ 'field' ];
$desc = $_POST[ 'desc' ];
$image = $_POST[ 'image' ];
if ( $image != 'NA' ) {
    $encoded_string = base64_decode( $image );
}

include_once( 'dbconnect.php' );

$sqlupdate = "UPDATE `tbl_tukangs` SET `tukang_name`='$name',`tukang_field`='$field',`tukang_desc`='$desc',`tukang_phone`='$phone',`tukang_email`='$email',`tukang_location`='$district' WHERE `tukang_id` = '$tukangid'";

try {
    if ( $conn->query( $sqlupdate ) === TRUE ) {
        if ( $image != 'NA' ) {
            $path = '../assets/'.$tukangid.'.png';
            file_put_contents( $path, $encoded_string );
        }

        $response = array( 'status' => 'success', 'data' => null );
        sendJsonResponse( $response );
    } else {
        $response = array( 'status' => 'failed', 'data' => null );
        sendJsonResponse( $response );
    }
} catch( Exception $e ) {
    $response = array( 'status' => 'failed', 'data' => null );
    sendJsonResponse( $response );
}

function sendJsonResponse( $sentArray )
 {
    header( 'Content-Type: application/json' );
    echo json_encode( $sentArray );
}
?>