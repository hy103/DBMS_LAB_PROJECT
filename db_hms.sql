CREATE DATABASE  IF NOT EXISTS `hms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hms`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: hms
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_type` varchar(45) NOT NULL,
  `emp_id` int(11) NOT NULL,
  PRIMARY KEY (`admin_type`),
  UNIQUE KEY `admin_type_UNIQUE` (`admin_type`),
  KEY `fk_admins_employee1_idx` (`emp_id`),
  CONSTRAINT `fk_admins_employee1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES ('HR',4),('FOOD',10),('ALL',19),('CAB',22),('SERVICES',25),('BOOKINGS',26),('COMPLAINTS',32);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `room_no` varchar(5) NOT NULL,
  `in_date` date NOT NULL,
  `end_date` date NOT NULL,
  `room_rate` int(11) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `job_id` int(11) NOT NULL,
  `room_amount` int(11) NOT NULL DEFAULT '0',
  `food_amount` int(11) NOT NULL DEFAULT '0',
  `service_amount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `checkin_id_UNIQUE` (`booking_id`),
  KEY `booking_rooms_no_idx` (`room_no`),
  KEY `cust_booking_id_idx` (`cust_id`),
  CONSTRAINT `booking_rooms_no` FOREIGN KEY (`room_no`) REFERENCES `rooms` (`room_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cust_booking_id` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_history`
--

