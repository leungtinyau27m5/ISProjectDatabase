<?php
require('../loginDB.php');
global $conn;
if (isset($_POST['return-text'])) {
	$content = json_decode($_POST["return-text"]);
	$address = [
		"street_address" => '',
		"route" => '',
		"intersection" => '',
		"political" => '',
		"country" => '',
		"administrative_area_level_1" => '',
		"administrative_area_level_2" => '',
		"administrative_area_level_3" => '',
		"administrative_area_level_4" => '',
		"administrative_area_level_5" => '',
		"colloquial_area" => '',
		"locality" => '',
		"sublocality" => '',
		"neighborhood" => '',
		"premise" => '',
		"subpremise" => '',
		"natural_feature" => '',
		"longitude" => '',
		"latitude" => '',
		"formatted_address" => ''
	];
	$address = [];
	$addressId = bin2hex(random_bytes(8));
	$address += ["address_id" => $addressId];
	foreach ($content[0]->address_components as $key => $value) {
		$address[$value->types[0]] = $value->short_name;
	}
	$address += [
		"formatted_address" => $content[0]->formatted_address,
		"longitude" => $content[0]->geometry->location->lng,
		"latitude" => $content[0]->geometry->location->lat
	];
	$sql = "INSERT INTO address_detail_temp (";
	foreach ($address as $key => $value) {
		if ($value !== '') {
			$sql .= " " . $key . ",";
		}
	}
	$sql = substr($sql, 0, strlen($sql) - 1);
	$sql .= ") VALUES (";
	for ($i=0; $i < sizeof($address) ; $i++) { 
		$sql .= " ?,";
	}
	$sql = substr($sql, 0, strlen($sql) - 1);
	$sql .= ")";
	$stmt = $conn->prepare($sql);
	$stmt->execute(array_values($address));
	$sql = "INSERT INTO addresses (address_id) VALUES(?)";
	$stmt = $conn->prepare($sql);
	$stmt->execute([$addressId]);
}
?>