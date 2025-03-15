<?php
header( 'Access-Control-Allow-Origin: *' );
include_once( 'dbconnect.php' );
//district = $selectedDistrict&field = $selectedField

$results_per_page = 10;

if ( isset( $_GET[ 'pageno' ] ) ) {
    $pageno = ( int )$_GET[ 'pageno' ];
} else {
    $pageno = 1;
}

$page_first_result = ( $pageno - 1 ) * $results_per_page;

$district = $_GET[ 'district' ];
$field = $_GET[ 'field' ];

if ( $district == 'All' && $field == 'All' ) {
    $sqlloadtukang = 'SELECT * FROM tbl_tukangs WHERE tukang_otp = 0' ;
} else if ( $district == 'All' && $field != 'All' ) {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_field = '$field' AND tukang_otp = 0";
} else if ( $district != 'All' && $field == 'All' ) {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_location = '$district' AND tukang_otp = 0";
} else {
    $sqlloadtukang = "SELECT * FROM tbl_tukangs WHERE tukang_location = '$district' AND tukang_field = '$field' AND tukang_otp = 0";
}

$result = $conn->query( $sqlloadtukang );
$number_of_result = $result->num_rows;
$number_of_page = ceil( $number_of_result / $results_per_page );
$sqlloadtukang .= " LIMIT $page_first_result , $results_per_page";
$result = $conn->query( $sqlloadtukang );

if ( $result->num_rows > 0 ) {
    $sentArray = array();
    while ( $row = $result->fetch_assoc() ) {
        $sentArray[] = $row;
    }
    $response = array( 'status' => 'success', 'data' => $sentArray, 'numofpage'=>$number_of_page, 'numberofresult'=>$number_of_result );
    sendJsonResponse( $response );
} else {
    $response = array( 'status' => 'failed', 'data' => null, 'numofpage'=>$number_of_page, 'numberofresult'=>$number_of_result );
    sendJsonResponse( $response );

}

function sendJsonResponse( $sentArray )
 {
    header( 'Content-Type: application/json' );
    echo json_encode( $sentArray );
}
?>