DROP TABLE IF EXISTS `bookings_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings_history` (
  `booking_id` int(11) NOT NULL,
  `cust_id` int(11) DEFAULT NULL,
  `room_no` varchar(5) NOT NULL,
  `in_date` date NOT NULL,
  `days_stayed` int(11) NOT NULL,
  `room_amount` int(11) NOT NULL,
  `food_amount` int(11) NOT NULL,
  `services_amount` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `room_rating` float DEFAULT NULL,
  `job_id` int(11) NOT NULL,
  KEY `cust_book_history_id_idx` (`cust_id`),
  CONSTRAINT `cust_book_history_id` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_history`
--

LOCK TABLES `bookings_history` WRITE;
/*!40000 ALTER TABLE `bookings_history` DISABLE KEYS */;
INSERT INTO `bookings_history` VALUES (1,1,'A-001','2016-11-13',2,2000,0,0,2000,NULL,4);
/*!40000 ALTER TABLE `bookings_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cab_bookings`
--

DROP TABLE IF EXISTS `cab_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cab_bookings` (
  `cab_book_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `cat_name` varchar(45) NOT NULL,
  `dest_name` varchar(45) NOT NULL,
  `amount` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `received` tinyint(1) DEFAULT '0',
  `rating` float DEFAULT NULL,
  `job_id` int(11) NOT NULL,
  PRIMARY KEY (`cab_book_id`),
  UNIQUE KEY `cab_book_id_UNIQUE` (`cab_book_id`),
  KEY `cab_book_dest_name_idx` (`dest_name`),
  KEY `cab_book_cat_name_idx` (`cat_name`),
  KEY `cab_book_booking_id_idx` (`booking_id`),
  CONSTRAINT `cab_book_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cab_book_cat_name` FOREIGN KEY (`cat_name`) REFERENCES `cab_category` (`cat_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cab_book_dest_name` FOREIGN KEY (`dest_name`) REFERENCES `destinations` (`dest_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab_bookings`
--

LOCK TABLES `cab_bookings` WRITE;
/*!40000 ALTER TABLE `cab_bookings` DISABLE KEYS */;
INSERT INTO `cab_bookings` VALUES (1,NULL,'MICRO','AIRPORT',1000,'2016-11-12 13:08:26',1,NULL,9);
/*!40000 ALTER TABLE `cab_bookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER cab_received 
    AFTER UPDATE ON cab_bookings
    FOR EACH ROW 
BEGIN

if old.received=0 and new.received=1 then
update booking
set service_amount = service_amount+new.amount
where booking_id=new.booking_id;
end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cab_category`
--

DROP TABLE IF EXISTS `cab_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cab_category` (
  `cat_name` varchar(45) NOT NULL,
  `rate_per_km` int(11) NOT NULL,
  PRIMARY KEY (`cat_name`),
  UNIQUE KEY `cat_name_UNIQUE` (`cat_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab_category`
--

LOCK TABLES `cab_category` WRITE;
/*!40000 ALTER TABLE `cab_category` DISABLE KEYS */;
INSERT INTO `cab_category` VALUES ('MICRO',9),('MINI',12),('PRIME',17),('SEDAN',15),('SHARE',6),('SUV',21);
/*!40000 ALTER TABLE `cab_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint_category`
--

DROP TABLE IF EXISTS `complaint_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaint_category` (
  `comp_cat` varchar(45) NOT NULL,
  `job_id` int(11) NOT NULL,
  PRIMARY KEY (`comp_cat`),
  UNIQUE KEY `comp_cat_UNIQUE` (`comp_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint_category`
--

LOCK TABLES `complaint_category` WRITE;
/*!40000 ALTER TABLE `complaint_category` DISABLE KEYS */;
INSERT INTO `complaint_category` VALUES ('Cleanness',6),('Food',2),('Sanitary',7);
/*!40000 ALTER TABLE `complaint_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaints` (
  `comp_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `complaint` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comp_cat` varchar(45) DEFAULT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `service_rating` float DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  UNIQUE KEY `comp_id_UNIQUE` (`comp_id`),
  KEY `complaints_cat_name_idx` (`comp_cat`),
  KEY `complaints_booking_id_idx` (`booking_id`),
  CONSTRAINT `complaints_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `complaints_cat_name` FOREIGN KEY (`comp_cat`) REFERENCES `complaint_category` (`comp_cat`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1,NULL,'Not','2016-11-11 21:26:57','Food',1,NULL);
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `cust_id` int(11) NOT NULL,
  `cust_name` varchar(45) NOT NULL,
  `cust_mobile` varchar(15) NOT NULL,
  `cust_address` varchar(255) DEFAULT NULL,
  `cust_email` varchar(45) NOT NULL,
  `cust_password` varchar(45) NOT NULL,
  `cust_age` int(11) NOT NULL,
  `cust_gender` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cust_id`),
  UNIQUE KEY `cust_id_UNIQUE` (`cust_id`),
  UNIQUE KEY `cust_email_UNIQUE` (`cust_email`),
  UNIQUE KEY `cust_mobile_UNIQUE` (`cust_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Harsha_10d','9985718136','IIT Bhubaneswar','iamharshasmart@gmail.com','Nstatehs_1',19,'M');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(45) NOT NULL,
  `mgnr_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `dept_id_UNIQUE` (`dept_id`),
  KEY `mgnr_emp_id_idx` (`mgnr_id`),
  CONSTRAINT `mgnr_emp_id` FOREIGN KEY (`mgnr_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'HR',1),(2,'FOOD AND BEVERAGES',2),(3,'SERVICES',3),(4,'DESK',4),(5,'MAINTAINENCE',5);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destinations`
--

DROP TABLE IF EXISTS `destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinations` (
  `dest_name` varchar(25) NOT NULL,
  `sest_distance` int(11) NOT NULL,
  PRIMARY KEY (`dest_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinations`
--

LOCK TABLES `destinations` WRITE;
/*!40000 ALTER TABLE `destinations` DISABLE KEYS */;
INSERT INTO `destinations` VALUES ('AIRPORT',25),('AMEERPET',6),('BIRLA MANDIR',4),('CHARMINAR',11),('ECIL',29),('GOLCONDA FORT',17),('HI-TECH CITY',16),('KPHB',17),('LB NAGAR',14),('MALKAJGIRI',26),('OSMANIA',21),('RAILWAY STATION',14),('UPPAL',21);
/*!40000 ALTER TABLE `destinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(45) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `emp_email` varchar(45) NOT NULL,
  `emp_phone` varchar(15) NOT NULL,
  `emp_address` varchar(255) DEFAULT NULL,
  `emp_salary` int(11) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_email_UNIQUE` (`emp_email`),
  UNIQUE KEY `emp_phone_UNIQUE` (`emp_phone`),
  KEY `employee_depart_id_idx` (`dept_id`),
  KEY `emp_job_id_idx` (`job_id`),
  CONSTRAINT `emp_job_id` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `employee_depart_id` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'PAWAN KALYAN',1,1,'PAWAN KALYAN@HMS.COM','9876544516','HYDERABAD',100000,'PAWAN KALYAN'),(2,'RAJINI KANTH',1,1,'RAJINI KANTH@HMS.COM','9876544517','CHENNAI',90000,'RAJINI KANTH'),(3,'CHIRANJEEVI',1,1,'CHIRANJEEVI@HMS.COM','9876544518','HYDERABAD',80000,'CHIRANJEEVI'),(4,'AMITABH',1,1,'AMITABH@HMS.COM','9876544519','MUMBAI',80000,'AMITABH'),(5,'LEONARDO',1,1,'LEONARDO@HMS.COM','9876544520','NEWYORK',70000,'LEONARDO'),(6,'NAGARJUNA',2,2,'NAGARJUNA@HMS.COM','9876544521','HYDERABAD',80000,'NAGARJUNA'),(7,'VENKI',2,2,'VENKI@HMS.COM','9876544522','VIZAG',80000,'VENKI'),(8,'ALLU ARJUN',2,2,'ALLU ARJUN@HMS.COM','9876544523','VIZAG',80000,'ALLU ARJUN'),(9,'SALMAN',2,2,'SALMAN@HMS.COM','9876544524','ROADS',60000,'SALMAN'),(10,'SHAH RUKH',2,2,'SHAH RUKH@HMS.COM','9876544525','KOLKATA',60000,'SHAH RUKH'),(11,'AMIR KHAN',2,3,'AMIR KHAN@HMS.COM','9876544526','DELHI',60000,'AMIR KHAN'),(12,'BRAD PITT',2,3,'BRAD PITT@HMS.COM','9876544527','CHICAGO',40000,'BRAD PITT'),(13,'TOM CRUISE',2,3,'TOM CRUISE@HMS.COM','9876544528','WASHINGTON',40000,'TOM CRUISE'),(14,'ROBERT DOWNEY',2,3,'ROBERT DOWNEY@HMS.COM','9876544529','NEWYORK',40000,'ROBERT DOWNEY'),(15,'ARNOLD',2,3,'ARNOLD@HMS.COM','9876544530','NEWYORK',40000,'ARNOLD'),(16,'AMY JACKSON',3,8,'AMYJACKSON@HMS.COM','9876544531','CHICAGO',50000,'AMY JACKSON'),(17,'SCARLETT JHONSON',3,8,'SCARLETTJHONSON@HMS.COM','9876544532','CANADA',50000,'SCARLETT JHONSON'),(18,'MARGORETT ROBBIE',3,10,'MARGORETTROBBIE@HMS.COM','9876544533','LOS VEGAS',50000,'MARGORETT ROBBIE'),(19,'EMMA WATSON',3,10,'EMMAWATSON@HMS.COM','9876544534','CHICAGO',35000,'EMMA WATSON'),(20,'EMMA STONE',3,10,'EMMASTONE@HMS.COM','9876544535','NEWYORK',35000,'EMMA STONE'),(21,'DEEPIKA PADUKONE',3,9,'DEEPIKA PADUKONE@HMS.COM','9876544536','NEWYORK',35000,'DEEPIKA PADUKONE'),(22,'PRIYANKA CHOPRA',3,9,'PRIYANKACHOPRA@HMS.COM','9876544537','CALIFORNIA',25000,'PRIYANKA CHOPRA'),(23,'KAJOL',3,9,'KAJOL@HMS.COM','9876544538','HYDERABAD',25000,'KAJOL'),(24,'SAMANTHA',3,9,'SAMANTHA@HMS.COM','9876544539','HYDERABAD',25000,'SAMANTHA'),(25,'TAMMANA',3,11,'TAMMANA@HMS.COM','9876544540','MUMBAI',25000,'TAMMANA'),(26,'ALIA BHATT',4,4,'ALIA BHATT@HMS.COM','9876544541','MUMBAI',30000,'ALIA BHATT'),(27,'KAJAL AGARWAL',4,4,'KAJAL AGARWAL@HMS.COM','9876544542','HYDERABAD',30000,'KAJAL AGARWAL'),(28,'RAASI KHANNA',4,4,'RAASI KHANNA@HMS.COM','9876544543','HYDERABAD',25000,'RAASI KHANNA'),(29,'RAKUL PREETH SINGH',4,5,'RAKUL PREETH SINGH@HMS.COM','9876544544','HYDERABAD',25000,'RAKUL PREETH SINGH'),(30,'SURABHI',4,5,'SURABHI@HMS.COM','9876544545','HYDERABAD',20000,'SURABHI'),(31,'NAYATHARA',5,6,'NAYATHARA@HMS.COM','9876544546','CHENNAI',10000,'NAYATHARA'),(32,'TRISHA',5,6,'TRISHA@HMS.COM','9876544547','CHENNAI',10000,'TRISHA'),(33,'HANSIKA',5,6,'HANSIKA@HMS.COM','9876544548','CHENNAI',8000,'HANSIKA'),(34,'ANUSHKA SHETTY',5,7,'ANUSHKA SHETTY@HMS.COM','9876544549','HYDERABAD',10000,'ANUSHKA SHETTY'),(35,'ANUSHKA SHARMA',5,7,'ANUSHKA SHARMA@HMS.COM','9876544550','MUMBAI',10000,'ANUSHKA SHARMA');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_category`
--

DROP TABLE IF EXISTS `food_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_category` (
  `cat_id` int(11) NOT NULL,
  `cat_type` varchar(45) NOT NULL,
  `cat_start_time` int(11) NOT NULL,
  `cat_end_time` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_id_UNIQUE` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_category`
--

LOCK TABLES `food_category` WRITE;
/*!40000 ALTER TABLE `food_category` DISABLE KEYS */;
INSERT INTO `food_category` VALUES (1,'SOUPS',8,23),(2,'SNACKS',12,23),(3,'SALADS',17,23),(4,'BIRYANI',12,23),(5,'CURRIES',12,23),(6,'DRY ITEMS',19,23),(7,'BREAKFAST',7,11);
/*!40000 ALTER TABLE `food_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_items`
--

DROP TABLE IF EXISTS `food_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_items` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(45) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `item_rate` varchar(45) NOT NULL,
  `item_rating` float DEFAULT '0',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `food_items_cat_id_idx` (`cat_id`),
  CONSTRAINT `food_items_cat_id` FOREIGN KEY (`cat_id`) REFERENCES `food_category` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_items`
--

LOCK TABLES `food_items` WRITE;
/*!40000 ALTER TABLE `food_items` DISABLE KEYS */;
INSERT INTO `food_items` VALUES (1,'TOMATO SOUP',1,'60',0),(2,'VEG CLEAR SOUP',1,'60',0),(3,'HOT & SOUR VEG SOUP',1,'60',0),(4,'SWEET CORN VEG SOUP',1,'70',0),(5,'SWEET CORN CHICKEN SOUP',1,'70',0),(6,'CHICKEN CLEAR SOUP',1,'70',0),(7,'HOT & SOUR CHICKEN SOUP',1,'70',0),(8,'MUTTON SOUP',1,'80',0),(9,'MUSHRROM SOUP',1,'80',0),(10,'MASALA PAPPAD',2,'20',0),(11,'ROAST PAPPAD',2,'15',0),(12,'ONION PAGODA',2,'40',0),(13,'GOBI PAGODA',2,'50',0),(14,'PANNER PAGODA',2,'50',0),(15,'POTATO CHIPS',2,'40',0),(16,'GOBI 65',2,'60',0),(17,'CASHEW NUT FRY',2,'100',0),(18,'VEG CUTLET',2,'60',0),(19,'CHICKEN CUTLET',2,'80',0),(20,'SPRING ROLL VEG',2,'60',0),(21,'SPRING ROLL CHICKEN',2,'80',0),(22,'PEANUT MASALA',2,'40',0),(23,'CUCUMBER SALAD',3,'30',0),(24,'GREEN SALAD',3,'30',0),(25,'ONION RAITA',3,'30',0),(26,'FRUIT SALAD',3,'50',0),(27,'ICE CREAM SAAD',3,'70',0),(28,'SHAKE SALAD',3,'90',0),(29,'VEG BIRYANI',4,'150 ',0),(30,'CHICKEN BIRYANI',4,'200',0),(31,'WINGS CHICKEN BIRYANI',4,'240',0),(32,'MUTTON BIRYANI',4,'300',0),(33,'FISH BIRYANI',4,'300',0),(34,'PRAWNS BIRYANI',4,'350',0),(35,'JUMBO PACK BIRYANI',4,'900',0),(36,'CHICKEN CURRY',5,'100',0),(37,'CHICKEN GRAVY',5,'80',0),(38,'CHICKEN CHETTINAD',5,'120',0),(39,'CHICKEN HYDERABAD',5,'120',0),(40,'CHICKEN KADAI',5,'140',0),(41,'CHICKEN MOHALAI',5,'140',0),(42,'BUTTER CHICKEN MASALA',5,'150',0),(43,'CHI.BARTHA',5,'130',0),(44,'KAADAI MASALA',5,'150',0),(45,'CHILLY CHICKEN ',6,'100',0),(46,'GARLIC CHICKEN',6,'100',0),(47,'CHICKEN MANCHOORIAN',6,'130',0),(48,'CHICKEN ANTHASIA',6,'130',0),(49,'TACHIO CHICKEN',6,'150',0),(50,'HONG KONG RAVA CHICKEN',6,'160',0),(51,'CHINESE FRIED CHICKEN',6,'180',0),(52,'CHICKEN 65',6,'90',0),(53,'CHICKEN 65 BONELESS',6,'120',0),(54,'CHICKEN PEPPER FRY ',6,'100',0),(55,'SHANGAI CHICKEN ',6,'120',0),(56,'CHICKEN LOLLYPOP',6,'100',0),(57,'KADAI 65',6,'120',0),(58,'BREAD & JAM',7,'40',0),(59,'PURI',7,'50',0),(60,'IDLY',7,'50',0),(61,'UPMA',7,'60',0),(62,'TOMATO BATH',7,'50',0),(63,'MASALA DOSA',7,'60',0),(64,'ONION DOSA',7,'80',0),(65,'UTHAPPAM',7,'60',0);
/*!40000 ALTER TABLE `food_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_orders`
--

DROP TABLE IF EXISTS `food_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_orders` (
  `order_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `served` tinyint(1) DEFAULT '0',
  `food_rating` float DEFAULT '0',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `food_orders_item_id_idx` (`item_id`),
  KEY `food_orders_booking_id_idx` (`booking_id`),
  CONSTRAINT `food_orders_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `food_orders_item_id` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_orders`
--

LOCK TABLES `food_orders` WRITE;
/*!40000 ALTER TABLE `food_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `food_orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER food_served 
    AFTER UPDATE ON food_orders
    FOR EACH ROW 
BEGIN

declare food_amount int;

if old.served=0 and new.served=1 then
set @food_amount = (NEW.item_quantity*NEW.amount);
update booking
set food_amount = food_amount+@food_amount
where booking_id=new.booking_id;
end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `job_name` varchar(45) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `job_rating` float DEFAULT '0',
  PRIMARY KEY (`job_id`),
  UNIQUE KEY `job_id_UNIQUE` (`job_id`),
  KEY `job_dept_id_idx` (`dept_id`),
  CONSTRAINT `job_dept_id` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'Managers',1,0),(2,'Chefs',2,0),(3,'Delivery maintanence',2,0),(4,'Receptionists',4,0),(5,'Helper/Guides',4,0),(6,'Room Services',5,0),(7,'Plumber and Infra repair',5,0),(8,'Masseuse',3,0),(9,'Cab driver',3,0),(10,'Clothes',3,0),(11,'Retail and grocery',3,0);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_categories`
--

DROP TABLE IF EXISTS `room_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_categories` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(45) NOT NULL,
  `room_rate` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_id_UNIQUE` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_categories`
--

LOCK TABLES `room_categories` WRITE;
/*!40000 ALTER TABLE `room_categories` DISABLE KEYS */;
INSERT INTO `room_categories` VALUES (1,'COMFORT',2000),(2,'KING',4000),(3,'LUXURY',2700),(4,'STANDARD',1200),(5,'SUITE',6000);
/*!40000 ALTER TABLE `room_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_no` varchar(5) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `room_rating` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`room_no`),
  UNIQUE KEY `room_no_UNIQUE` (`room_no`),
  KEY `room_cat_id_idx` (`cat_id`),
  CONSTRAINT `cat_room_id` FOREIGN KEY (`cat_id`) REFERENCES `room_categories` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES ('A-001',1,0),('A-002',1,0),('A-003',1,0),('A-004',1,0),('A-005',1,0),('A-006',1,0),('A-007',1,0),('A-008',1,0),('A-010',1,0),('A-011',1,0),('A-012',1,0),('A-013',1,0),('A-014',1,0),('A-015',1,0),('A-016',1,0),('A-017',1,0),('A-018',1,0),('A-019',1,0),('A-020',1,0),('A-021',2,0),('A-022',2,0),('A-023',2,0),('A-024',2,0),('A-025',2,0),('A-026',2,0),('A-027',2,0),('A-028',2,0),('A-029',2,0),('A-030',2,0),('A-031',3,0),('A-032',3,0),('A-033',3,0),('A-034',3,0),('A-035',3,0),('A-036',3,0),('A-037',3,0),('A-038',3,0),('A-039',3,0),('A-040',3,0),('A-041',3,0),('A-042',3,0),('A-043',3,0),('A-044',3,0),('A-045',3,0),('A-046',3,0),('A-047',3,0),('A-048',3,0),('A-049',3,0),('A-050',3,0),('A-051',4,0),('A-052',4,0),('A-053',4,0),('A-054',4,0),('A-055',4,0),('A-056',4,0),('A-057',4,0),('A-058',4,0),('A-059',4,0),('A-060',4,0),('A-061',4,0),('A-062',4,0),('A-063',4,0),('A-064',4,0),('A-065',4,0),('A-066',4,0),('A-067',4,0),('A-068',4,0),('A-069',4,0),('A-070',4,0),('A-071',4,0),('A-072',4,0),('A-073',4,0),('A-074',4,0),('A-075',4,0),('A-076',4,0),('A-077',4,0),('A-078',4,0),('A-079',4,0),('A-080',4,0),('A-081',5,0),('A-082',5,0),('A-083',5,0),('A-084',5,0),('A-085',5,0),('A-086',5,0),('A-087',5,0),('A-088',5,0),('A-089',5,0),('A-090',5,0);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_orders`
--

DROP TABLE IF EXISTS `service_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_orders` (
  `order_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `job_id` int(11) NOT NULL,
  `serv_name` varchar(15) NOT NULL,
  `amount` int(11) NOT NULL,
  `served` tinyint(1) NOT NULL DEFAULT '0',
  `serv_rating` float DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `service_orders_name_idx` (`serv_name`),
  KEY `service_booking_id_idx` (`booking_id`),
  CONSTRAINT `service_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `service_orders_name` FOREIGN KEY (`serv_name`) REFERENCES `services` (`serv_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_orders`
--

LOCK TABLES `service_orders` WRITE;
/*!40000 ALTER TABLE `service_orders` DISABLE KEYS */;
INSERT INTO `service_orders` VALUES (1,NULL,10,'Dry cleaning',150,1,NULL,'2016-11-11 22:43:03');
/*!40000 ALTER TABLE `service_orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER service_complete 
    AFTER UPDATE ON service_orders
    FOR EACH ROW 
BEGIN

if old.served=0 and new.served=1 then
update booking
set service_amount = service_amount+new.amount
where booking_id=new.booking_id;
end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serv_name` varchar(15) NOT NULL,
  `serv_rate` varchar(45) NOT NULL,
  `job_id` int(11) NOT NULL,
  PRIMARY KEY (`serv_name`),
  UNIQUE KEY `serv_name_UNIQUE` (`serv_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES ('Dry cleaning','150',10),('Grocery','200',11),('Ironing','70',10),('Laundry','100',10),('Massage','400',8),('Meeting hall','3000',4),('Music','200',11),('Room cleaning','100',6),('Tourist Guide','2000',5);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hms'
--

--
-- Dumping routines for database 'hms'
--
/*!50003 DROP PROCEDURE IF EXISTS `book_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `book_room`(
IN cust_id int,
IN room_no varchar(10),
IN sdate date,
IN edate date,
IN rate int
)
BEGIN
declare book_id int;
select count(*)+1 into book_id from booking;
insert into booking(booking_id,cust_id,room_no,in_date,end_date,room_rate,job_id,room_amount,food_amount,service_amount) 
values(@book_id,@cust_id,@room_no,@sdate,@edate,@rate,4,@rate*datediff(edate,sdate),0,0); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_out` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_out`(
IN book_id int
)
BEGIN

insert into bookings_history 
select (select count(*)+1 from bookings_history) as booking_id,cust_id,room_no,in_date,datediff(end_date,in_date) as days_stayed,room_amount,food_amount,service_amount,room_amount+food_amount+service_amount as amount,null as room_rating,4 as job_id
from booking where booking_id=@book_id;

delete from booking where booking_id=@book_id;

END ;;
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

-- Dump completed on 2016-11-14 10:40:31
