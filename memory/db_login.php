<?php
$servername = "localhost";
$db_username = "root";
$db_password = "";

try {
	$conn = new PDO("mysql:host=$servername;dbname=memory_game", $db_username, $db_password);
	$conn -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	//var_dump($conn);
} catch (PDOEXCEPTION $e) {
	echo "Connection failed: " . $e->getMessage();
}

?>