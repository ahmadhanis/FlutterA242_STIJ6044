<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
include_once('dbconnect.php');

if (!isset($_POST['tukangid']) || !isset($_POST['rating'])) {
    echo json_encode(['status' => 'failed', 'message' => 'Missing required parameters']);
    exit;
}

$tukangid = mysqli_real_escape_string($conn, $_POST['tukangid']);
$new_rating = intval($_POST['rating']);

// Fetch the previous rating
$sql = "SELECT tukang_rating FROM tbl_tukangs WHERE tukang_id = '$tukangid'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $previous_rating = intval($row['tukang_rating']);
} else {
    echo json_encode(['status' => 'failed', 'message' => 'Tukang not found']);
    exit;
}

// Determine the final rating
if ($previous_rating == 0) {
    $final_rating = $new_rating; // If no previous rating, set it directly
} else {
    $final_rating = intval(round(($previous_rating + $new_rating) / 2));
}

// Update the rating in the database
$update_sql = "UPDATE tbl_tukangs SET tukang_rating = '$final_rating' WHERE tukang_id = '$tukangid'";

if ($conn->query($update_sql) === TRUE) {
    echo json_encode(['status' => 'success', 'message' => 'Rating updated successfully', 'new_rating' => $final_rating]);
} else {
    echo json_encode(['status' => 'failed', 'message' => 'Failed to update rating']);
}

$conn->close();
