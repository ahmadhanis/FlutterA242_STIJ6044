<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require "/home4/slumber6/PHPMailer/src/Exception.php";
require "/home4/slumber6/PHPMailer/src/PHPMailer.php";
require "/home4/slumber6/PHPMailer/src/SMTP.php";

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
include_once('dbconnect.php');

if (!isset($_POST['tukangid']) || !isset($_POST['reason'])) {
    echo json_encode(['status' => 'failed', 'message' => 'Missing required parameters']);
    exit;
}

$tukangid = mysqli_real_escape_string($conn, $_POST['tukangid']);
$reason = mysqli_real_escape_string($conn, $_POST['reason']);
$adminEmail = 'mytukang@slumberjer.com';

// Fetch tukang details
$sql = "SELECT * FROM tbl_tukangs WHERE tukang_id = '$tukangid'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $tukangData = $result->fetch_assoc();
    $tukangName = $tukangData['tukang_name'];
    $tukangEmail = $tukangData['tukang_email'];
    $tukangPhone = $tukangData['tukang_phone'];
    $tukangField = $tukangData['tukang_field'];
    $tukangLocation = $tukangData['tukang_location'];
} else {
    echo json_encode(['status' => 'failed', 'message' => 'Tukang not found']);
    exit;
}

// Email content with modern styling
$subject = "Report on Tukang: $tukangName";
$body = "<html><head><style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px #ddd; max-width: 600px; margin: auto; }
        .header { background-color: #007bff; color: white; padding: 10px; text-align: center; font-size: 20px; border-radius: 5px 5px 0 0; }
        .content { padding: 20px; font-size: 16px; color: #333; }
        .footer { text-align: center; padding: 10px; font-size: 14px; color: gray; }
    </style></head><body>
    <div class='container'>
        <div class='header'>MyTukang Report</div>
        <div class='content'>
            <p><strong>Name:</strong> {$tukangName}</p>
            <p><strong>Email:</strong> {$tukangEmail}</p>
            <p><strong>Phone:</strong> {$tukangPhone}</p>
            <p><strong>Field:</strong> {$tukangField}</p>
            <p><strong>Location:</strong> {$tukangLocation}</p>
            <p><strong>Reason for Report:</strong> {$reason}</p>
            <br>
            <p>Please review and take necessary actions.</p>
        </div>
        <div class='footer'>MyTukang &copy; 2024</div>
    </div>
</body></html>";

$mail = new PHPMailer(true);

try {
    $mail->isSMTP();
    $mail->Host = 'mail.slumberjer.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'mytukang@slumberjer.com';
    $mail->Password = 'mBNDpkkDi743';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->Port = 465;

    $mail->setFrom('mytukang@slumberjer.com', 'MyTukang Mailer');
    $mail->addAddress("slumberjer@gmail.com", "Admin");
    $mail->isHTML(true);
    $mail->Subject = 'MyTukang Report';
    $mail->Body = $body;

    $mail->send();
    echo json_encode(['status' => 'success', 'message' => 'Report submitted successfully']);
} catch (Exception $e) {
    echo json_encode(['status' => 'failed', 'message' => 'Email could not be sent. Mailer Error: ' . $mail->ErrorInfo]);
}
?>