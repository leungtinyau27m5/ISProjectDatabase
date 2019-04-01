<?php
class customers extends users{
	protected $_cid;
	protected $_myInfo;
	public function login() {
		global $conn;
		$sql = "SELECT * FROM customers
				WHERE username=\"$this->_username\"
				AND password=\"$this->_password\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$info = [];
		if ($row) {
			$info = [
				"cid" => $row["cid"],
				"username" => $row["username"],
				"gender" => $row["gender"],
				"address_id" => $row["address_id"],
				"phone" => $row["phone_num"],
				"birthday" => $row["birthday"]
			];
		}
		return $info;
	}
	public function getMyAddresses($addressListId) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * FROM addresses WHERE address_id = \"$addressListId\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetch();
		$info = null;
		foreach ($row as $key => $value) {
			$info = [
				$key => $value
			];
		}
		return $info;
	}
	public function getOrders(
		$cid,
		$orderId = null,
		$check_out_date_min = null,
		$check_out_date_max = null
	) {
		global $conn;
		$isAuth = parent::CheckAuthToken();
		if (!$isAuth) return;

		$sql = "SELECT * 
		FROM orders o, order_detail od, services s, products p, product_orders po, service_order so,
		appointments a, service_type st, product_type pt
		WHERE o.cid = \"$cid\"
		AND o.order_id = od.order_id
		AND s.sid = so.sid
		AND p.pid = po.pid
		AND p.p_type_id = pt.p_type_id
		AND s.s_type_id = st.s_type_id
		AND a.appt_id = so.appt_id";
		
		if ($check_out_date_min !== null) $sql .= " AND o.check_out_date >= \"$check_out_date_min\"";
		if ($check_out_date_max !== null) $sql .= " AND o.check_out_date <= \"$check_out_date_max\"";
		if ($orderId !== null) $sql .= " AND o.order_id = \"$orderId\"";
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$row = $stmt->fetchAll();
		$info = [];
		foreach ($row as $key => $value) {
			$info += [
				$key => $value
			];
		};
		return $info;
	}
	public function addToCart() {

	}
	public function makeAppointment() {

	}
}
?>