<?php
require('Auth_User.php');
require('User_group/shopKeeper.php');
require('User_group/customers.php');



$req = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$json = file_get_contents('php://input');
	$data = json_decode($json);
	$req = $data->request;
} else if($_SERVER['REQUEST_METHOD'] === 'GET') {
	if ($_GET) {
		$req = $_GET['request'];
	}
}

$returnData = [];
switch ($req) {
	case '0':
		$request = new users();
		$returnData = $request->getPopularProducts();
	break;
	
	case 'popular_products':
		$request = new users();
		$returnData = $request->getPopularProducts();
	break;
}
echo json_encode($returnData)
?>