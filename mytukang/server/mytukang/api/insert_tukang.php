<?php
header("Access-Control-Allow-Origin: *");
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require "/home4/slumber6/PHPMailer/src/Exception.php";
require "/home4/slumber6/PHPMailer/src/PHPMailer.php";
require "/home4/slumber6/PHPMailer/src/SMTP.php";

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
        sendMail($email,$otp,$rawpassword,$last_id);
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

function sendMail($email,$otp,$rawpassword,$id){
     $mail = new PHPMailer(true);
        try {
            $mail->isSMTP();
            $mail->Host = 'mail.slumberjer.com'; // Replace with your SMTP host
            $mail->SMTPAuth = true;
            $mail->Username = 'mytukang@slumberjer.com'; // Replace with your SMTP username
            $mail->Password = 'mBNDpkkDi743'; // Replace with your SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
            $mail->Port = 465;

            // Email content
            $mail->setFrom('mytukang@slumberjer.com', 'MyTukang Mailer'); // Replace with your "from" email
            $mail->addAddress($email, "User");
            $mail->isHTML(true);
            $mail->Subject = 'MyTukang New Registration';
            
            $mail->Body = "
            <!DOCTYPE html>
            <html lang='en'>
            <head>
                <meta charset='UTF-8'>
                <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                <title>MyTukang Validation and Registration</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                        margin: 0;
                        padding: 0;
                    }
                    .container {
                        max-width: 600px;
                        margin: 20px auto;
                        background: #fff;
                        padding: 20px;
                        border-radius: 10px;
                        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                        text-align: center;
                    }
                    h1 {
                        color: #4A148C;
                    }
                    p {
                        font-size: 16px;
                        color: #333;
                        line-height: 1.6;
                    }
                    .btn {
                        display: inline-block;
                        padding: 12px 20px;
                        margin: 10px;
                        text-decoration: none;
                        color: #fff;
                        border-radius: 5px;
                        font-size: 16px;
                    }
                    .verify-btn {
                        background-color: #4CAF50;
                    }
                    .delete-btn {
                        background-color: #D32F2F;
                    }
                    .edit-btn {
                        background-color: #FFA000;
                    }
                    .footer {
                        margin-top: 20px;
                        font-size: 14px;
                        color: #777;
                    }
                </style>
            </head>
            <body>
                <div class='container' >
                    <h1>Item Verification</h1>
                    <p>Hi <strong>$email</strong>,</p>
                    <p>Thank you for submitting your registration to MyTukang.</p>
                    <p>
                    Your ID: $id<br>
                    Your Email: $email <br>
                    Your Password: $rawpassword<br>
                    Your OTP: $otp <br>
                    </p>
                    <p>Please verify your registration using the button below:</p>
                    <a href='https://slumberjer.com/mytukang/api/verify.php?email=$email&otp=$otp&userid=$id' class='btn verify-btn'>Verify Account</a>
                    
                    <p>If you wish to remove your account, click below:</p>
                    <a href='https://slumberjer.com/mytukang/api/deletetukang.php?email=$email&id=$id' class='btn delete-btn'>Remove Account</a>
                    
                    <p class='footer'>If you did not request this, please ignore this email.</p>
                </div>
            </body>
            </html>
            ";
        $mail->send();
           
        } catch (Exception $e) {
           
        }

}
?>