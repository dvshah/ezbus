-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BOOKING_HISTORY`
--

DROP TABLE IF EXISTS `BOOKING_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BOOKING_HISTORY` (
  `bus_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `way` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`booking_id`),
  KEY `bus_id` (`bus_id`),
  KEY `username` (`username`),
  CONSTRAINT `BOOKING_HISTORY_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`),
  CONSTRAINT `BOOKING_HISTORY_ibfk_2` FOREIGN KEY (`username`) REFERENCES `USERS` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BOOKING_HISTORY`
--

LOCK TABLES `BOOKING_HISTORY` WRITE;
/*!40000 ALTER TABLE `BOOKING_HISTORY` DISABLE KEYS */;
INSERT INTO `BOOKING_HISTORY` VALUES (1,27,11,2018,2,'alpha',1,8),(1,27,11,2018,3,'alpha',1,9),(1,27,11,2018,16,'alpha',1,11),(1,27,11,2018,17,'alpha',1,12),(1,27,11,2018,18,'alpha',1,13),(1,27,11,2018,20,'alpha',1,15),(1,27,11,2018,21,'alpha',1,16),(1,27,11,2018,22,'alpha',1,17),(1,27,11,2018,23,'alpha',1,18),(1,29,11,2018,2,'alpha',1,19),(2,5,11,2018,4,'alpha',1,20),(2,14,11,2018,4,'alpha',1,21),(2,14,11,2018,29,'alpha',1,22),(2,14,11,2018,30,'alpha',1,23),(2,15,11,2018,2,'alpha',1,24),(2,15,11,2018,4,'alpha',1,25),(2,28,11,2018,3,'alpha',1,26),(2,28,11,2018,3,'alpha',2,27),(2,28,11,2018,4,'alpha',1,28),(3,9,11,2018,3,'alpha',1,30),(3,9,11,2018,4,'alpha',1,31),(3,9,11,2018,5,'alpha',1,32),(3,9,11,2018,7,'alpha',1,34),(3,9,11,2018,9,'alpha',1,35),(1,8,11,2018,11,'anony',2,38),(2,23,11,2018,3,'anony',2,39),(1,23,11,2018,3,'anony',2,40),(1,23,11,2018,5,'anony',2,41),(4,22,11,2018,2,'alpha',2,42),(4,22,11,2018,3,'alpha',2,43),(1,28,11,2018,3,'alpha',2,44),(3,23,11,2018,2,'alpha',2,45),(3,23,11,2018,4,'alpha',2,47),(3,23,11,2018,5,'alpha',2,48);
/*!40000 ALTER TABLE `BOOKING_HISTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BUSES`
--

DROP TABLE IF EXISTS `BUSES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BUSES` (
  `bus_id` int(11) NOT NULL,
  `price_per_km` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`bus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BUSES`
--

LOCK TABLES `BUSES` WRITE;
/*!40000 ALTER TABLE `BUSES` DISABLE KEYS */;
INSERT INTO `BUSES` VALUES (1,10,'A.C. SLEEPER'),(2,11,'A.C. SLEEPER'),(3,15,'A.C. SLEEPER'),(4,10,'A.C. SLEEPER'),(5,12,'A.C. SLEEPER'),(6,20,'A.C. SLEEPER'),(7,17,'A.C. SLEEPER'),(8,9,'A.C. SLEEPER'),(9,11,'A.C. SLEEPER'),(10,5,'A.C. SLEEPER');
/*!40000 ALTER TABLE `BUSES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DESTINATION`
--

DROP TABLE IF EXISTS `DESTINATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DESTINATION` (
  `bus_id` int(11) NOT NULL,
  `destination_stn_id` int(11) NOT NULL,
  `route` int(11) NOT NULL,
  PRIMARY KEY (`bus_id`,`destination_stn_id`),
  KEY `destination_stn_id` (`destination_stn_id`),
  CONSTRAINT `DESTINATION_ibfk_2` FOREIGN KEY (`destination_stn_id`) REFERENCES `STATION` (`stn_id`),
  CONSTRAINT `DESTINATION_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DESTINATION`
--

LOCK TABLES `DESTINATION` WRITE;
/*!40000 ALTER TABLE `DESTINATION` DISABLE KEYS */;
INSERT INTO `DESTINATION` VALUES (1,1,2),(1,5,1),(2,1,2),(2,4,1),(3,2,2),(3,5,1),(4,2,2),(4,4,1),(5,3,2),(5,5,1),(6,3,2),(6,5,1),(7,4,2),(7,5,1),(8,4,2),(8,5,1),(9,4,2),(9,5,1),(10,4,2),(10,5,1);
/*!40000 ALTER TABLE `DESTINATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `START`
--

DROP TABLE IF EXISTS `START`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `START` (
  `bus_id` int(11) NOT NULL,
  `start_stn_id` int(11) NOT NULL,
  `route` int(11) NOT NULL,
  PRIMARY KEY (`bus_id`,`start_stn_id`),
  KEY `start_stn_id` (`start_stn_id`),
  CONSTRAINT `START_ibfk_2` FOREIGN KEY (`start_stn_id`) REFERENCES `STATION` (`stn_id`),
  CONSTRAINT `START_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `BUSES` (`bus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `START`
--

LOCK TABLES `START` WRITE;
/*!40000 ALTER TABLE `START` DISABLE KEYS */;
INSERT INTO `START` VALUES (1,1,1),(1,5,2),(2,1,1),(2,4,2),(3,2,1),(3,5,2),(4,2,1),(4,4,2),(5,3,1),(5,5,2),(6,3,1),(6,5,2),(7,4,1),(7,5,2),(8,4,1),(8,5,2),(9,4,1),(9,5,2),(10,4,1),(10,5,2);
/*!40000 ALTER TABLE `START` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STATION`
--

DROP TABLE IF EXISTS `STATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `STATION` (
  `stn_id` int(11) NOT NULL AUTO_INCREMENT,
  `stn_name` varchar(20) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  PRIMARY KEY (`stn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STATION`
--

LOCK TABLES `STATION` WRITE;
/*!40000 ALTER TABLE `STATION` DISABLE KEYS */;
INSERT INTO `STATION` VALUES (1,'A',0),(2,'B',10),(3,'C',50),(4,'D',100),(5,'E',500);
/*!40000 ALTER TABLE `STATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `username` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `wallet_balance` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES ('alpha','anony','1',93730,'Male'),('anony','devansh','1',89900,'Male'),('bhalla','nisarg','bhalla123',100000,'Male'),('check','check','check',10000,'Male'),('destiny','gourav','kismat',100000,'Male'),('iamaj','ashwini','1234',100000,'Male'),('mama','mama','mama',1000000,'Male'),('nisarg','nisarg','dbms',10000,'Male');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Check_wallet` BEFORE INSERT ON USERS FOR EACH ROW BEGIN SET NEW.wallet_balance = 10000;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-17 18:22:45
