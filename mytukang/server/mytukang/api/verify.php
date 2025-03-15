<?php
header('Access-Control-Allow-Origin: *');
include_once('dbconnect.php');

if (!isset($_GET['email']) || !isset($_GET['otp']) || !isset($_GET['userid'])) {
    showPage("Error", "Missing required parameters.", "w3-red");
    exit;
}

$email = mysqli_real_escape_string($conn, $_GET['email']);
$otp = mysqli_real_escape_string($conn, $_GET['otp']);
$userid = mysqli_real_escape_string($conn, $_GET['userid']);

// Verify user details
$sql = "SELECT tukang_id FROM tbl_tukangs WHERE tukang_id = '$userid' AND tukang_email = '$email' AND tukang_otp = '$otp'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    // Update verification status
    $update_sql = "UPDATE tbl_tukangs SET tukang_otp = 0 WHERE tukang_id = '$userid'";
    if ($conn->query($update_sql) === TRUE) {
        showPage("Success", "Verification successful! Your account is now verified.", "w3-green");
    } else {
        showPage("Error", "Verification failed. Please try again later.", "w3-red");
    }
} else {
    showPage("Error", "Invalid verification details. Please check your email and OTP.", "w3-red");
}

$conn->close();

function showPage($title, $message, $color) {
    echo "<!DOCTYPE html>";
    echo "<html lang='en'>";
    echo "<head>";
    echo "<meta name='viewport' content='width=device-width, initial-scale=1'>";
    echo "<link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'>";
    echo "<title>$title</title>";
    echo "</head>";
    echo "<body class='w3-light-grey'> style='margin:auto'";
    echo "<div class='w3-container w3-center w3-padding-64'>";
    echo "<div class='w3-card w3-round w3-white w3-padding-large w3-margin-auto' style='max-width: 500px;'>";
    echo "<h2 class='$color w3-padding'>$title</h2>";
    echo "<p class='w3-large'>$message</p>";
    echo "<a href='https://slumberjer.com/mytukang/' class='w3-button w3-blue w3-margin-top'>Go to Homepage</a>";
    echo "</div>";
    echo "</div>";
    echo "</body>";
    echo "</html>";
}
?>