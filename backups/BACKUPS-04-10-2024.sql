-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: loan_manager
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `neighborhood` varchar(50) DEFAULT NULL,
  `avenue` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Los Cedros','Av. 1','Calle 5','Barrio residencial con zonas verdes'),(2,'El Centro','Calle 2','Calle 10','Zona comercial con alta afluencia'),(3,'La Loma','Av. 3','Calle 12','Barrio tranquilo con vista a la montaña');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `owner_name` varchar(50) DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `legal_status` enum('Formal','Informal','Registered','In Process') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `business_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `business_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'Panadería Mocoa','3112345678','Panadería artesanal con variedad de productos',1,'Juan Pérez',1,'Formal'),(2,'Restaurante La Montaña','3145678901','Restaurante típico con platos locales',2,'María Gómez',2,'Registered'),(3,'Ferretería El Progreso','3156789012','Ferretería con todo tipo de herramientas',3,'Luis Rodríguez',3,'Informal');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employment`
--

DROP TABLE IF EXISTS `employment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `business_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `employment_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`),
  CONSTRAINT `employment_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employment`
--

LOCK TABLES `employment` WRITE;
/*!40000 ALTER TABLE `employment` DISABLE KEYS */;
INSERT INTO `employment` VALUES (1,'Panadero con experiencia de 5 años',1,1),(2,'Mesera con excelente atención al cliente',2,2),(3,'Vendedor de herramientas y asesor',3,3);
/*!40000 ALTER TABLE `employment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guarantee`
--

DROP TABLE IF EXISTS `guarantee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guarantee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `guarantee_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guarantee`
--

LOCK TABLES `guarantee` WRITE;
/*!40000 ALTER TABLE `guarantee` DISABLE KEYS */;
INSERT INTO `guarantee` VALUES (1,1,'Prenda',2000000.00,'Vehículo de propiedad del prestatario','2023-01-01'),(2,2,'Hipoteca',1000000.00,'Casa de propiedad del prestatario','2023-02-01'),(3,3,'Fiador',5000000.00,'Fiador solidario','2023-03-01');
/*!40000 ALTER TABLE `guarantee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `guarantor_id` int DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `interest_rate` decimal(4,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `payment_amount` decimal(12,2) DEFAULT NULL,
  `payment_frequency` enum('Daily','Weekly','Biweekly','Monthly') DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT NULL,
  `previous_loan_id` int DEFAULT NULL,
  `type` tinyint(1) DEFAULT '0',
  `status` enum('Active','Cancelled','Completed') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,1,NULL,5000000.00,10.50,'2023-01-01','2024-01-01',500000.00,'Monthly',5000000.00,NULL,0,'Active'),(2,2,1,3000000.00,12.00,'2023-02-01','2024-02-01',300000.00,'Biweekly',3000000.00,NULL,0,'Active'),(3,3,NULL,10000000.00,9.50,'2023-03-01','2024-03-01',1000000.00,'Monthly',10000000.00,NULL,0,'Active');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_collector`
--

DROP TABLE IF EXISTS `loan_collector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_collector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collector_id` int DEFAULT NULL,
  `loan_id` int DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collector_id` (`collector_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `loan_collector_ibfk_1` FOREIGN KEY (`collector_id`) REFERENCES `people` (`id`),
  CONSTRAINT `loan_collector_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_collector`
--

LOCK TABLES `loan_collector` WRITE;
/*!40000 ALTER TABLE `loan_collector` DISABLE KEYS */;
INSERT INTO `loan_collector` VALUES (1,2,1,'2023-02-05'),(2,1,2,'2023-03-20'),(3,3,3,'2023-04-15');
/*!40000 ALTER TABLE `loan_collector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,500000.00,'2023-02-01'),(2,2,300000.00,'2023-03-15'),(3,3,1000000.00,'2023-04-01');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `document` varchar(10) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role` enum('Administrador','Cobrador','Cliente') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `password` (`password`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `people_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Juan','Pérez','123456789','3216549870','juan.perez@email.com',1,'juanp','password123','Cliente'),(2,'María','Gómez','987654321','3101234567','maria.gomez@email.com',2,'mariag','password456','Cobrador'),(3,'Luis','Rodríguez','456123789','3009876543','luis.rodriguez@email.com',3,'luisr','password789','Administrador');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-04 21:06:44
