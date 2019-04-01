<?php
//require('../Auth_User.php');
class shopKeeper extends users{
	public function login($mc, $isremebered) {
		global $conn;
		$sql = "SELECT * FROM labour, shopes, shop_labour 
				WHERE shopes.merchant_code = \"$mc\" 
				AND labour.username=\"$this->_username\" 
				AND labour.password=\"$this->_password\"
				AND shop_labour.merchant_code = shopes.merchant_code
				AND shop_labour.labour_list_id = labour.labour_list_id";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$info = [];
		if ($row) {
			$info = [
				"merchant_code" => $row["merchant_code"],
				"shop_name" => $row["shop_name"],
				"labour_id" => $row["labour_id"],
				"position" => $row["position"],
			];
		} else {
			$info = null;
		}
		return $info;
	}
	public function getProductList($mc) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * FROM products, product_type 
				WHERE merchant_code = \"$mc\"
				AND products.p_type_id = product_type.p_type_id";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$info = [];
		if ($row) {
			foreach ($row as $key => $value) {
				$info += [
					$key => $value
				];
			};
		}
		return $info;
	}
	public function getServiceList($mc) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * FROM services, service_type 
				WHERE merchant_code =\"$mc\"
				AND services.s_type_id = service_type.s_type_id";
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
	public function filterServiceOrderList(
		$cid = null,
		$orderId = null,
		$checkoutDate = null,
		$serviceId = null,
		$appt_id = null,
		$appointment_time_min = null,
		$appointment_time_max = null,
		$serviceType = null
	) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * 
				FROM customers c, orders o, order_detail od, service_order so, services s, appointments a, service_type st
				WHERE c.cid = o.cid
				AND o.order_id = od.order_id
				AND od.item_id = s.sid
				AND od.order_id = so.order_id
				AND so.sid = s.sid
				AND so.appt_id = a.appt_id
				AND st.s_type_id = s.s_type_id
				AND s.merchant_code = \"$mc\"";
		if ($cid !== null) $sql .= " AND c.cid = \"$cid\"";
		if ($orderId !== null) $sql .= " AND o.order_id = \"$orderId\"";
		if ($checkoutDate !== null) $sql .= " AND o.check_out_date = \"$checkoutDate\"";
		if ($serviceId !== null) $sql .= " AND s.sid = \"$serviceId\"";
		if ($appt_id !== null) $sql .= " AND a.appt_id = \"$appt_id\"";
		if ($appointment_time_min !== null) $sql .= " AND a.appointment_time >= \"$appointment_time_min\"";
		if ($appointment_time_max !== null) $sql .= " AND a.appintments_time <= \"$appointment_time_max	\"";
		if ($serviceType !== null) $sql .= " AND s.s_type_id = \"$serviceType\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$info = [];
		if ($row) {
			foreach ($row as $key => $value) {
				$info += [
					"customers_id" => $row['cid'],
					"customer_username" => $row['username'],
					"order_id" => $row["order_id"],
					"service_id" => $row["sid"],
					"s_name" => $row["s_name"],
					"description" => $row["description"],
					"deal_price" => $row["deal_price"],
					"appointment" => [
						"appt_id" => $row["appt_id"],
						"appt_time" => $row["appointment_time"],
						"appt_address" => $row["appointment_address"]
					]
				];
			}
		}
		return $info;
	}
	public function filterProductOrderList(
		$cid = null, 
		$orderId = null, 
		$checkoutDateMin = null,
		$checkoutDateMax = null,
		$productId = null
	) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * FROM customers, orders, order_detail, product_orders, products
				WHERE customers.cid = orders.cid
				AND orders.order_id = order_detail.order_id
				AND order_detail.is_service = '0'
				AND order_detail.item_id = product_orders.pid
				AND product_orders.order_id = order_detail.order_id
				AND product_orders.pid = products.pid
				AND products.merchant_code = \"$mc\"";
		if ($cid !== null) $sql .= " AND customers.cid = \"$cid\"";
		if ($orderId !== null) $sql .= " AND orders.order_id = \"$orderId\"";
		if ($checkoutDateMin !== null) $sql .= " AND orders.check_out_date >= \"$checkoutDateMin\"";
		if ($checkoutDateMax !== null) $sql .= " AND orders.check_out_date <= \"$checkoutDateMax\"";
		if ($productId !== null) $sql .= " AND products.pid = \"$productId\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();

		$info = [];
		if ($row) {
			foreach ($row as $value) {
				$q = $row["quantity"];
				$p = $row["price"];
				$subtotal = $q * $p;
				$info += [
					"customers_id" => $row['cid'],
					"customer_username" => $row['username'],
					"order_id" => $row["order_id"],
					"product_id" => $row["pid"],
					"product_name" => $row["product_name"],
					"product_price" => $row["price"],
					"product_image" => $row["image_uri"],
					"quantity" => $row["quantity"],
					"subtotal" => $subtotal 
				];
			}
		}
		return $info;
	}
	public function labourList() {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * FROM shop_labour, labour, labour_position
				WHERE shop_labour.merchant_code = \"$mc\"
				AND shop_labour.labour_list_id = labour.labour_list_id
				AND labour.position = labour_position.position";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$info = [];
		if ($row) {
			foreach ($row as $value) {
				$info += [
					"labour_id" => $row["labour_id"],
					"position" => $row["position"],
					"username" => $row["username"],
					"description" => $row["description"],
				];
			};
		}
		return $info;
	}
}

//$shopping = new shopKeeper('test01', 'test0789');
//$shopping->login('shop01');

//var_dump($shopping->getProductList());
//var_dump($shopping->getServiceList());
//var_dump($shopping->filterServiceOrderList('test01', null, null, null, null, null, null, null));
//var_dump($shopping->filterProductOrderList(null, 'testOrder01', null, null));
//var_dump($shopping->labourList());

//var_dump($shopping->labourList());
?>