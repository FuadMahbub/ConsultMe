CREATE DATABASE  IF NOT EXISTS `legalease` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `legalease`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: legalease
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_app_client`
--

DROP TABLE IF EXISTS `accounts_app_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_client` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` longtext,
  `photo` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `accounts_app_client_user_id_3450080f_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_client`
--

LOCK TABLES `accounts_app_client` WRITE;
/*!40000 ALTER TABLE `accounts_app_client` DISABLE KEYS */;
INSERT INTO `accounts_app_client` VALUES (1,'client@gmail.com','Fuad Mahbub','01636448266','Bank Colony','','2024-05-11 07:29:46.116119','2024-05-12 12:46:04.181937',3),(2,'client4@gmail.com','Thor','852147963','TEST','myimage/blank.png','2024-05-12 13:10:10.839864','2024-05-12 13:10:12.098235',8),(3,'client2@gmail.com','ENAM','123416848','ENAM MEDICAL COLLEGE, SAVAR, DHAKA','myimage/blank.png','2024-05-12 13:14:33.627613','2024-05-12 13:14:34.890793',9);
/*!40000 ALTER TABLE `accounts_app_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_colleges`
--

DROP TABLE IF EXISTS `accounts_app_colleges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_colleges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_colleges`
--

LOCK TABLES `accounts_app_colleges` WRITE;
/*!40000 ALTER TABLE `accounts_app_colleges` DISABLE KEYS */;
INSERT INTO `accounts_app_colleges` VALUES (1,'University of Oxford - Faculty of Law','university-of-oxford-faculty-of-law'),(2,'University of Cambridge - Faculty of Law','university-of-cambridge-faculty-of-law'),(3,'London School of Economics and Political Science (LSE) - Department of Law','london-school-of-economics-and-political-science-lse-department-of-law'),(4,'King\'s College London - The Dickson Poon School of Law','kings-college-london-the-dickson-poon-school-of-law'),(5,'University College London (UCL) - Faculty of Laws','university-college-london-ucl-faculty-of-laws'),(6,'University of Edinburgh - School of Law','university-of-edinburgh-school-of-law'),(7,'University of Glasgow - School of Law','university-of-glasgow-school-of-law'),(8,'University of Durham - Durham Law School','university-of-durham-durham-law-school'),(9,'University of Bristol - School of Law','university-of-bristol-school-of-law'),(10,'University of Nottingham - School of Law','university-of-nottingham-school-of-law'),(11,'University of York - York Law School','university-of-york-york-law-school'),(12,'Queen Mary University of London - School of Law','queen-mary-university-of-london-school-of-law'),(13,'University of Warwick - School of Law','university-of-warwick-school-of-law'),(14,'University of Manchester - School of Law','university-of-manchester-school-of-law'),(15,'University of Sheffield - School of Law','university-of-sheffield-school-of-law'),(16,'University of Birmingham - Birmingham Law School','university-of-birmingham-birmingham-law-school'),(17,'University of Exeter - Law School','university-of-exeter-law-school'),(18,'University of Southampton - School of Law','university-of-southampton-school-of-law'),(19,'University of Leeds - School of Law','university-of-leeds-school-of-law'),(20,'University of Sussex - Sussex Law School','university-of-sussex-sussex-law-school'),(21,'University of Dhaka - Department of Law','university-of-dhaka-department-of-law'),(22,'University of Rajshahi - Department of Law','university-of-rajshahi-department-of-law'),(23,'University of Chittagong - Faculty of Law','university-of-chittagong-faculty-of-law'),(24,'Jahangirnagar University - Department of Law and Justice','jahangirnagar-university-department-of-law-and-justice'),(25,'Islamic University, Bangladesh - Department of Law','islamic-university-bangladesh-department-of-law'),(26,'Bangladesh University of Professionals (BUP) - Department of Law','bangladesh-university-of-professionals-bup-department-of-law'),(27,'BRAC University - School of Law','brac-university-school-of-law'),(28,'North South University - Department of Law','north-south-university-department-of-law'),(29,'Independent University, Bangladesh (IUB) - School of Law','independent-university-bangladesh-iub-school-of-law'),(30,'American International University-Bangladesh (AIUB) - Faculty of Arts and Social Sciences, Departmen','american-international-university-bangladesh-aiub-faculty-of-arts-and-social-sciences-departmen'),(31,'ASA University Bangladesh - Faculty of Law','asa-university-bangladesh-faculty-of-law');
/*!40000 ALTER TABLE `accounts_app_colleges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_customuser`
--

DROP TABLE IF EXISTS `accounts_app_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `username` varchar(55) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_customuser`
--

LOCK TABLES `accounts_app_customuser` WRITE;
/*!40000 ALTER TABLE `accounts_app_customuser` DISABLE KEYS */;
INSERT INTO `accounts_app_customuser` VALUES (1,'pbkdf2_sha256$720000$k8WuheBa71D7VKUVmpscP1$SrF9AtOqweHvwmqQjaaWO6rDOWzR4STqGlUw+cY2hG4=','2024-05-12 14:27:26.045642',1,'admin@gmail.com','',1,1,'2024-05-11 06:54:00.391251'),(2,'pbkdf2_sha256$720000$ML7284V0rLdLIi6ZJ6HC79$tqVIq1XZqbKGpjj265+oLHfFjPMru1FOyhsvhzlt0B4=','2024-05-12 21:48:18.167238',0,'law@gmail.com','',0,1,'2024-05-11 07:02:20.341029'),(3,'pbkdf2_sha256$720000$k7lpuq9csVOCTKA4KFIrQL$YbmdpjQxo+C0ubtw/UW7RxohIUKtFfhQmfZTa+kqGqE=','2024-05-12 21:48:32.100869',0,'client@gmail.com','',0,1,'2024-05-11 07:29:46.124136'),(4,'pbkdf2_sha256$720000$4UVqFsM6U5V42BTGICTMYp$npjajrk37Puf+nPAKGaLv83+SefE2W0ramyqGWBe2cg=','2024-05-12 14:03:41.347499',0,'law3@gmail.com','',0,1,'2024-05-12 04:22:07.222569'),(5,'pbkdf2_sha256$720000$RaopKYJAl4tnW24uD5KshA$n9KJS933YY1xpentZuXYLD8lf74jS0InHaAWENmJZuM=','2024-05-12 14:04:17.489585',0,'lawyer4@gmail.com','',0,1,'2024-05-12 04:34:40.078132'),(6,'pbkdf2_sha256$720000$O8puQLyrMfFK21QQDmBLuz$inuaXE0ShnNfOlxZ50+5EYD31xfFgAeS0b0YnmFswsE=',NULL,0,'lawyer5@gmail.com','',0,1,'2024-05-12 10:30:54.079025'),(7,'pbkdf2_sha256$720000$gI0o7gCkRjgrPpw8TExzRn$35KZOYp8rltwehfGbPZuEAhHJJSJzb0OzK0InKVA+qE=',NULL,0,'law6@gmail.com','',0,1,'2024-05-12 10:35:33.673103'),(8,'pbkdf2_sha256$720000$hqr9ePUJipzPVfrA3O7U3Y$tWwJQA4s/ZzgBZxDGiqSZOfScD3Np2sOMqx8qCd1rM0=','2024-05-12 21:48:42.187914',0,'client4@gmail.com','',0,1,'2024-05-12 13:10:10.849597'),(9,'pbkdf2_sha256$720000$TMEoqN6XFDJ5VwU0K1xwJi$DHNSKHklasdm3uHWVp/smInSsif31i7IGoIWmMte1IM=','2024-05-12 14:46:42.172506',0,'client2@gmail.com','',0,1,'2024-05-12 13:14:33.636199');
/*!40000 ALTER TABLE `accounts_app_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_customuser_groups`
--

DROP TABLE IF EXISTS `accounts_app_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_app_customuser__customuser_id_group_id_0dd23bdc_uniq` (`customuser_id`,`group_id`),
  KEY `accounts_app_customu_group_id_f9f8ca73_fk_auth_grou` (`group_id`),
  CONSTRAINT `accounts_app_customu_customuser_id_df5422f8_fk_accounts_` FOREIGN KEY (`customuser_id`) REFERENCES `accounts_app_customuser` (`id`),
  CONSTRAINT `accounts_app_customu_group_id_f9f8ca73_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_customuser_groups`
--

LOCK TABLES `accounts_app_customuser_groups` WRITE;
/*!40000 ALTER TABLE `accounts_app_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_app_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_customuser_user_permissions`
--

DROP TABLE IF EXISTS `accounts_app_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_app_customuser__customuser_id_permission_b8ef9832_uniq` (`customuser_id`,`permission_id`),
  KEY `accounts_app_customu_permission_id_8d347ed9_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_app_customu_customuser_id_5b9b34ef_fk_accounts_` FOREIGN KEY (`customuser_id`) REFERENCES `accounts_app_customuser` (`id`),
  CONSTRAINT `accounts_app_customu_permission_id_8d347ed9_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_customuser_user_permissions`
--

LOCK TABLES `accounts_app_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_app_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_app_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_expertise`
--

DROP TABLE IF EXISTS `accounts_app_expertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_expertise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_expertise`
--

LOCK TABLES `accounts_app_expertise` WRITE;
/*!40000 ALTER TABLE `accounts_app_expertise` DISABLE KEYS */;
INSERT INTO `accounts_app_expertise` VALUES (1,'Criminal Law','criminal-law'),(2,'Civil Rights Law','civil-rights-law'),(3,'Corporate Law','corporate-law'),(4,'Intellectual Property Law','intellectual-property-law'),(5,'Family Law','family-law'),(6,'Real Estate Law','real-estate-law'),(7,'Environmental Law','environmental-law'),(8,'Employment and Labor Law','employment-and-labor-law'),(9,'Tax Law','tax-law'),(10,'Bankruptcy Law','bankruptcy-law'),(11,'Immigration Law','immigration-law'),(12,'International Law','international-law'),(13,'Constitutional Law','constitutional-law'),(14,'Personal Injury Law','personal-injury-law'),(15,'Medical Malpractice Law','medical-malpractice-law'),(16,'Antitrust Law','antitrust-law'),(17,'Entertainment Law','entertainment-law'),(18,'Sports Law','sports-law'),(19,'Human Rights Law','human-rights-law'),(20,'Military Law','military-law'),(21,'Construction Law','construction-law'),(22,'Trusts and Estates Law','trusts-and-estates-law'),(23,'Health Care Law','health-care-law'),(24,'Maritime Law','maritime-law'),(25,'Education Law','education-law'),(26,'Consumer Protection Law','consumer-protection-law'),(27,'Elder Law','elder-law'),(28,'Alternative Dispute Resolution (ADR)','alternative-dispute-resolution-adr'),(29,'Insurance Law','insurance-law'),(30,'Technology Law','technology-law');
/*!40000 ALTER TABLE `accounts_app_expertise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_app_lawyer`
--

DROP TABLE IF EXISTS `accounts_app_lawyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_app_lawyer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` longtext,
  `photo` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `college_id` int NOT NULL,
  `expertise_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `accounts_app_lawyer_college_id_0d9ac660_fk_accounts_` (`college_id`),
  KEY `accounts_app_lawyer_expertise_id_6e64e369_fk_accounts_` (`expertise_id`),
  CONSTRAINT `accounts_app_lawyer_college_id_0d9ac660_fk_accounts_` FOREIGN KEY (`college_id`) REFERENCES `accounts_app_colleges` (`id`),
  CONSTRAINT `accounts_app_lawyer_expertise_id_6e64e369_fk_accounts_` FOREIGN KEY (`expertise_id`) REFERENCES `accounts_app_expertise` (`id`),
  CONSTRAINT `accounts_app_lawyer_user_id_212a6a41_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_app_lawyer`
--

LOCK TABLES `accounts_app_lawyer` WRITE;
/*!40000 ALTER TABLE `accounts_app_lawyer` DISABLE KEYS */;
INSERT INTO `accounts_app_lawyer` VALUES (1,'law@gmail.com','Saul Goodman','7894561321','Breaking Bad','myimage/images_f7BX5Em.jpeg','2024-05-11 07:02:20.309023','2024-05-12 11:31:24.270567',2,1,2),(2,'law3@gmail.com','Jacob','789465132','USA','myimage/partho.jpeg','2024-05-12 04:22:07.212336','2024-05-12 04:38:46.870299',11,4,4),(3,'lawyer4@gmail.com','Elliot','556461638','New York, America','myimage/sumon.jpg','2024-05-12 04:34:40.063380','2024-05-12 04:37:02.191453',13,12,5),(4,'lawyer5@gmail.com','Shafiq Uddin','7412589632','Pakistan','myimage/blank.png','2024-05-12 10:30:54.063474','2024-05-12 10:30:55.309136',14,9,6),(5,'law6@gmail.com','Shafiq Uddin PM','555789462131','Somewhere','myimage/blank.png','2024-05-12 10:35:33.663130','2024-05-12 10:35:34.847733',11,12,7);
/*!40000 ALTER TABLE `accounts_app_lawyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add contact',6,'add_contact'),(22,'Can change contact',6,'change_contact'),(23,'Can delete contact',6,'delete_contact'),(24,'Can view contact',6,'view_contact'),(25,'Can add colleges',7,'add_colleges'),(26,'Can change colleges',7,'change_colleges'),(27,'Can delete colleges',7,'delete_colleges'),(28,'Can view colleges',7,'view_colleges'),(29,'Can add expertise',8,'add_expertise'),(30,'Can change expertise',8,'change_expertise'),(31,'Can delete expertise',8,'delete_expertise'),(32,'Can view expertise',8,'view_expertise'),(33,'Can add custom user',9,'add_customuser'),(34,'Can change custom user',9,'change_customuser'),(35,'Can delete custom user',9,'delete_customuser'),(36,'Can view custom user',9,'view_customuser'),(37,'Can add client',10,'add_client'),(38,'Can change client',10,'change_client'),(39,'Can delete client',10,'delete_client'),(40,'Can view client',10,'view_client'),(41,'Can add lawyer',11,'add_lawyer'),(42,'Can change lawyer',11,'change_lawyer'),(43,'Can delete lawyer',11,'delete_lawyer'),(44,'Can view lawyer',11,'view_lawyer'),(45,'Can add message',12,'add_message'),(46,'Can change message',12,'change_message'),(47,'Can delete message',12,'delete_message'),(48,'Can view message',12,'view_message'),(49,'Can add accepted client',13,'add_acceptedclient'),(50,'Can change accepted client',13,'change_acceptedclient'),(51,'Can delete accepted client',13,'delete_acceptedclient'),(52,'Can view accepted client',13,'view_acceptedclient'),(53,'Can add consultation post',14,'add_consultationpost'),(54,'Can change consultation post',14,'change_consultationpost'),(55,'Can delete consultation post',14,'delete_consultationpost'),(56,'Can view consultation post',14,'view_consultationpost'),(57,'Can add room',15,'add_room'),(58,'Can change room',15,'change_room'),(59,'Can delete room',15,'delete_room'),(60,'Can view room',15,'view_room'),(61,'Can add consultation request',16,'add_consultationrequest'),(62,'Can change consultation request',16,'change_consultationrequest'),(63,'Can delete consultation request',16,'delete_consultationrequest'),(64,'Can view consultation request',16,'view_consultationrequest'),(65,'Can add blog post',17,'add_blogpost'),(66,'Can change blog post',17,'change_blogpost'),(67,'Can delete blog post',17,'delete_blogpost'),(68,'Can view blog post',17,'view_blogpost'),(69,'Can add comment',18,'add_comment'),(70,'Can change comment',18,'change_comment'),(71,'Can delete comment',18,'delete_comment'),(72,'Can view comment',18,'view_comment'),(73,'Can add invoice',19,'add_invoice'),(74,'Can change invoice',19,'change_invoice'),(75,'Can delete invoice',19,'delete_invoice'),(76,'Can view invoice',19,'view_invoice'),(77,'Can add chat',20,'add_chat'),(78,'Can change chat',20,'change_chat'),(79,'Can delete chat',20,'delete_chat'),(80,'Can view chat',20,'view_chat'),(81,'Can add law explainer',21,'add_lawexplainer'),(82,'Can change law explainer',21,'change_lawexplainer'),(83,'Can delete law explainer',21,'delete_lawexplainer'),(84,'Can view law explainer',21,'view_lawexplainer'),(85,'Can add case',22,'add_case'),(86,'Can change case',22,'change_case'),(87,'Can delete case',22,'delete_case'),(88,'Can view case',22,'view_case'),(89,'Can add case file',23,'add_casefile'),(90,'Can change case file',23,'change_casefile'),(91,'Can delete case file',23,'delete_casefile'),(92,'Can view case file',23,'view_casefile'),(93,'Can add closed case',24,'add_closedcase'),(94,'Can change closed case',24,'change_closedcase'),(95,'Can delete closed case',24,'delete_closedcase'),(96,'Can view closed case',24,'view_closedcase');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_app_invoice`
--

DROP TABLE IF EXISTS `billing_app_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_app_invoice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `issued_by_id` bigint NOT NULL,
  `issued_to_id` bigint NOT NULL,
  `card_last_four` varchar(4) DEFAULT NULL,
  `payment_reference` varchar(100) DEFAULT NULL,
  `case_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_app_invoice_issued_by_id_c57d8cf2_fk_accounts_` (`issued_by_id`),
  KEY `billing_app_invoice_issued_to_id_2d03d07f_fk_accounts_` (`issued_to_id`),
  KEY `billing_app_invoice_case_id_3e225566_fk_case_app_case_id` (`case_id`),
  CONSTRAINT `billing_app_invoice_case_id_3e225566_fk_case_app_case_id` FOREIGN KEY (`case_id`) REFERENCES `case_app_case` (`id`),
  CONSTRAINT `billing_app_invoice_issued_by_id_c57d8cf2_fk_accounts_` FOREIGN KEY (`issued_by_id`) REFERENCES `accounts_app_lawyer` (`id`),
  CONSTRAINT `billing_app_invoice_issued_to_id_2d03d07f_fk_accounts_` FOREIGN KEY (`issued_to_id`) REFERENCES `accounts_app_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_app_invoice`
--

LOCK TABLES `billing_app_invoice` WRITE;
/*!40000 ALTER TABLE `billing_app_invoice` DISABLE KEYS */;
INSERT INTO `billing_app_invoice` VALUES (6,800.00,'','paid','2024-05-12 13:36:58.021368','2024-05-12 13:40:50.766243',3,3,'1234','PAY-9564',6);
/*!40000 ALTER TABLE `billing_app_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_app_blogpost`
--

DROP TABLE IF EXISTS `blog_app_blogpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_app_blogpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_app_blogpost_author_id_61e90ef6_fk_accounts_` (`author_id`),
  CONSTRAINT `blog_app_blogpost_author_id_61e90ef6_fk_accounts_` FOREIGN KEY (`author_id`) REFERENCES `accounts_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_app_blogpost`
--

LOCK TABLES `blog_app_blogpost` WRITE;
/*!40000 ALTER TABLE `blog_app_blogpost` DISABLE KEYS */;
INSERT INTO `blog_app_blogpost` VALUES (1,'Unraveling the Threads of Justice: A Murder Case Study','Introduction:\r\nIn the realm of law, few cases evoke as much intrigue and emotion as those involving murder. These cases often become battlegrounds where justice, truth, and human nature collide. Join us as we delve into a captivating murder case study, exploring the intricacies of the legal process and the pursuit of truth in the face of darkness.\r\n\r\nThe Case: The Mysterious Death of Mr. X\r\nOur journey begins with the enigmatic death of Mr. X, a wealthy businessman found lifeless in his opulent mansion on a cold winter\'s night. The circumstances surrounding his demise are shrouded in mystery, with initial reports suggesting suicide. However, as investigators delve deeper, evidence emerges pointing to foul play.\r\n\r\nInvestigation and Evidence:\r\nThe investigation unfolds like a gripping novel, with detectives meticulously piecing together fragments of evidence scattered throughout the crime scene. Forensic analysis reveals traces of a lethal toxin in Mr. X\'s bloodstream, raising suspicions of poisoning. Meanwhile, eyewitness accounts and surveillance footage paint a complex picture of the events leading up to his death.\r\n\r\nLegal Proceedings:\r\nAs the case gains momentum, it falls into the hands of seasoned prosecutors and defense attorneys, each determined to uncover the truth. The courtroom becomes a theater of drama and tension as witnesses testify, experts debate, and evidence is scrutinized. Every detail, no matter how seemingly insignificant, is dissected in the relentless pursuit of justice.\r\n\r\nChallenges and Controversies:\r\nYet, no murder case is without its challenges and controversies. Conflicting testimonies, unreliable evidence, and the specter of reasonable doubt loom large, casting a shadow of uncertainty over the proceedings. As the trial unfolds, ethical dilemmas emerge, forcing both legal teams to navigate a moral minefield in their quest for victory.\r\n\r\nVerdict and Aftermath:\r\nFinally, after weeks of deliberation, the jury delivers its verdict, bringing closure to a case that has captivated the nation. But even as justice is served, lingering questions remain. What drove someone to commit such a heinous act? Could the outcome have been different if certain decisions were made differently? The echoes of the trial reverberate long after the final gavel falls, reminding us of the complexities of human nature and the fragility of life.\r\n\r\nConclusion:\r\nIn the annals of legal history, murder cases stand as testaments to the enduring struggle for truth and justice. They remind us of the profound impact of crime on individuals, families, and communities, and the vital role that the law plays in upholding societal values. As we reflect on the intricacies of our case study, let us not forget the human stories behind the headlines and the lessons they impart about the nature of justice in our world.\r\n\r\nJoin us next time as we explore another captivating chapter in the fascinating tapestry of law and society. Until then, may the pursuit of truth guide our paths and illuminate the darkness that surrounds us.','2024-05-11 13:43:15.778178','2024-05-11 13:43:15.778178',2),(2,'Addressing Contemporary Legal Challenges: Insights and Solutions','Introduction\r\n\r\nThe legal landscape is continuously evolving, driven by rapid technological advances, societal shifts, and legislative changes. Lawyers and legal professionals face a myriad of challenges that require innovative solutions and a proactive approach to ensure justice and the rule of law are maintained. This blog post explores some of the most pressing legal problems today, offering insights into their complexities and proposing ways to address these issues effectively.\r\n\r\n1. Technological Disruption and Privacy Concerns\r\n\r\nAs technology advances, so do the legal issues surrounding privacy and data protection. The advent of artificial intelligence, big data, and the Internet of Things (IoT) has sparked significant privacy concerns, especially with incidents involving data breaches and misuse of personal information. Legal systems worldwide are struggling to keep pace with these changes, often lagging behind in creating and enforcing laws that protect privacy without stifling innovation.\r\n\r\nSolution:\r\nTo address this, there is a pressing need for updated regulations that specifically target the nuances of digital data. Legal professionals must advocate for and help draft legislation that balances individual privacy rights with the benefits of technological advancements. Additionally, public awareness and education on digital rights are crucial in ensuring individuals know how to protect their personal information.\r\n\r\n2. Access to Justice\r\n\r\nDespite advancements in the legal field, access to justice remains a significant issue, particularly for underprivileged communities. The high cost of legal representation and the complexity of legal procedures often deter individuals from seeking legal help, exacerbating inequalities and undermining trust in the legal system.\r\n\r\nSolution:\r\nImplementing more robust legal aid programs and introducing technological solutions, such as online legal services and virtual courtrooms, can help bridge this gap. Moreover, promoting pro bono work and supporting non-profit legal services are essential steps towards making legal help more accessible to everyone.\r\n\r\n3. Intellectual Property in a Globalized Economy\r\n\r\nGlobalization has complicated the enforcement of intellectual property (IP) laws as products and ideas quickly cross international borders. The challenge lies in protecting IP rights in a way that fosters innovation and creativity while preventing misuse and piracy.\r\n\r\nSolution:\r\nStrengthening international cooperation in IP law enforcement can help tackle this challenge. Establishing uniform IP standards and streamlined processes for international patenting and copyrights will aid in protecting the rights of creators and innovators across borders.\r\n\r\n4. Environmental Law and Climate Change\r\n\r\nThe global crisis of climate change presents unique challenges to the legal profession, particularly in the field of environmental law. Legal frameworks need to evolve to address the causes and impacts of climate change, including regulating emissions, protecting biodiversity, and ensuring sustainable development practices.\r\n\r\nSolution:\r\nEnvironmental laws must be both stringent and enforceable. Lawyers and legal scholars should lead the way in crafting laws that reflect current scientific understandings of climate change. Furthermore, the legal profession can play a pivotal role in environmental advocacy, influencing policy, and corporate practices to prioritize sustainability.\r\n\r\n5. The Changing Workforce and Employment Law\r\n\r\nThe modern workforce is changing, with remote work, gig economy jobs, and technological displacement creating new legal dilemmas in employment law. These include issues around worker classification, rights to benefits, and new forms of workplace discrimination.\r\n\r\nSolution:\r\nAdapting employment laws to reflect the changing nature of work is essential. This includes redefining employment categories, ensuring fair labor standards apply to all types of workers, and protecting against discrimination in increasingly digital and diverse workplaces.\r\n\r\nConclusion\r\n\r\nLegal professionals must remain at the forefront of societal changes, advocating for justice and adapting to new challenges. By embracing innovation and fostering dialogue among stakeholders, the legal field can navigate these complex issues and work towards solutions that ensure equity, protect individual rights, and uphold the rule of law. As we continue to face these evolving challenges, the importance of informed, proactive legal practice has never been more critical.','2024-05-12 13:24:48.129315','2024-05-12 13:24:48.129315',5);
/*!40000 ALTER TABLE `blog_app_blogpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_app_comment`
--

DROP TABLE IF EXISTS `blog_app_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_app_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_app_comment_author_id_7f93d373_fk_accounts_` (`author_id`),
  KEY `blog_app_comment_post_id_8b91a88c_fk_blog_app_blogpost_id` (`post_id`),
  CONSTRAINT `blog_app_comment_author_id_7f93d373_fk_accounts_` FOREIGN KEY (`author_id`) REFERENCES `accounts_app_customuser` (`id`),
  CONSTRAINT `blog_app_comment_post_id_8b91a88c_fk_blog_app_blogpost_id` FOREIGN KEY (`post_id`) REFERENCES `blog_app_blogpost` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_app_comment`
--

LOCK TABLES `blog_app_comment` WRITE;
/*!40000 ALTER TABLE `blog_app_comment` DISABLE KEYS */;
INSERT INTO `blog_app_comment` VALUES (1,'Great Content','2024-05-12 03:22:42.897867','2024-05-12 03:22:42.897867',3,1);
/*!40000 ALTER TABLE `blog_app_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_app_case`
--

DROP TABLE IF EXISTS `case_app_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_app_case` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `pay_in_advance` decimal(10,2) NOT NULL,
  `due` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `client_id` bigint NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `case_app_case_client_id_fc3d1d22_fk_accounts_app_client_id` (`client_id`),
  KEY `case_app_case_lawyer_id_19ac30df_fk_accounts_app_lawyer_id` (`lawyer_id`),
  CONSTRAINT `case_app_case_client_id_fc3d1d22_fk_accounts_app_client_id` FOREIGN KEY (`client_id`) REFERENCES `accounts_app_client` (`id`),
  CONSTRAINT `case_app_case_lawyer_id_19ac30df_fk_accounts_app_lawyer_id` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_app_case`
--

LOCK TABLES `case_app_case` WRITE;
/*!40000 ALTER TABLE `case_app_case` DISABLE KEYS */;
INSERT INTO `case_app_case` VALUES (6,'Civil Case','TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST','2024-05-12','2024-05-15',240.00,560.00,800.00,'2024-05-12 13:36:57.998161','2024-05-12 13:36:57.998161',3,3);
/*!40000 ALTER TABLE `case_app_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_app_casefile`
--

DROP TABLE IF EXISTS `case_app_casefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_app_casefile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `case_id` bigint NOT NULL,
  `uploaded_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `case_app_casefile_case_id_ed94a8da_fk_case_app_case_id` (`case_id`),
  KEY `case_app_casefile_uploaded_by_id_6cb87f6f_fk_accounts_` (`uploaded_by_id`),
  CONSTRAINT `case_app_casefile_case_id_ed94a8da_fk_case_app_case_id` FOREIGN KEY (`case_id`) REFERENCES `case_app_case` (`id`),
  CONSTRAINT `case_app_casefile_uploaded_by_id_6cb87f6f_fk_accounts_` FOREIGN KEY (`uploaded_by_id`) REFERENCES `accounts_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_app_casefile`
--

LOCK TABLES `case_app_casefile` WRITE;
/*!40000 ALTER TABLE `case_app_casefile` DISABLE KEYS */;
INSERT INTO `case_app_casefile` VALUES (3,'case_files/invoice_3_1.pdf','TEST','2024-05-12 13:52:23.522364',6,5),(4,'case_files/invoice_1.pdf','TEST2','2024-05-12 13:52:38.962014',6,5),(5,'case_files/invoice_6.pdf','invoice','2024-05-12 13:55:05.356135',6,9);
/*!40000 ALTER TABLE `case_app_casefile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_app_closedcase`
--

DROP TABLE IF EXISTS `case_app_closedcase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_app_closedcase` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `closed_at` datetime(6) NOT NULL,
  `rating` int DEFAULT NULL,
  `review` longtext,
  `feedback` longtext,
  `case_id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `case_id` (`case_id`),
  KEY `case_app_closedcase_client_id_e5606616_fk_accounts_app_client_id` (`client_id`),
  KEY `case_app_closedcase_lawyer_id_663fc360_fk_accounts_app_lawyer_id` (`lawyer_id`),
  CONSTRAINT `case_app_closedcase_case_id_5b157900_fk_case_app_case_id` FOREIGN KEY (`case_id`) REFERENCES `case_app_case` (`id`),
  CONSTRAINT `case_app_closedcase_client_id_e5606616_fk_accounts_app_client_id` FOREIGN KEY (`client_id`) REFERENCES `accounts_app_client` (`id`),
  CONSTRAINT `case_app_closedcase_lawyer_id_663fc360_fk_accounts_app_lawyer_id` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_app_closedcase`
--

LOCK TABLES `case_app_closedcase` WRITE;
/*!40000 ALTER TABLE `case_app_closedcase` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_app_closedcase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_app_message`
--

DROP TABLE IF EXISTS `chat_app_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_app_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `room_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_app_message_room_id_42b1602b_fk_lawyer_app_room_id` (`room_id`),
  KEY `chat_app_message_sender_id_03c5fae9_fk_accounts_` (`sender_id`),
  CONSTRAINT `chat_app_message_room_id_42b1602b_fk_lawyer_app_room_id` FOREIGN KEY (`room_id`) REFERENCES `lawyer_app_room` (`id`),
  CONSTRAINT `chat_app_message_sender_id_03c5fae9_fk_accounts_` FOREIGN KEY (`sender_id`) REFERENCES `accounts_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_app_message`
--

LOCK TABLES `chat_app_message` WRITE;
/*!40000 ALTER TABLE `chat_app_message` DISABLE KEYS */;
INSERT INTO `chat_app_message` VALUES (3,'Hello I AM LAWYER','2024-05-12 04:53:42.852700',2,4),(4,'HELLO I AM CLIENT','2024-05-12 04:53:58.368877',2,3),(5,'Hello I AM LAWYER','2024-05-12 14:04:52.250129',3,5);
/*!40000 ALTER TABLE `chat_app_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_app_consultationrequest`
--

DROP TABLE IF EXISTS `client_app_consultationrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_app_consultationrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `problem` longtext NOT NULL,
  `document` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) NOT NULL,
  `is_accepted` tinyint(1) NOT NULL,
  `client_id` bigint NOT NULL,
  `consultation_post_id` bigint NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_app_consultationrequest_client_id_lawyer_id_6b381fc6_uniq` (`client_id`,`lawyer_id`),
  KEY `client_app_consultat_consultation_post_id_eda240ff_fk_lawyer_ap` (`consultation_post_id`),
  KEY `client_app_consultat_lawyer_id_6c6cb096_fk_accounts_` (`lawyer_id`),
  CONSTRAINT `client_app_consultat_client_id_0a3c593e_fk_accounts_` FOREIGN KEY (`client_id`) REFERENCES `accounts_app_client` (`id`),
  CONSTRAINT `client_app_consultat_consultation_post_id_eda240ff_fk_lawyer_ap` FOREIGN KEY (`consultation_post_id`) REFERENCES `lawyer_app_consultationpost` (`id`),
  CONSTRAINT `client_app_consultat_lawyer_id_6c6cb096_fk_accounts_` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_app_consultationrequest`
--

LOCK TABLES `client_app_consultationrequest` WRITE;
/*!40000 ALTER TABLE `client_app_consultationrequest` DISABLE KEYS */;
INSERT INTO `client_app_consultationrequest` VALUES (6,'HELP','documents/partho.jpeg','2024-05-12 14:02:53.354904','pending',0,3,2,2);
/*!40000 ALTER TABLE `client_app_consultationrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_app_contact`
--

DROP TABLE IF EXISTS `core_app_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_app_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(55) NOT NULL,
  `name` varchar(20) NOT NULL,
  `phone` int NOT NULL,
  `queries` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_app_contact`
--

LOCK TABLES `core_app_contact` WRITE;
/*!40000 ALTER TABLE `core_app_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_app_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_app_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_app_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_app_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-05-11 06:55:10.417005','1','University of Oxford - Faculty of Law',1,'[{\"added\": {}}]',7,1),(2,'2024-05-11 06:55:19.130457','2','University of Cambridge - Faculty of Law',1,'[{\"added\": {}}]',7,1),(3,'2024-05-11 06:55:24.401116','3','London School of Economics and Political Science (LSE) - Department of Law',1,'[{\"added\": {}}]',7,1),(4,'2024-05-11 06:55:28.908593','4','King\'s College London - The Dickson Poon School of Law',1,'[{\"added\": {}}]',7,1),(5,'2024-05-11 06:55:33.452846','5','University College London (UCL) - Faculty of Laws',1,'[{\"added\": {}}]',7,1),(6,'2024-05-11 06:55:38.813380','6','University of Edinburgh - School of Law',1,'[{\"added\": {}}]',7,1),(7,'2024-05-11 06:55:43.984966','7','University of Glasgow - School of Law',1,'[{\"added\": {}}]',7,1),(8,'2024-05-11 06:55:48.637231','8','University of Durham - Durham Law School',1,'[{\"added\": {}}]',7,1),(9,'2024-05-11 06:55:52.594158','9','University of Bristol - School of Law',1,'[{\"added\": {}}]',7,1),(10,'2024-05-11 06:55:57.833059','10','University of Nottingham - School of Law',1,'[{\"added\": {}}]',7,1),(11,'2024-05-11 06:56:02.607409','11','University of York - York Law School',1,'[{\"added\": {}}]',7,1),(12,'2024-05-11 06:56:06.680371','12','Queen Mary University of London - School of Law',1,'[{\"added\": {}}]',7,1),(13,'2024-05-11 06:56:11.968066','13','University of Warwick - School of Law',1,'[{\"added\": {}}]',7,1),(14,'2024-05-11 06:56:16.107180','14','University of Manchester - School of Law',1,'[{\"added\": {}}]',7,1),(15,'2024-05-11 06:56:20.410157','15','University of Sheffield - School of Law',1,'[{\"added\": {}}]',7,1),(16,'2024-05-11 06:56:25.364762','16','University of Birmingham - Birmingham Law School',1,'[{\"added\": {}}]',7,1),(17,'2024-05-11 06:56:30.932737','17','University of Exeter - Law School',1,'[{\"added\": {}}]',7,1),(18,'2024-05-11 06:56:35.748838','18','University of Southampton - School of Law',1,'[{\"added\": {}}]',7,1),(19,'2024-05-11 06:56:40.390421','19','University of Leeds - School of Law',1,'[{\"added\": {}}]',7,1),(20,'2024-05-11 06:56:45.190574','20','University of Sussex - Sussex Law School',1,'[{\"added\": {}}]',7,1),(21,'2024-05-11 06:56:51.730146','21','University of Dhaka - Department of Law',1,'[{\"added\": {}}]',7,1),(22,'2024-05-11 06:56:55.798110','22','University of Rajshahi - Department of Law',1,'[{\"added\": {}}]',7,1),(23,'2024-05-11 06:57:00.601270','23','University of Chittagong - Faculty of Law',1,'[{\"added\": {}}]',7,1),(24,'2024-05-11 06:57:04.669983','24','Jahangirnagar University - Department of Law and Justice',1,'[{\"added\": {}}]',7,1),(25,'2024-05-11 06:57:09.504134','25','Islamic University, Bangladesh - Department of Law',1,'[{\"added\": {}}]',7,1),(26,'2024-05-11 06:57:14.177165','26','Bangladesh University of Professionals (BUP) - Department of Law',1,'[{\"added\": {}}]',7,1),(27,'2024-05-11 06:57:19.292036','27','BRAC University - School of Law',1,'[{\"added\": {}}]',7,1),(28,'2024-05-11 06:57:24.828197','28','North South University - Department of Law',1,'[{\"added\": {}}]',7,1),(29,'2024-05-11 06:57:29.585028','29','Independent University, Bangladesh (IUB) - School of Law',1,'[{\"added\": {}}]',7,1),(30,'2024-05-11 06:57:37.548925','30','American International University-Bangladesh (AIUB) - Faculty of Arts and Social Sciences, Departmen',1,'[{\"added\": {}}]',7,1),(31,'2024-05-11 06:57:46.613508','31','ASA University Bangladesh - Faculty of Law',1,'[{\"added\": {}}]',7,1),(32,'2024-05-11 06:58:06.684875','1','Criminal Law',1,'[{\"added\": {}}]',8,1),(33,'2024-05-11 06:58:12.276107','2','Civil Rights Law',1,'[{\"added\": {}}]',8,1),(34,'2024-05-11 06:58:17.549043','3','Corporate Law',1,'[{\"added\": {}}]',8,1),(35,'2024-05-11 06:58:24.211784','4','Intellectual Property Law',1,'[{\"added\": {}}]',8,1),(36,'2024-05-11 06:58:29.566939','5','Family Law',1,'[{\"added\": {}}]',8,1),(37,'2024-05-11 06:58:34.899797','6','Real Estate Law',1,'[{\"added\": {}}]',8,1),(38,'2024-05-11 06:58:40.529668','7','Environmental Law',1,'[{\"added\": {}}]',8,1),(39,'2024-05-11 06:58:46.048811','8','Employment and Labor Law',1,'[{\"added\": {}}]',8,1),(40,'2024-05-11 06:58:51.577341','9','Tax Law',1,'[{\"added\": {}}]',8,1),(41,'2024-05-11 06:58:59.038322','10','Bankruptcy Law',1,'[{\"added\": {}}]',8,1),(42,'2024-05-11 06:59:04.671650','11','Immigration Law',1,'[{\"added\": {}}]',8,1),(43,'2024-05-11 06:59:10.570555','12','International Law',1,'[{\"added\": {}}]',8,1),(44,'2024-05-11 06:59:18.340179','13','Constitutional Law',1,'[{\"added\": {}}]',8,1),(45,'2024-05-11 06:59:24.561476','14','Personal Injury Law',1,'[{\"added\": {}}]',8,1),(46,'2024-05-11 06:59:29.917924','15','Medical Malpractice Law',1,'[{\"added\": {}}]',8,1),(47,'2024-05-11 06:59:34.942689','16','Antitrust Law',1,'[{\"added\": {}}]',8,1),(48,'2024-05-11 06:59:39.510550','17','Entertainment Law',1,'[{\"added\": {}}]',8,1),(49,'2024-05-11 06:59:44.295540','18','Sports Law',1,'[{\"added\": {}}]',8,1),(50,'2024-05-11 06:59:50.088092','19','Human Rights Law',1,'[{\"added\": {}}]',8,1),(51,'2024-05-11 06:59:54.722882','20','Military Law',1,'[{\"added\": {}}]',8,1),(52,'2024-05-11 06:59:59.602539','21','Construction Law',1,'[{\"added\": {}}]',8,1),(53,'2024-05-11 07:00:03.836651','22','Trusts and Estates Law',1,'[{\"added\": {}}]',8,1),(54,'2024-05-11 07:00:08.565490','23','Health Care Law',1,'[{\"added\": {}}]',8,1),(55,'2024-05-11 07:00:14.109590','24','Maritime Law',1,'[{\"added\": {}}]',8,1),(56,'2024-05-11 07:00:20.618414','25','Education Law',1,'[{\"added\": {}}]',8,1),(57,'2024-05-11 07:00:25.933146','26','Consumer Protection Law',1,'[{\"added\": {}}]',8,1),(58,'2024-05-11 07:00:30.714317','27','Elder Law',1,'[{\"added\": {}}]',8,1),(59,'2024-05-11 07:00:38.769388','28','Alternative Dispute Resolution (ADR)',1,'[{\"added\": {}}]',8,1),(60,'2024-05-11 07:00:43.832295','29','Insurance Law',1,'[{\"added\": {}}]',8,1),(61,'2024-05-11 07:00:51.720257','30','Technology Law',1,'[{\"added\": {}}]',8,1),(62,'2024-05-11 12:17:25.768278','1','Invoice 1 for client@gmail.com - unpaid',3,'',19,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (10,'accounts_app','client'),(7,'accounts_app','colleges'),(9,'accounts_app','customuser'),(8,'accounts_app','expertise'),(11,'accounts_app','lawyer'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(19,'billing_app','invoice'),(17,'blog_app','blogpost'),(18,'blog_app','comment'),(22,'case_app','case'),(23,'case_app','casefile'),(24,'case_app','closedcase'),(12,'chat_app','message'),(16,'client_app','consultationrequest'),(4,'contenttypes','contenttype'),(6,'core_app','contact'),(13,'lawyer_app','acceptedclient'),(14,'lawyer_app','consultationpost'),(15,'lawyer_app','room'),(20,'lawyerchatbot','chat'),(21,'lawyerchatbot','lawexplainer'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-05-11 06:52:40.080464'),(2,'contenttypes','0002_remove_content_type_name','2024-05-11 06:52:40.264054'),(3,'auth','0001_initial','2024-05-11 06:52:41.011611'),(4,'auth','0002_alter_permission_name_max_length','2024-05-11 06:52:41.176563'),(5,'auth','0003_alter_user_email_max_length','2024-05-11 06:52:41.188895'),(6,'auth','0004_alter_user_username_opts','2024-05-11 06:52:41.201690'),(7,'auth','0005_alter_user_last_login_null','2024-05-11 06:52:41.216298'),(8,'auth','0006_require_contenttypes_0002','2024-05-11 06:52:41.221453'),(9,'auth','0007_alter_validators_add_error_messages','2024-05-11 06:52:41.234788'),(10,'auth','0008_alter_user_username_max_length','2024-05-11 06:52:41.250908'),(11,'auth','0009_alter_user_last_name_max_length','2024-05-11 06:52:41.267821'),(12,'auth','0010_alter_group_name_max_length','2024-05-11 06:52:41.307124'),(13,'auth','0011_update_proxy_permissions','2024-05-11 06:52:41.324232'),(14,'auth','0012_alter_user_first_name_max_length','2024-05-11 06:52:41.340197'),(15,'accounts_app','0001_initial','2024-05-11 06:52:43.051123'),(16,'admin','0001_initial','2024-05-11 06:52:43.441129'),(17,'admin','0002_logentry_remove_auto_add','2024-05-11 06:52:43.454496'),(18,'admin','0003_logentry_add_action_flag_choices','2024-05-11 06:52:43.472160'),(19,'billing_app','0001_initial','2024-05-11 06:52:43.854854'),(20,'billing_app','0002_invoice_card_last_four_invoice_payment_reference','2024-05-11 06:52:43.981039'),(21,'blog_app','0001_initial','2024-05-11 06:52:44.562624'),(22,'case_app','0001_initial','2024-05-11 06:52:45.879476'),(23,'lawyer_app','0001_initial','2024-05-11 06:52:46.425284'),(24,'lawyer_app','0002_room','2024-05-11 06:52:46.777978'),(25,'lawyer_app','0003_alter_room_id_alter_room_lawyer','2024-05-11 06:52:46.985391'),(26,'chat_app','0001_initial','2024-05-11 06:52:47.305134'),(27,'chat_app','0002_alter_message_options_and_more','2024-05-11 06:52:47.405428'),(28,'client_app','0001_initial','2024-05-11 06:52:47.918132'),(29,'core_app','0001_initial','2024-05-11 06:52:47.957941'),(30,'lawyerchatbot','0001_initial','2024-05-11 06:52:48.201330'),(31,'lawyerchatbot','0002_lawexplainer','2024-05-11 06:52:48.242271'),(32,'sessions','0001_initial','2024-05-11 06:52:48.359858'),(33,'billing_app','0003_invoice_case','2024-05-11 10:55:10.549897');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('5ipegoxxi8w3fn3eukc1tsmc133la4gv','.eJxVjMsOwiAQRf-FtSEFpjxcuvcbyMBMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJM4mz8OL0uyXMD647oDvWW5O51XWZk9wVedAur434eTncv4OCvXxrxT6RsXkaR0ZLWtukhzAN3ifDrHRyaF1wBjxYQA0hOFCKDSkgZyyJ9wfgWDcm:1s6H3i:-IFrW7S4UVTp-aC9LMxdSPFzvHx3TQ9r_t2yunsaFeQ','2024-05-26 21:48:42.221720'),('o7utwgh53m95xxq55bqbjp773kqhn2e4','.eJxVjMsOwiAQRf-FtSG8QZfu-w1kYBipGkhKuzL-uzbpQrf3nHNfLMK21riNssQZ2YVZdvrdEuRHaTvAO7Rb57m3dZkT3xV-0MGnjuV5Pdy_gwqjfmuwZI0BLZXQWWBAIBIBCtnisIjkHZ2FyZ6c9C4kAsioUJFKRgodAnt_AABNOIo:1s69ob:CBVt2Os4f8Iqnr-mZYQkMAKSJOem4GlKdOqTdlSvqf8','2024-05-26 14:04:37.179878'),('t8tgkogmiex27sddcxfbep7j3znnigqv','.eJxVjE0OwiAYBe_C2hAoCMWle89Avr9K1dCktCvj3W2TLnT7Zua9VYZ1KXltMueR1UUldfrdEOgpdQf8gHqfNE11mUfUu6IP2vRtYnldD_fvoEArW21ZTG-cOwMl9OKsJU7kGYfkQ0QTfOg9G9MZDF4obRJT4BAHAOxcVJ8v5Is4AA:1s6ATK:f5QG3Ob8d9zp9FvwNk4363QyDqbOSiIabnP-AU0rB6Y','2024-05-26 14:46:42.205412');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lawyer_app_acceptedclient`
--

DROP TABLE IF EXISTS `lawyer_app_acceptedclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lawyer_app_acceptedclient` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `client_id` bigint NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lawyer_app_acceptedc_client_id_529641fe_fk_accounts_` (`client_id`),
  KEY `lawyer_app_acceptedc_lawyer_id_972f82a5_fk_accounts_` (`lawyer_id`),
  CONSTRAINT `lawyer_app_acceptedc_client_id_529641fe_fk_accounts_` FOREIGN KEY (`client_id`) REFERENCES `accounts_app_client` (`id`),
  CONSTRAINT `lawyer_app_acceptedc_lawyer_id_972f82a5_fk_accounts_` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lawyer_app_acceptedclient`
--

LOCK TABLES `lawyer_app_acceptedclient` WRITE;
/*!40000 ALTER TABLE `lawyer_app_acceptedclient` DISABLE KEYS */;
INSERT INTO `lawyer_app_acceptedclient` VALUES (2,'2024-05-12 04:47:56.833845',1,2),(3,'2024-05-12 13:17:13.308331',3,3);
/*!40000 ALTER TABLE `lawyer_app_acceptedclient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lawyer_app_consultationpost`
--

DROP TABLE IF EXISTS `lawyer_app_consultationpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lawyer_app_consultationpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `years_of_experience` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `consultation_fee` decimal(10,2) NOT NULL,
  `available_from` time(6) NOT NULL,
  `available_to` time(6) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lawyer_id` (`lawyer_id`),
  CONSTRAINT `lawyer_app_consultat_lawyer_id_b59902fc_fk_accounts_` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`),
  CONSTRAINT `lawyer_app_consultationpost_chk_1` CHECK ((`years_of_experience` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lawyer_app_consultationpost`
--

LOCK TABLES `lawyer_app_consultationpost` WRITE;
/*!40000 ALTER TABLE `lawyer_app_consultationpost` DISABLE KEYS */;
INSERT INTO `lawyer_app_consultationpost` VALUES (1,3,'2024-05-11 08:06:21.507026',600.00,'17:00:00.000000','21:00:00.000000',1,1),(2,6,'2024-05-12 04:23:32.791982',30.00,'12:00:00.000000','14:00:00.000000',1,2),(5,10,'2024-05-12 13:34:50.794541',200.00,'19:34:00.000000','21:00:00.000000',1,3);
/*!40000 ALTER TABLE `lawyer_app_consultationpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lawyer_app_room`
--

DROP TABLE IF EXISTS `lawyer_app_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lawyer_app_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `client_id` bigint NOT NULL,
  `lawyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lawyer_app_room_client_id_02a650e2_fk_accounts_app_client_id` (`client_id`),
  KEY `lawyer_app_room_lawyer_id_132edf20_fk_accounts_app_lawyer_id` (`lawyer_id`),
  CONSTRAINT `lawyer_app_room_client_id_02a650e2_fk_accounts_app_client_id` FOREIGN KEY (`client_id`) REFERENCES `accounts_app_client` (`id`),
  CONSTRAINT `lawyer_app_room_lawyer_id_132edf20_fk_accounts_app_lawyer_id` FOREIGN KEY (`lawyer_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lawyer_app_room`
--

LOCK TABLES `lawyer_app_room` WRITE;
/*!40000 ALTER TABLE `lawyer_app_room` DISABLE KEYS */;
INSERT INTO `lawyer_app_room` VALUES (2,'Chat','2024-05-12 04:53:27.794744',1,2),(3,'Chat','2024-05-12 14:04:37.052622',3,3);
/*!40000 ALTER TABLE `lawyer_app_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lawyerchatbot_chat`
--

DROP TABLE IF EXISTS `lawyerchatbot_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lawyerchatbot_chat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `response` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lawyerchatbot_chat_user_id_e26ecc82_fk_accounts_app_lawyer_id` (`user_id`),
  CONSTRAINT `lawyerchatbot_chat_user_id_e26ecc82_fk_accounts_app_lawyer_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_app_lawyer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lawyerchatbot_chat`
--

LOCK TABLES `lawyerchatbot_chat` WRITE;
/*!40000 ALTER TABLE `lawyerchatbot_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `lawyerchatbot_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_law_explainer`
--

DROP TABLE IF EXISTS `t_law_explainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_law_explainer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `_input` longtext NOT NULL,
  `_output` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_law_explainer`
--

LOCK TABLES `t_law_explainer` WRITE;
/*!40000 ALTER TABLE `t_law_explainer` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_law_explainer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-13 21:44:21
