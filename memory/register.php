<?php
require('db_login.php');
class user {
	function register($phone = null, $facebook = null) {
		global $conn;
		$today = date("Y/m/d");

		$sql = "SELECT * FROM records WHERE create_date <= \"$today\"";
		if ($phone !== null)  $sql .= " AND phone_number = \"$phone\"";
		if ($facebook !== null) $sql .= " OR facebook_id = \"$facebook\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		if ($row) echo json_encode("repeated phone number or facebook id");

		$rid = bin2hex((random_bytes(8)));
		if ($phone !== null) {
			$sql = "INSERT INTO records (rid, phone_number, create_date) VALUES (?, ?, ?)";
			$rid .= $phone;
			$stmt = $conn->prepare($sql);
			$stmt->execute([$rid, $phone, $today]);
			echo json_decode("Phone Register Succeed!");
		} else if ($facebook !== null) {
			$sql = "INSERT INTO records (rid, facebook_id, create_date) VALUES (?, ?, ?)";
			$rid = $facebook;
			$stmt = $conn->prepare($sql);
			$stmt->execute([$rid, $facebook, $today]);
			echo json_decode("Facebook Register Succeed!");
		}
	}

	function updateGameRecord($game, $rid, $record) {
		global $conn;
		$sql = "SELECT * FROM $game WHERE rid = \"$rid\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$updated = false;
		if ($row) {
			$sql = "UPDATE $game set score=\"$record\" WHERE rid =\"$rid\"";
			$stmt = $conn->prepare($sql);
			$stmt->execute();
			$updated = true;
		} else {
			$sql = "INSERT $game (rid, score) VALUES (?, ?)";
			$stmt = $conn->prepare($sql);
			$stmt->execute([$rid, $record]);
			$updated = true;
		}
		if ($updated) echo json_encode($updated);
	}
	function queryGameRecord() {
		global $conn;
		$sql = "SELECT * FROM memory";
		$sql_p = "SELECT * FROM puzzle";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$stmt_p = $conn->prepare($sql_p);
		$stmt_p->execute();
		$row_p = $stmt_p->fetchAll();
		$info = [
			"memory" => [],
			"puzzle" => [],
		];
		if ($row) {
			foreach ($row as $key => $value) {
				$info["memory"] += [
					$key => $value
				];
			}
		}
		if ($row_p) {
			foreach ($row_p as $key => $value) {
				$info["puzzle"] += [
					$key => $value
				];
			}
		}
		//var_dump($info);
		echo json_encode($info);
	}
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$json = file_get_contents('php://input');
	$data = json_decode($json);
	$request = new user();
	if ($data->request === 'updateGameRecord')
		$request->updateGameRecord($data->game, $data->rid, $data->record);
	else if ($data->request === 'register')
		$request->register($data->rid, $data->facebookId);
	else if ($data->request === 'queryGameRecord')
		$request->queryGameRecord();
}
/*
$request = new user();
$request->queryGameRecord('asdf');*/
?>