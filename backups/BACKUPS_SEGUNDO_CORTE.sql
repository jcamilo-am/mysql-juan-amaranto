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
  `municipality` varchar(255) NOT NULL,
  `neighborhood` varchar(255) NOT NULL,
  `avenue` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Bogotá','Chapinero','Carrera 13','Calle 57','Cerca del parque de la 93'),(2,'Medellín','El Poblado','Avenida El Poblado','Calle 10','Zona comercial'),(3,'Cali','Granada','Carrera 5','Calle 15','Zona residencial'),(4,'Barranquilla','El Prado','Carrera 50','Calle 70','Zona histórica');
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
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address_id` int NOT NULL,
  `legal_status` enum('Formal','Informal') NOT NULL,
  `nit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `business_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'Negocio A','Venta de productos electrónicos','3101234567',1,'Formal','900123456'),(2,'Negocio B','Servicios de limpieza','3119876543',2,'Informal',NULL),(3,'Negocio C','Comida rápida','3123456789',3,'Formal','900654321');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guarantee`
--

DROP TABLE IF EXISTS `guarantee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guarantee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int NOT NULL,
  `type` enum('Property','Vehicle','Object','Other') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `estimated_value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `guarantee_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guarantee`
--

LOCK TABLES `guarantee` WRITE;
/*!40000 ALTER TABLE `guarantee` DISABLE KEYS */;
INSERT INTO `guarantee` VALUES (1,1,'Property','Casa en Chapinero',300000.00),(2,3,'Vehicle','Automóvil Toyota',20000.00);
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
  `client_id` int NOT NULL,
  `guarantor_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `interest` decimal(5,2) NOT NULL,
  `total_value` decimal(10,2) GENERATED ALWAYS AS ((`amount` + ((`amount` * `interest`) / 100))) STORED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `payment_frequency` enum('Daily','Weekly','Biweekly','Monthly','Quarterly') NOT NULL,
  `origin_id` int DEFAULT NULL,
  `status` enum('Completed','Asset','Overdue','Canceled') NOT NULL,
  `type` enum('Original','Refinanced') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `guarantor_id` (`guarantor_id`),
  KEY `origin_id` (`origin_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `person` (`id`),
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`guarantor_id`) REFERENCES `person` (`id`),
  CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`origin_id`) REFERENCES `loan` (`id`),
  CONSTRAINT `loan_chk_1` CHECK ((`amount` > 0)),
  CONSTRAINT `loan_chk_2` CHECK ((`interest` between 0 and 20))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` (`id`, `client_id`, `guarantor_id`, `amount`, `interest`, `start_date`, `end_date`, `payment_frequency`, `origin_id`, `status`, `type`) VALUES (1,1,3,500000.00,12.50,'2024-01-01','2024-12-31','Monthly',NULL,'Completed','Original'),(2,2,NULL,250000.00,10.00,'2024-02-01','2024-11-01','Weekly',NULL,'Asset','Original'),(3,1,2,150000.00,15.00,'2024-03-01','2025-03-01','Biweekly',NULL,'Overdue','Refinanced');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `status` enum('Completed','Pending','Failed') DEFAULT NULL,
  `loan_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`),
  CONSTRAINT `payment_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,50000.00,'2024-02-01','Completed',1),(2,25000.00,'2024-04-01','Pending',2),(3,75000.00,'2024-03-15','Failed',3);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_collector`
--

DROP TABLE IF EXISTS `payment_collector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_collector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `collector_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_id` (`payment_id`),
  KEY `collector_id` (`collector_id`),
  CONSTRAINT `payment_collector_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_collector_ibfk_2` FOREIGN KEY (`collector_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_collector`
--

LOCK TABLES `payment_collector` WRITE;
/*!40000 ALTER TABLE `payment_collector` DISABLE KEYS */;
INSERT INTO `payment_collector` VALUES (1,1,4),(2,2,4);
/*!40000 ALTER TABLE `payment_collector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_validation`
--

DROP TABLE IF EXISTS `payment_validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_validation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `administrator_id` int NOT NULL,
  `date_validation` date NOT NULL,
  `comment` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_id` (`payment_id`),
  KEY `administrator_id` (`administrator_id`),
  CONSTRAINT `payment_validation_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_validation_ibfk_2` FOREIGN KEY (`administrator_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_validation`
--

LOCK TABLES `payment_validation` WRITE;
/*!40000 ALTER TABLE `payment_validation` DISABLE KEYS */;
INSERT INTO `payment_validation` VALUES (1,1,5,'2024-02-05','Pago verificado'),(2,2,5,'2024-04-05','Pago pendiente por revisión');
/*!40000 ALTER TABLE `payment_validation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `document` varchar(10) NOT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `phone` varchar(10) NOT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `date_birth` date NOT NULL,
  `role_id` int NOT NULL,
  `address_id` int NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `date_hiring` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `role_id` (`role_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `person_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Juan','Pérez','1234567890','Male','3001234567','juan.perez@example.com','1985-06-15',2,1,'juanp','pass123',1500.00,'2020-01-10'),(2,'María','Gómez','0987654321','Female','3109876543','maria.gomez@example.com','1990-08-20',1,2,'mariag','pass456',NULL,NULL),(3,'Carlos','López','1231231234','Male','3205551212','carlos.lopez@example.com','1980-04-10',3,3,'carlosl','pass789',NULL,NULL),(4,'Ana','Martínez','3213213210','Female','3304445656','ana.martinez@example.com','1975-11-30',4,4,'anam','pass321',NULL,NULL),(5,'Javier','Sánchez','4564564567','Male','3403337878','javier.sanchez@example.com','1995-03-15',5,1,'javiers','pass654',NULL,'2022-02-15');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'User'),(2,'Client'),(3,'Guarantor'),(4,'Collector'),(5,'Administrator');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-16 19:51:14
