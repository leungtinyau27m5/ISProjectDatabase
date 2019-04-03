-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- 主機: 127.0.0.1
-- 產生時間： 2019 年 04 月 03 日 17:26
-- 伺服器版本: 10.1.37-MariaDB
-- PHP 版本： 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `shop_around_you`
--

-- --------------------------------------------------------

--
-- 資料表結構 `addresses`
--

CREATE TABLE `addresses` (
  `address_id` varchar(20) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `address3` varchar(255) NOT NULL,
  `default_address` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `appointments`
--

CREATE TABLE `appointments` (
  `merchant_code` varchar(20) NOT NULL,
  `appt_id` varchar(20) NOT NULL,
  `appointment_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `appointment_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `appointments`
--

INSERT INTO `appointments` (`merchant_code`, `appt_id`, `appointment_time`, `appointment_address`) VALUES
('shop01', 'apptTest01', '2019-03-22 06:02:20', '');

-- --------------------------------------------------------

--
-- 資料表結構 `certificates`
--

CREATE TABLE `certificates` (
  `merchant_code` varchar(20) NOT NULL,
  `cert_type_id` varchar(20) NOT NULL,
  `image_uri` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `cert_type`
--

CREATE TABLE `cert_type` (
  `cert_type_id` varchar(20) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `customers`
--

CREATE TABLE `customers` (
  `cid` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `gender` varchar(2) NOT NULL,
  `address_id` varchar(20) NOT NULL,
  `phone_num` varchar(8) NOT NULL,
  `birthday` date NOT NULL,
  `token` varchar(64) NOT NULL,
  `expire_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `customers`
--

INSERT INTO `customers` (`cid`, `username`, `password`, `gender`, `address_id`, `phone_num`, `birthday`, `token`, `expire_date`) VALUES
('test01', 'admin01', 'test0789', 'M', '', '', '2019-03-22', '08966f32774cbee22fae2de984049a32ee52d281baa009d0a4039d64c7a0d74c', '2019-04-23');

-- --------------------------------------------------------

--
-- 資料表結構 `history_detail`
--

CREATE TABLE `history_detail` (
  `history_id` varchar(20) NOT NULL,
  `cid` varchar(20) NOT NULL,
  `feedback` text NOT NULL,
  `rating` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `job_history`
--

CREATE TABLE `job_history` (
  `merchant_code` varchar(20) NOT NULL,
  `history_id` varchar(20) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `labour`
--

CREATE TABLE `labour` (
  `labour_list_id` varchar(20) NOT NULL,
  `labour_id` varchar(20) NOT NULL,
  `position` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expire_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `labour`
--

INSERT INTO `labour` (`labour_list_id`, `labour_id`, `position`, `username`, `password`, `token`, `expire_date`) VALUES
('shopL01', 'lab01', 'Admin', 'test01', 'test0789', '', '0000-00-00');

-- --------------------------------------------------------

--
-- 資料表結構 `labour_position`
--

CREATE TABLE `labour_position` (
  `position` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `labour_position`
--

INSERT INTO `labour_position` (`position`, `description`) VALUES
('Admin', 'Web Admin Test');

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `order_id` varchar(20) NOT NULL,
  `cid` varchar(20) NOT NULL,
  `check_out_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `orders`
--

INSERT INTO `orders` (`order_id`, `cid`, `check_out_date`) VALUES
('testOrder01', 'test01', '2019-03-22'),
('testOrder02', 'test01', '2019-03-22');

-- --------------------------------------------------------

--
-- 資料表結構 `order_detail`
--

CREATE TABLE `order_detail` (
  `order_id` varchar(20) NOT NULL,
  `is_service` bit(1) NOT NULL,
  `item_id` varchar(20) NOT NULL,
  `proceeded_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `order_detail`
--

INSERT INTO `order_detail` (`order_id`, `is_service`, `item_id`, `proceeded_date`) VALUES
('testOrder01', b'0', 'ptu01', '2019-03-22'),
('testOrder01', b'1', 'testService01', '2019-03-22'),
('testOrder02', b'0', 'ptu01', '2019-03-29'),
('testOrder02', b'0', 'ptu02', '2019-03-26');

-- --------------------------------------------------------

--
-- 資料表結構 `products`
--

CREATE TABLE `products` (
  `merchant_code` varchar(20) NOT NULL,
  `pid` varchar(20) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `p_type_id` varchar(20) NOT NULL,
  `image_uri` text NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `products`
--

INSERT INTO `products` (`merchant_code`, `pid`, `product_name`, `p_type_id`, `image_uri`, `description`, `price`) VALUES
('shop01', 'ptu01', 'ptu01', 'pomg01', 'products/ptu01/ptu01.jpg', '', '20.50'),
('shop01', 'ptu02', 'testproduct2', 'pomg01', 'products/ptu02/ptu02.jpg', '', '602.01');

-- --------------------------------------------------------

--
-- 資料表結構 `product_orders`
--

CREATE TABLE `product_orders` (
  `order_id` varchar(20) NOT NULL,
  `pid` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `product_orders`
--

INSERT INTO `product_orders` (`order_id`, `pid`, `quantity`) VALUES
('testOrder01', 'ptu01', 10),
('testOrder02', 'ptu01', 22),
('testOrder02', 'ptu02', 12);

-- --------------------------------------------------------

--
-- 資料表結構 `product_rate`
--

CREATE TABLE `product_rate` (
  `pid` varchar(20) NOT NULL,
  `cid` varchar(20) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `product_type`
--

CREATE TABLE `product_type` (
  `p_type_id` varchar(20) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `product_type`
--

INSERT INTO `product_type` (`p_type_id`, `description`) VALUES
('pomg01', '');

-- --------------------------------------------------------

--
-- 資料表結構 `services`
--

CREATE TABLE `services` (
  `merchant_code` varchar(20) NOT NULL,
  `s_type_id` varchar(20) NOT NULL,
  `sid` varchar(20) NOT NULL,
  `price_min` decimal(10,0) NOT NULL,
  `price_max` decimal(10,0) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `services`
--

INSERT INTO `services` (`merchant_code`, `s_type_id`, `sid`, `price_min`, `price_max`, `description`) VALUES
('shop01', 'somg01', 'testService01', '200', '900', '');

-- --------------------------------------------------------

--
-- 資料表結構 `service_order`
--

CREATE TABLE `service_order` (
  `order_id` varchar(20) NOT NULL,
  `sid` varchar(20) NOT NULL,
  `appt_id` varchar(20) NOT NULL,
  `deal_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `service_order`
--

INSERT INTO `service_order` (`order_id`, `sid`, `appt_id`, `deal_price`) VALUES
('testOrder01', 'testService01', 'apptTest01', '365.20');

-- --------------------------------------------------------

--
-- 資料表結構 `service_type`
--

CREATE TABLE `service_type` (
  `s_type_id` varchar(20) NOT NULL,
  `s_name` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `service_type`
--

INSERT INTO `service_type` (`s_type_id`, `s_name`, `description`) VALUES
('somg01', 'testing', '');

-- --------------------------------------------------------

--
-- 資料表結構 `shopes`
--

CREATE TABLE `shopes` (
  `merchant_code` varchar(20) NOT NULL,
  `shop_name` varchar(50) NOT NULL,
  `address_id` varchar(20) NOT NULL,
  `certificate_list_id` varchar(20) NOT NULL,
  `history_list_id` varchar(20) NOT NULL,
  `rating` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `shopes`
--

INSERT INTO `shopes` (`merchant_code`, `shop_name`, `address_id`, `certificate_list_id`, `history_list_id`, `rating`) VALUES
('shop01', 'hello world', '', '', '', '5.0');

-- --------------------------------------------------------

--
-- 資料表結構 `shop_labour`
--

CREATE TABLE `shop_labour` (
  `merchant_code` varchar(20) NOT NULL,
  `labour_list_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `shop_labour`
--

INSERT INTO `shop_labour` (`merchant_code`, `labour_list_id`) VALUES
('shop01', 'shopL01');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cid`,`username`),
  ADD UNIQUE KEY `address_id` (`address_id`);

--
-- 資料表索引 `labour`
--
ALTER TABLE `labour`
  ADD PRIMARY KEY (`labour_list_id`,`labour_id`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- 資料表索引 `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`order_id`,`item_id`);

--
-- 資料表索引 `products`
--
ALTER TABLE `products`
  ADD UNIQUE KEY `pid` (`pid`);

--
-- 資料表索引 `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`order_id`,`pid`);

--
-- 資料表索引 `product_rate`
--
ALTER TABLE `product_rate`
  ADD PRIMARY KEY (`pid`,`cid`);

--
-- 資料表索引 `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`p_type_id`);

--
-- 資料表索引 `service_order`
--
ALTER TABLE `service_order`
  ADD PRIMARY KEY (`order_id`,`sid`,`appt_id`);

--
-- 資料表索引 `shop_labour`
--
ALTER TABLE `shop_labour`
  ADD PRIMARY KEY (`merchant_code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
