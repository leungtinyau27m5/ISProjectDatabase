<?php
require('db_login.php');
class user {
	function register($phone = null, $username, $image) {
		global $conn;
		$today = date("Y/m/d");
		$rid = bin2hex((random_bytes(8)));
		if ($phone !== null) {
			$target_dir = __DIR__ . '/avatar/';
			$pureDir = bin2hex((random_bytes(1))) . basename($_FILES['image']['name']);
			$fileName = $target_dir . $pureDir;
			if (move_uploaded_file(($_FILES['image']['tmp_name']), $fileName)) {
				$sql = "INSERT INTO records (rid, username, phone_number, create_date, imageUri) VALUES (?, ?, ?, ?, ?)";
				$stmt = $conn->prepare($sql);
				$stmt->execute([$rid, $username, $phone, $today, $pureDir]);
				echo json_encode($rid);
			}
		}
	}
	function updateMyPersonalData($rid, $username=null, $image=null) {
		global $conn;
		$today = date("Y/m/d");
		$sql = '';
		$updated = false;
		$returnTest = ["username" => $username, "image" => $image];
		$returnText = '';
		if ($image["name"] !== null) {
			$sql = "SELECT * FROM records WHERE rid=\"$rid\"";
			$stmt = $conn->prepare($sql);
			$stmt->execute();
			$row = $stmt->fetch();
			if ($row) {
				$target = __DIR__ . '/avatar/' . $row["imageUri"];
				if (file_exists($target)) {
					unlink($target);
				}
			}
			$target_dir = __DIR__ . '/avatar/';
			$pureDir = bin2hex((random_bytes(1))) . basename($_FILES['image']['name']);
			$fileName = $target_dir . $pureDir;
			move_uploaded_file(($_FILES['image']['tmp_name']), $fileName);
			if ($username !== null && $username !== '') {
				$sql = "UPDATE records 
						set username = \"$username\", 
						imageUri = \"$pureDir\"
						WHERE rid=\"$rid\"";
						$updated = true;
				$returnText = 'image and username updated';
			} else {
				$sql = "UPDATE records
						set imageUri=\"$pureDir\"
						WHERE rid=\"$rid\"";
						$updated = true;
				$returnText = 'image updated';
			}
		} else if ($username !== null && $username !== ''){
			$sql = "UPDATE records
					set username =\"$username\"
					WHERE rid=\"$rid\"";
					$updated = true;
					$returnText = 'username updated';
		}
		if ($updated) {
			$stmt = $conn->prepare($sql);
			$stmt->execute();
			//echo json_encode($updated);
		}
		if ($updated) {
			echo json_encode($returnText);
		} else {
			echo json_encode('it is not updated!!');
		}
	}
	function getMyToken($phone) {
		global $conn;
		$sql = "SELECT rid, username from records WHERE phone_number =\"$phone\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$info = [];
		if ($row) {
			$info = [
				"rid" => substr($row["rid"], 0, 16),
				"username" => $row["username"]
			];
		} else {
			$info = false;
		}
		echo json_encode($info);
	}
	function updateGameRecord($game, $level=null, $rid, $record) {
		global $conn;
		$sql = "SELECT * FROM $game WHERE rid = \"$rid\"";
		if ($level !== null) $sql .= " AND level=\"$level\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$updated = false;
		if ($row) {
			$needUpdate = true;
			if ($game == 'memory') {
				if ($record <= $row["score"]) $needUpdate = false;
			} else if ($game == 'puzzle'){
				if ($record >= $row["score"]) $needUpdate = false;
			}
			if ($needUpdate) {
				if ($level == null) {
					$sql = "UPDATE $game set score=\"$record\" WHERE rid =\"$rid\"";
					$stmt = $conn->prepare($sql);
					$stmt->execute();
					$updated = true;
				} else {
					$sql = "UPDATE $game set score=\"$record\" WHERE rid=\"$rid\" AND level=\"$level\"" ;
					$stmt = $conn->prepare($sql);
					$stmt->execute();
					$updated = true;
				}
			}
		} else {
			if ($level == null) {
				$sql = "INSERT $game (rid, score) VALUES (?, ?)";
				$stmt = $conn->prepare($sql);
				$stmt->execute([$rid, $record]);
				$updated = true;
			} else {
				$sql = "INSERT $game (rid, score, level) VALUES (?, ?, ?)";
				$stmt = $conn->prepare($sql);
				$stmt->execute([$rid, $record, $level]);
				$updated = true;
			}
		}
		echo json_encode($updated);
	}
	function queryGameRecord($rid, $contacts = null) {
		global $conn;
		$sql = "SELECT r.rid, m.score, r.username, r.phone_number, r.imageUri
				FROM memory m, records r 
				WHERE r.rid = m.rid ORDER BY m.score DESC";
		$sql_p_e = "SELECT r.rid, p.level, p.score, r.username, r.phone_number, r.imageUri
					FROM puzzle p, records r WHERE level='easy' AND r.rid = p.rid
					ORDER BY p.score";
		$sql_p_n = "SELECT r.rid, p.level, p.score, r.username, r.phone_number, r.imageUri
					FROM puzzle p, records r WHERE level='normal' AND r.rid = p.rid
					ORDER BY p.score";
		$sql_p_h = "SELECT r.rid, p.level, p.score, r.username, r.phone_number, r.imageUri 
					FROM puzzle p, records r WHERE level='hard' AND r.rid = p.rid
					ORDER BY p.score";
		$info = [
			"global" => [
				"memory" => [

				],
				"puzzle" => [
					"easy" => [],
					"normal" => [],
					"hard" => [],
				]
			],
			"friend" => [
				"memory" => [
				],
				"puzzle" => [
					"easy" => [],
					"normal" => [],
					"hard" => [],
				]
			]/*
			"me" => [
				"memory" => [
					"th" => [
						"friend" => '',
						"global" => ''
					]
				],
				"puzzle" => [
					"easy" => [
						"th" => [
							"friend" => '',
							"global" => ''
						]
					],
					"normal" => [
						"th" => [
							"friend" => '',
							"global" => ''
						]
					],
					"hard" => [
						"th" => [
							"friend" => '',
							"global" => ''
						]
					],
				]
			]*/
		];
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$th = 0;
		if ($row) {
			foreach ($row as $key => $value) {
				$th += 1;
				$info["global"]["memory"] += [
					$key => $value
				];
			}
			if ($contacts !== null && sizeof($contacts) > 2) {
				$number = substr($value["phone_number"], 1, strlen($value["phone_number"]));
				if(in_array($number, $contacts)) {
						//echo 'hello';
					$info["friend"]["memory"] += [
						$key => $value,
					];
				}
			}
			if ($value["rid"] == $rid) {
				$info["friend"]["memory"] += [
					$key => $value,
				];/*
				$info["me"]["memory"]["th"]["friend"] = $th;
				$info["me"]["memory"] = [
					$key => $value,
				];
				$info["me"]["memory"]["th"]["global"] = $th;*/
			}
		}
		$stmt_p_e = $conn->prepare($sql_p_e);
		$stmt_p_e->execute();
		$row_p_e = $stmt_p_e->fetchAll();
		$th = 0;
		if ($row_p_e) {
			foreach ($row_p_e as $key => $value) {
				$th += 1;
				$info["global"]["puzzle"]["easy"] += [
					$key => $value
				];
				//1echo substr($value["phone_number"], 1, strlen($value["phone_number"]));
				if ($contacts !== null && sizeof($contacts) > 2) {
					$number = substr($value["phone_number"], 1, strlen($value["phone_number"]));
					if(in_array($number, $contacts)) {
						//echo 'hello';
						$info["friend"]["puzzle"]["easy"] += [
							$key => $value,
						];
					}
				}
				if ($value["rid"] == $rid) {
					$info["friend"]["puzzle"]["easy"] += [
						$key => $value,
					];
					/*
					$info["me"]["puzzle"]["easy"]["th"]["friend"] = $th;
					$info["me"]["puzzle"]["easy"] = [
						$key => $value,
					];
					$info["me"]["puzzle"]["easy"]["th"]["global"] = $th;*/
				}
			}
		}
		$stmt_p_n = $conn->prepare($sql_p_n);
		$stmt_p_n->execute();
		$row_p_n = $stmt_p_n->fetchAll();
		$th = 0;
		if ($row_p_n) {
			foreach ($row_p_n as $key => $value) {
				$th += 1;
				$info["global"]["puzzle"]["normal"] += [
					$key => $value
				];
				//1echo substr($value["phone_number"], 1, strlen($value["phone_number"]));
				if ($contacts !== null && sizeof($contacts) > 2) {
					$number = substr($value["phone_number"], 1, strlen($value["phone_number"]));
					if(in_array($number, $contacts)) {
						//echo 'hello';
						$info["friend"]["puzzle"]["normal"] += [
							$key => $value
						];
					}
				}
				if ($value["rid"] == $rid) {
					$info["friend"]["puzzle"]["normal"] += [
						$key => $value,
					];/*
					$info["me"]["puzzle"]["normal"]["th"]["friend"] = $th;
					$info["me"]["puzzle"]["normal"] = [
						$key => $value,
					];
					$info["me"]["puzzle"]["normal"]["th"]["global"] = $th;*/
				}
			}
		}
		$stmt_p_h = $conn->prepare($sql_p_h);
		$stmt_p_h->execute();
		$row_p_h = $stmt_p_h->fetchAll();
		$th = 0;
		if ($row_p_h) {
			foreach ($row_p_h as $key => $value) {
				$th += 1;
				$info["global"]["puzzle"]["hard"] += [
					$key => $value
				];
				//1echo substr($value["phone_number"], 1, strlen($value["phone_number"]));
				if ($contacts !== null && sizeof($contacts) > 2) {
					$number = substr($value["phone_number"], 1, strlen($value["phone_number"]));
					if(in_array($number, $contacts)) {
						//echo 'hello';
						$info["friend"]["puzzle"]["hard"] += [
							$key => $value
						];
					}
				}
				if ($value["rid"] == $rid) {
					$info["friend"]["puzzle"]["hard"] += [
						$key => $value,
					];/*
					$info["me"]["puzzle"]["hard"]["th"]["friend"] = $th;
					$info["me"]["puzzle"]["hard"] = [
						$key => $value,
					];
					$info["me"]["puzzle"]["hard"]["th"]["global"] = $th;*/
				}
			}
		}
		echo json_encode($info);
	}
	/*
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
	}*/
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	if ($_POST) {
		$request = new user();
		if ($_POST['request'] === 'register')
			$request->register($_POST['phone'], $_POST['username'], $_FILES['image']);
		else if ($_POST['request'] === 'updateMyPersonalData') {
			$image = null;
			$username = null;
			if (isset($_FILES['image']))
				$image = $_FILES['image'];
			if (isset($_POST['username']))
				$username = $_POST['username'];
			$request->updateMyPersonalData($_POST['rid'], $username, $image);
		}
	} else {
		$json = file_get_contents('php://input');
		$data = json_decode($json);
		$request = new user();
		if ($data->request === 'updateGameRecord')
			$request->updateGameRecord($data->game, $data->level, $data->rid, $data->record);
		else if ($data->request === 'register')
			$request->register($data->phone, $data->username, $data->imageUri);
		else if ($data->request === 'queryGameRecord')
			$request->queryGameRecord($data->rid, $data->contacts);
		else if ($data->request === 'getMyToken')
			$request->getMyToken($data->phone);
	}
}

//$request = new user();
//$contacts = ['64817704', '55555555', '15555215554'];
//$request->queryGameRecord('856fc066de819529', $contacts);
//$request->getMyToken('+15555215554');
//$request->register('+15555215554', 'hello my dear');
//$request->updateGameRecord('puzzle', 'normal', '66472eddeb964470', '2');
//$request->updateMyPersonalData('66472eddeb964470', 'my new name', null);
?>