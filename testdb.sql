-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 23, 2018 at 07:18 PM
-- Server version: 5.7.24-0ubuntu0.18.04.1
-- PHP Version: 7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testdb`
--
CREATE DATABASE IF NOT EXISTS `testdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `testdb`;

-- --------------------------------------------------------

--
-- Table structure for table `BOOKING_HISTORY`
--

CREATE TABLE `BOOKING_HISTORY` (
  `bus_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `way` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `BOOKING_HISTORY`
--

INSERT INTO `BOOKING_HISTORY` (`bus_id`, `day`, `month`, `year`, `ticket_id`, `username`, `way`, `booking_id`) VALUES
(1, 27, 11, 2018, 2, 'alpha', 1, 8),
(1, 27, 11, 2018, 3, 'alpha', 1, 9),
(1, 27, 11, 2018, 16, 'alpha', 1, 11),
(1, 27, 11, 2018, 17, 'alpha', 1, 12),
(1, 27, 11, 2018, 18, 'alpha', 1, 13),
(1, 27, 11, 2018, 20, 'alpha', 1, 15),
(1, 27, 11, 2018, 21, 'alpha', 1, 16),
(1, 27, 11, 2018, 22, 'alpha', 1, 17),
(1, 27, 11, 2018, 23, 'alpha', 1, 18),
(1, 29, 11, 2018, 2, 'alpha', 1, 19),
(2, 5, 11, 2018, 4, 'alpha', 1, 20),
(2, 14, 11, 2018, 4, 'alpha', 1, 21),
(2, 14, 11, 2018, 29, 'alpha', 1, 22),
(2, 14, 11, 2018, 30, 'alpha', 1, 23),
(2, 15, 11, 2018, 2, 'alpha', 1, 24),
(2, 15, 11, 2018, 4, 'alpha', 1, 25),
(2, 28, 11, 2018, 3, 'alpha', 1, 26),
(2, 28, 11, 2018, 3, 'alpha', 2, 27),
(2, 28, 11, 2018, 4, 'alpha', 1, 28),
(3, 9, 11, 2018, 3, 'alpha', 1, 30),
(3, 9, 11, 2018, 4, 'alpha', 1, 31),
(3, 9, 11, 2018, 5, 'alpha', 1, 32),
(3, 9, 11, 2018, 7, 'alpha', 1, 34),
(3, 9, 11, 2018, 9, 'alpha', 1, 35),
(1, 8, 11, 2018, 11, 'anony', 2, 38),
(2, 23, 11, 2018, 3, 'anony', 2, 39),
(1, 23, 11, 2018, 3, 'anony', 2, 40),
(1, 23, 11, 2018, 5, 'anony', 2, 41),
(4, 22, 11, 2018, 2, 'alpha', 2, 42),
(4, 22, 11, 2018, 3, 'alpha', 2, 43),
(1, 28, 11, 2018, 3, 'alpha', 2, 44),
(3, 23, 11, 2018, 2, 'alpha', 2, 45),
(3, 23, 11, 2018, 4, 'alpha', 2, 47),
(3, 23, 11, 2018, 5, 'alpha', 2, 48);

-- --------------------------------------------------------

--
-- Table structure for table `BUSES`
--

CREATE TABLE `BUSES` (
  `bus_id` int(11) NOT NULL,
  `price_per_km` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `BUSES`
--

INSERT INTO `BUSES` (`bus_id`, `price_per_km`, `type`) VALUES
(1, 10, 'A.C. SLEEPER'),
(2, 11, 'A.C. SLEEPER'),
(3, 15, 'A.C. SLEEPER'),
(4, 10, 'A.C. SLEEPER'),
(5, 12, 'A.C. SLEEPER'),
(6, 20, 'A.C. SLEEPER'),
(7, 17, 'A.C. SLEEPER'),
(8, 9, 'A.C. SLEEPER'),
(9, 11, 'A.C. SLEEPER'),
(10, 5, 'A.C. SLEEPER');

-- --------------------------------------------------------

--
-- Table structure for table `DESTINATION`
--

CREATE TABLE `DESTINATION` (
  `bus_id` int(11) NOT NULL,
  `destination_stn_id` int(11) NOT NULL,
  `route` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DESTINATION`
--

INSERT INTO `DESTINATION` (`bus_id`, `destination_stn_id`, `route`) VALUES
(1, 1, 2),
(1, 5, 1),
(2, 1, 2),
(2, 4, 1),
(3, 2, 2),
(3, 5, 1),
(4, 2, 2),
(4, 4, 1),
(5, 3, 2),
(5, 5, 1),
(6, 3, 2),
(6, 5, 1),
(7, 4, 2),
(7, 5, 1),
(8, 4, 2),
(8, 5, 1),
(9, 4, 2),
(9, 5, 1),
(10, 4, 2),
(10, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `START`
--

CREATE TABLE `START` (
  `bus_id` int(11) NOT NULL,
  `start_stn_id` int(11) NOT NULL,
  `route` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `START`
--

INSERT INTO `START` (`bus_id`, `start_stn_id`, `route`) VALUES
(1, 1, 1),
(1, 5, 2),
(2, 1, 1),
(2, 4, 2),
(3, 2, 1),
(3, 5, 2),
(4, 2, 1),
(4, 4, 2),
(5, 3, 1),
(5, 5, 2),
(6, 3, 1),
(6, 5, 2),
(7, 4, 1),
(7, 5, 2),
(8, 4, 1),
(8, 5, 2),
(9, 4, 1),
(9, 5, 2),
(10, 4, 1),
(10, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `STATION`
--

CREATE TABLE `STATION` (
  `stn_id` int(11) NOT NULL,
  `stn_name` varchar(20) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STATION`
--

INSERT INTO `STATION` (`stn_id`, `stn_name`, `distance`) VALUES
(1, 'A', 0),
(2, 'B', 10),
(3, 'C', 50),
(4, 'D', 100),
(5, 'E', 500);

-- --------------------------------------------------------

--
-- Table structure for table `USERS`
--

CREATE TABLE `USERS` (
  `username` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `wallet_balance` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USERS`
--

INSERT INTO `USERS` (`username`, `name`, `password`, `wallet_balance`, `gender`) VALUES
('alpha', 'anony', '1', 93730, 'Male'),
('anony', 'devansh', '1', 89900, 'Male'),
('bhalla', 'nisarg', 'bhalla123', 100000, 'Male'),
('check', 'check', 'check', 10000, 'Male'),
('destiny', 'gourav', 'kismat', 100000, 'Male'),
('iamaj', 'ashwini', '1234', 100000, 'Male'),
('mama', 'mama', 'mama', 1000000, 'Male'),
('nisarg', 'nisarg', 'dbms', 10000, 'Male');

--
-- Triggers `USERS`
--
DELIMITER $$
CREATE TRIGGER `Check_wallet` BEFORE INSERT ON `USERS` FOR EACH ROW BEGIN SET NEW.wallet_balance = 10000;END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `BOOKING_HISTORY`
--
ALTER TABLE `BOOKING_HISTORY`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `bus_id` (`bus_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `BUSES`
--
ALTER TABLE `BUSES`
  ADD PRIMARY KEY (`bus_id`);

--
-- Indexes for table `DESTINATION`
--
ALTER TABLE `DESTINATION`
  ADD PRIMARY KEY (`bus_id`,`destination_stn_id`),
  ADD KEY `destination_stn_id` (`destination_stn_id`);

--
-- Indexes for table `START`
--
ALTER TABLE `START`
  ADD PRIMARY KEY (`bus_id`,`start_stn_id`),
  ADD KEY `start_stn_id` (`start_stn_id`);

--
-- Indexes for table `STATION`
--
ALTER TABLE `STATION`
  ADD PRIMARY KEY (`stn_id`);

--
-- Indexes for table `USERS`
--
ALTER TABLE `USERS`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `BOOKING_HISTORY`
--
ALTER TABLE `BOOKING_HISTORY`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `STATION`
--
ALTER TABLE `STATION`
  MODIFY `stn_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `BOOKING_HISTORY`
--
ALTER TABLE `BOOKING_HISTORY`
  ADD CONSTRAINT `BOOKING_HISTORY_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`),
  ADD CONSTRAINT `BOOKING_HISTORY_ibfk_2` FOREIGN KEY (`username`) REFERENCES `USERS` (`username`);

--
-- Constraints for table `DESTINATION`
--
ALTER TABLE `DESTINATION`
  ADD CONSTRAINT `DESTINATION_ibfk_2` FOREIGN KEY (`destination_stn_id`) REFERENCES `STATION` (`stn_id`),
  ADD CONSTRAINT `DESTINATION_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`);

--
-- Constraints for table `START`
--
ALTER TABLE `START`
  ADD CONSTRAINT `START_ibfk_2` FOREIGN KEY (`start_stn_id`) REFERENCES `STATION` (`stn_id`),
  ADD CONSTRAINT `START_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
