<?php
require('loginDB.php');
class users {
	protected $_username;
	protected $_password;

	public function UpdateAuthToken($id, $userType, $isRemembered) {
		global $conn;
		$length = 64;

		$targetTable = $userType == "customer" ? "customers" : "labour";
		$idName = $userType == "customer" ? "cid" : "labour_id";
		$sql = "SELECT $idName, token FROM $targetTable";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$token = "";
		
		do {
			$token = bin2hex(random_bytes($length));
			$isOK = false;
			foreach ($row as $key => $value) {
				if ($row["token"] === $token) {
					$isOK = true;
				}
			}
		} while ($isOK === true);
		$expireDate;
		if ($isRemembered) {
			$expireDate = date('Y/m/d', strtotime("+30 days"));
		} else {
			$expireDate = date('Y/m/d');
		}
		$sql = "UPDATE $targetTable
				SET token = \"$token\",
				expire_date = \"$expireDate\"
				WHERE $idName = \"$id\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
	}

	public function CheckAuthToken($token, $userType) {
		global $conn;

		$targetTable = $userType == "customer" ? "customers" : "labour";
		$idName = $userType == "customer" ? "customers" : "labour";
		$sql = "SELECT $idName, token, expire_date FROM $targetTable";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$today = date('Y/m/d');
		$isAuth = false;
		if ($row) {
			if ($row[0]["token"] === $token) {
				if ($row[0]["expire_date"] <= $today) {
					$isAuth	 = true;
				}
			}
		}
		return $isAuth;
	}

	public function getPopularProducts() {
		global $conn;
		$today = date("Y-m-d");
		$past = date("Y-m-d", strtotime($today. ' - 30 days'));
		$sql = "SELECT p.merchant_code, p.pid, p.product_name, p.p_type_id, p.price, p.image_uri, sum(po.quantity) as 'subtotal'
				FROM products p, product_orders po, order_detail od 
				WHERE p.pid = po.pid
				AND od.is_service = 0
				AND od.item_id = p.pid
				AND po.order_id = od.order_id
				AND proceeded_date <= \"$today\"
				AND proceeded_date >= \"$past\"
				Group By p.pid
				Order By sum(po.quantity) DESC
				LIMIT 7";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$info = [];
		if ($row) {
			foreach ($row as $key => $value) {
				$info += [
					$key => $value
				];
			}
		}
		return $info;
	}

}
?>