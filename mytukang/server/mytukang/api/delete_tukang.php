<?php
header( 'Access-Control-Allow-Origin: *' );
$tukangid = $_POST[ 'tukang_id' ];
$shapass = sha1( $_POST[ 'password' ] );

include_once( 'dbconnect.php' );

$sqldelete = "DELETE FROM `tbl_tukangs` WHERE `tukang_id` = '$tukangid' AND `tukang_pass` = '$shapass'";

try {
    $result = $conn->query( $sqldelete );
    // Check if query succeeded and at least one row was affected
    if ( $result && $conn->affected_rows > 0 ) {
        $response = array( 'status' => 'success', 'data' => $sqldelete );
    } else {
        $response = array( 'status' => 'failed', 'data' => $sqldelete );
    }
    sendJsonResponse( $response );
} catch ( Exception $e ) {
    $response = array( 'status' => 'failed', 'data' => null );
    sendJsonResponse( $response );
}

function sendJsonResponse( $sentArray ) {
    header( 'Content-Type: application/json' );
    echo json_encode( $sentArray );
}
?>
