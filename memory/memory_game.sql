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
-- 資料庫： `memory_game`
--

-- --------------------------------------------------------

--
-- 資料表結構 `memory`
--

CREATE TABLE `memory` (
  `rid` varchar(255) NOT NULL,
  `score` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `memory`
--

INSERT INTO `memory` (`rid`, `score`, `updated`) VALUES
('c91347b6df21d5d164801258', '228', '2019-03-27 09:53:29');

-- --------------------------------------------------------

--
-- 資料表結構 `puzzle`
--

CREATE TABLE `puzzle` (
  `rid` varchar(255) NOT NULL,
  `score` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `puzzle`
--

INSERT INTO `puzzle` (`rid`, `score`, `updated`) VALUES
('c91347b6df21d5d164801258', '72', '2019-04-03 13:44:32');

-- --------------------------------------------------------

--
-- 資料表結構 `records`
--

CREATE TABLE `records` (
  `rid` varchar(255) NOT NULL,
  `imageUri` text NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  `create_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `records`
--

INSERT INTO `records` (`rid`, `imageUri`, `phone_number`, `facebook_id`, `create_date`) VALUES
('c91347b6df21d5d164801258', '', '64801258', '', '2019-03-27');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `memory`
--
ALTER TABLE `memory`
  ADD PRIMARY KEY (`rid`);

--
-- 資料表索引 `puzzle`
--
ALTER TABLE `puzzle`
  ADD PRIMARY KEY (`rid`);

--
-- 資料表索引 `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`rid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
