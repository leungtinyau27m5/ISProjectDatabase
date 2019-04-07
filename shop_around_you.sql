-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- 主機: 127.0.0.1
-- 產生時間： 2019 年 04 月 07 日 16:30
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
  `userId` varchar(50) NOT NULL,
  `is_shop` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `addresses`
--

INSERT INTO `addresses` (`address_id`, `userId`, `is_shop`) VALUES
('03e24197992b1629', '', b'1'),
('07491d1bdc11e691', '', b'1'),
('0d3384e9800d09cd', '', b'1'),
('25c98d7df4d0d744', '', b'0'),
('2c3b191eb48a584b', '', b'0'),
('2e65713e3f046114', '', b'1'),
('3716eb9b7e34bff7', '', b'1'),
('40105cc52d3b41c7', '', b'1'),
('51dcc1d2984ec751', '', b'1'),
('53abfee13c885d0d', '', b'0'),
('58ca6d6594531422', '', b'1'),
('625239c967b2c333', '', b'0'),
('6c0debc84e4b86c7', '', b'0'),
('6f5c3fcd88187e60', '', b'0'),
('7880090fa091f1d6', '', b'0'),
('80bd04bce9f8c975', '', b'1'),
('8650cd7c9c265235', '', b'1'),
('964f91598b13398d', '', b'1'),
('980575c1bb48bd34', '', b'1'),
('b1560d733311f1ab', '', b'1'),
('b54d926f8695a5b2', '', b'1'),
('bd33d3c4a7f4bada', '', b'1'),
('e22ff14eb77b0d90', '', b'1'),
('e56d2d7bb9e791c8', '', b'1'),
('e7cc868397bad57f', '', b'1');

-- --------------------------------------------------------

--
-- 資料表結構 `address_detail`
--

CREATE TABLE `address_detail` (
  `address_id` varchar(20) NOT NULL,
  `region` text NOT NULL,
  `street` text NOT NULL,
  `district` text NOT NULL,
  `block` text NOT NULL,
  `floor` text NOT NULL,
  `room` text NOT NULL,
  `formatted_address` text NOT NULL,
  `longtitude` varchar(50) NOT NULL,
  `latitude` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `address_detail`
--

INSERT INTO `address_detail` (`address_id`, `region`, `street`, `district`, `block`, `floor`, `room`, `formatted_address`, `longtitude`, `latitude`) VALUES
('address_AAA', '大埔', '安邦路8-10號', '大埔超級城B區', '', '2樓', '', '大埔安邦路8-10號大埔超級城B區2樓', '22.4515952', '114.17013180000004'),
('address_AAB', '大埔', 'Ting Kok Rd no.10', '大元邨', '泰寧樓', '', '', '大埔Ting Kok Rd no.10大元邨泰寧樓', '114.16776230000005', '22.4552859'),
('address_AAC', '大埔', '運頭角里', '大埔警署', '', '', '', '大埔運頭角里舊大埔警署', '114.16996849999998', '22.4465874');

-- --------------------------------------------------------

--
-- 資料表結構 `address_detail_temp`
--

CREATE TABLE `address_detail_temp` (
  `address_id` varchar(50) NOT NULL,
  `street_address` text NOT NULL,
  `street_number` text NOT NULL,
  `route` text NOT NULL,
  `intersection` text NOT NULL,
  `political` text NOT NULL,
  `country` text NOT NULL,
  `administrative_area_level_1` text NOT NULL,
  `administrative_area_level_2` text NOT NULL,
  `administrative_area_level_3` text NOT NULL,
  `administrative_area_level_4` text NOT NULL,
  `administrative_area_level_5` text NOT NULL,
  `colloquial_area` text NOT NULL,
  `locality` text NOT NULL,
  `sublocality` text NOT NULL,
  `neighborhood` text NOT NULL,
  `premise` text NOT NULL,
  `subpremise` text NOT NULL,
  `natural_feature` text NOT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `formatted_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `address_detail_temp`
--

INSERT INTO `address_detail_temp` (`address_id`, `street_address`, `street_number`, `route`, `intersection`, `political`, `country`, `administrative_area_level_1`, `administrative_area_level_2`, `administrative_area_level_3`, `administrative_area_level_4`, `administrative_area_level_5`, `colloquial_area`, `locality`, `sublocality`, `neighborhood`, `premise`, `subpremise`, `natural_feature`, `longitude`, `latitude`, `formatted_address`) VALUES
('03e24197992b1629', '', '', '教堂路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬料水', '', '', '', 114.207, 22.4164, '香港馬料水教堂路'),
('07491d1bdc11e691', '', '4211', '大埔公路大埔滘段', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔滘', '', '', '', 114.184, 22.4381, '香港大埔滘大埔公路大埔滘段4211號'),
('0d3384e9800d09cd', '', '', '雅運路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔', '港鐵大埔墟站', '', '', 114.17, 22.4443, '香港大埔雅運路港鐵大埔墟站'),
('25c98d7df4d0d744', '', '', '', '', '', 'HK', 'New Territories', '', '', '', '', '', '', '', '', '', '', '', 114.189, 22.3832, 'Shop A110-A112, Level 1, New Town Plaza III, 香港'),
('2c3b191eb48a584b', '', '9-11', 'Kong Pui St', '', '', 'HK', '', '', '', '', '', '', '', '', 'Sha Tin', '', '', '', 114.197, 22.3801, 'Shop 16, L1/F, Block B, Chuen Fai Centre,, 9-11 Kong Pui St, Sha Tin, 香港'),
('2e65713e3f046114', '', '8', 'Fo Chun Rd', '', '', 'HK', '', '', '', '', '', '', '', '', 'Providence Bay', 'Providence Peak Tower 15 (Phase 2)', 'tower 3 phase 2', '', 114.202, 22.4321, 'Providence Peak, tower 3 phase 2, Providence Peak Tower 15 (Phase 2), 8 Fo Chun Rd, Providence Bay, 香港'),
('3716eb9b7e34bff7', '', '9', 'Nam Wan Road', '', '', 'HK', 'New Territories', '', '', '', '', '', '', '', 'Wan Tau Tong', '', '', '', 114.169, 22.444, '9 Nam Wan Road, Wan Tau Tong, 香港'),
('40105cc52d3b41c7', '', '2', '紅林路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔滘', '', '', '', 114.189, 22.436, '香港大埔滘紅林路2號'),
('51dcc1d2984ec751', '', '4699', '大埔公路大埔滘段', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔滘', '', '', '', 114.196, 22.4298, '香港大埔滘大埔公路大埔滘段4699號'),
('53abfee13c885d0d', '', '', 'Siu Lek Yuen Rd', '', '', 'HK', '新界', '', '', '', '', '', '', '', '沙田', '沙角邨美雁樓', '', '', 114.195, 22.3787, '香港沙田 Siu Lek Yuen Rd, 沙角邨美雁樓'),
('58ca6d6594531422', '', '10', '曉運路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔', '', '', '', 114.166, 22.4411, '香港大埔曉運路10號'),
('625239c967b2c333', '', '', '', '', '', 'HK', '新界', '', '', '', '', '', '', '', '沙田', '', '', '', 114.189, 22.3815, '香港沙田新城市廣場6樓621A號鋪'),
('6c0debc84e4b86c7', '', '1', '沙田圍路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '沙田圍', '勵城花園', '', '', 114.195, 22.3804, '香港沙田圍沙田圍路1號勵城花園'),
('6f5c3fcd88187e60', '', '', '', '', '', 'HK', '', '', '', '', '', '', '', '', '', '', '', '', 114.196, 22.38, '香港沙田沙田圍怡成坊田園閣地下'),
('7880090fa091f1d6', '', '', '', '', '', 'HK', 'New Territories', '', '', '', '', '', '', '', 'Sha Tin', '沙角村沙角商場', '二樓239號舖', '', 114.194, 22.3778, '二樓239號舖, 沙角村沙角商場, Sha Tin, 香港'),
('80bd04bce9f8c975', '', '12', '澤祥街', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬料水', '鄭裕彤樓', '3F', '', 114.211, 22.4122, '香港馬料水澤祥街12號鄭裕彤樓3F'),
('8650cd7c9c265235', '', '1', '雍宜路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '大埔滘', '', '', '', 114.179, 22.4405, '香港大埔滘雍宜路1號'),
('964f91598b13398d', '', '', '大埔公路大埔滘段', '', '', 'HK', '新界', '', '', '', '', '', '', '', '', '', '', '', 114.188, 22.4327, '香港大埔公路大埔滘段'),
('980575c1bb48bd34', '', '', '大埔公路大埔滘段', '', '', 'HK', '新界', '', '', '', '', '', '', '', '', '', '', '', 114.188, 22.4327, '香港大埔公路大埔滘段'),
('b1560d733311f1ab', '', '', '', '', '', 'HK', '', '', '', '', '', '', '', '', '', '', '', '', 114.167, 22.4423, 'Shop 9 Level 1 Wan Tau Tong Shopping Centre, 香港'),
('b54d926f8695a5b2', '', '11', '恆明街', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬鞍山', '馬鞍山循道衛理小學', '', '', 114.225, 22.4175, '香港馬鞍山恆明街11號馬鞍山循道衛理小學'),
('bd33d3c4a7f4bada', '', '', '樟樹灘路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬料水', '', '', '', 114.199, 22.4263, '香港馬料水樟樹灘路'),
('e22ff14eb77b0d90', '', '9', 'Nam Wan Road', '', '', 'HK', 'New Territories', '', '', '', '', '', '', '', 'Wan Tau Tong', '', '', '', 114.169, 22.444, '9 Nam Wan Road, Wan Tau Tong, 香港'),
('e56d2d7bb9e791c8', '', '35', '寧泰路', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬鞍山', '', '', '', 114.22, 22.407, '香港馬鞍山寧泰路35號'),
('e7cc868397bad57f', '', '', '大學道', '', '', 'HK', '新界', '', '', '', '', '', '', '', '馬料水', '香港中文大學文物館工作處', '', '', 114.206, 22.4189, '香港馬料水大學道香港中文大學文物館工作處');

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
-- 資料表索引 `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`);

--
-- 資料表索引 `address_detail`
--
ALTER TABLE `address_detail`
  ADD PRIMARY KEY (`address_id`);

--
-- 資料表索引 `address_detail_temp`
--
ALTER TABLE `address_detail_temp`
  ADD PRIMARY KEY (`address_id`);

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
