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
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `ClienteID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Documento` varchar(10) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `DireccionID` int DEFAULT NULL,
  `NegocioID` int DEFAULT NULL,
  `TrabajoID` int DEFAULT NULL,
  PRIMARY KEY (`ClienteID`),
  KEY `DireccionID` (`DireccionID`),
  KEY `NegocioID` (`NegocioID`),
  KEY `TrabajoID` (`TrabajoID`),
  CONSTRAINT `Cliente_ibfk_1` FOREIGN KEY (`DireccionID`) REFERENCES `Direccion` (`DireccionID`),
  CONSTRAINT `Cliente_ibfk_2` FOREIGN KEY (`NegocioID`) REFERENCES `Negocio` (`NegocioID`),
  CONSTRAINT `Cliente_ibfk_3` FOREIGN KEY (`TrabajoID`) REFERENCES `Trabajo` (`TrabajoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'Jorge','Martínez','2233445566','3002233445',1,1,1),(2,'Laura','Ríos','3344556677','3003344556',2,2,2),(3,'Ana','Vásquez','4455667788','3004455667',3,3,3);
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CobradorPrestamo`
--

DROP TABLE IF EXISTS `CobradorPrestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CobradorPrestamo` (
  `CobradorPrestamoID` int NOT NULL AUTO_INCREMENT,
  `CobradorID` int DEFAULT NULL,
  `PrestamoID` int DEFAULT NULL,
  `FechaCobro` date DEFAULT NULL,
  PRIMARY KEY (`CobradorPrestamoID`),
  KEY `CobradorID` (`CobradorID`),
  KEY `PrestamoID` (`PrestamoID`),
  CONSTRAINT `CobradorPrestamo_ibfk_1` FOREIGN KEY (`CobradorID`) REFERENCES `Usuario` (`UsuarioID`),
  CONSTRAINT `CobradorPrestamo_ibfk_2` FOREIGN KEY (`PrestamoID`) REFERENCES `Prestamo` (`PrestamoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CobradorPrestamo`
--

LOCK TABLES `CobradorPrestamo` WRITE;
/*!40000 ALTER TABLE `CobradorPrestamo` DISABLE KEYS */;
INSERT INTO `CobradorPrestamo` VALUES (1,2,1,'2024-01-31'),(2,2,2,'2024-02-15'),(3,3,3,'2024-03-31');
/*!40000 ALTER TABLE `CobradorPrestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Direccion`
--

DROP TABLE IF EXISTS `Direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Direccion` (
  `DireccionID` int NOT NULL AUTO_INCREMENT,
  `Barrio` varchar(50) DEFAULT NULL,
  `Carrera` varchar(50) DEFAULT NULL,
  `Calle` varchar(50) DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DireccionID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Direccion`
--

LOCK TABLES `Direccion` WRITE;
/*!40000 ALTER TABLE `Direccion` DISABLE KEYS */;
INSERT INTO `Direccion` VALUES (1,'Centro','Carrera 10','Calle 20','Oficina principal'),(2,'Suburbio','Carrera 12','Calle 30','Sucursal secundaria'),(3,'Zona Rural','Carrera 15','Calle 40','Oficina en la zona rural');
/*!40000 ALTER TABLE `Direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Garantia`
--

DROP TABLE IF EXISTS `Garantia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Garantia` (
  `GarantiaID` int NOT NULL AUTO_INCREMENT,
  `PrestamoID` int DEFAULT NULL,
  `Tipo` varchar(255) DEFAULT NULL,
  `Valor` decimal(12,2) DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `FechaRegistro` date DEFAULT NULL,
  PRIMARY KEY (`GarantiaID`),
  KEY `PrestamoID` (`PrestamoID`),
  CONSTRAINT `Garantia_ibfk_1` FOREIGN KEY (`PrestamoID`) REFERENCES `Prestamo` (`PrestamoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Garantia`
--

LOCK TABLES `Garantia` WRITE;
/*!40000 ALTER TABLE `Garantia` DISABLE KEYS */;
INSERT INTO `Garantia` VALUES (1,1,'Vehículo',6000.00,'Automóvil marca X','2024-01-02'),(2,2,'Inmueble',3500.00,'Apartamento en el centro','2024-02-02'),(3,3,'Joyas',2000.00,'Conjunto de joyas antiguas','2024-03-02');
/*!40000 ALTER TABLE `Garantia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Negocio`
--

DROP TABLE IF EXISTS `Negocio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Negocio` (
  `NegocioID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Propietario` varchar(50) DEFAULT NULL,
  `DireccionID` int DEFAULT NULL,
  `EstadoLegal` enum('Formal','Informal','Registrado','En Proceso') DEFAULT NULL,
  PRIMARY KEY (`NegocioID`),
  KEY `DireccionID` (`DireccionID`),
  CONSTRAINT `Negocio_ibfk_1` FOREIGN KEY (`DireccionID`) REFERENCES `Direccion` (`DireccionID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Negocio`
--

LOCK TABLES `Negocio` WRITE;
/*!40000 ALTER TABLE `Negocio` DISABLE KEYS */;
INSERT INTO `Negocio` VALUES (1,'Librería El Saber','1234567890','Venta de libros y material educativo','Ana Pérez',1,'Formal'),(2,'Café del Parque','0987654321','Café con ambiente familiar','Luis Gómez',2,'Registrado'),(3,'Ferretería El Clavo','1122334455','Suministros de ferretería','Carlos Ruiz',3,'Informal');
/*!40000 ALTER TABLE `Negocio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pago`
--

DROP TABLE IF EXISTS `Pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pago` (
  `PagoID` int NOT NULL AUTO_INCREMENT,
  `PrestamoID` int DEFAULT NULL,
  `Monto` decimal(12,2) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  PRIMARY KEY (`PagoID`),
  KEY `PrestamoID` (`PrestamoID`),
  CONSTRAINT `Pago_ibfk_1` FOREIGN KEY (`PrestamoID`) REFERENCES `Prestamo` (`PrestamoID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
INSERT INTO `Pago` VALUES (1,1,500.00,'2024-01-31'),(2,1,500.00,'2024-02-28'),(3,2,500.00,'2024-02-15'),(4,2,500.00,'2024-03-01'),(5,3,300.00,'2024-03-31');
/*!40000 ALTER TABLE `Pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prestamo`
--

DROP TABLE IF EXISTS `Prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prestamo` (
  `PrestamoID` int NOT NULL AUTO_INCREMENT,
  `ClienteID` int DEFAULT NULL,
  `FiadorID` int DEFAULT NULL,
  `Monto` decimal(12,2) DEFAULT NULL,
  `TasaInteres` decimal(4,2) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `MontoPago` decimal(12,2) DEFAULT NULL,
  `FrecuenciaPago` enum('Diario','Semanal','Quincenal','Mensual') DEFAULT NULL,
  `Saldo` decimal(12,2) DEFAULT NULL,
  `Tipo` tinyint(1) DEFAULT NULL,
  `Estado` enum('Activo','Cancelado','Finalizado') DEFAULT NULL,
  PRIMARY KEY (`PrestamoID`),
  KEY `ClienteID` (`ClienteID`),
  KEY `FiadorID` (`FiadorID`),
  CONSTRAINT `Prestamo_ibfk_1` FOREIGN KEY (`ClienteID`) REFERENCES `Cliente` (`ClienteID`),
  CONSTRAINT `Prestamo_ibfk_2` FOREIGN KEY (`FiadorID`) REFERENCES `Cliente` (`ClienteID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prestamo`
--

LOCK TABLES `Prestamo` WRITE;
/*!40000 ALTER TABLE `Prestamo` DISABLE KEYS */;
INSERT INTO `Prestamo` VALUES (1,1,2,5000.00,5.00,'2024-01-01','2024-12-31',500.00,'Mensual',4500.00,1,'Activo'),(2,2,3,3000.00,4.50,'2024-02-01','2024-08-01',500.00,'Quincenal',2500.00,0,'Activo'),(3,3,1,1500.00,6.00,'2024-03-01','2024-09-01',300.00,'Mensual',1200.00,1,'Finalizado');
/*!40000 ALTER TABLE `Prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trabajo`
--

DROP TABLE IF EXISTS `Trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trabajo` (
  `TrabajoID` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(255) DEFAULT NULL,
  `NegocioID` int DEFAULT NULL,
  PRIMARY KEY (`TrabajoID`),
  KEY `NegocioID` (`NegocioID`),
  CONSTRAINT `Trabajo_ibfk_1` FOREIGN KEY (`NegocioID`) REFERENCES `Negocio` (`NegocioID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trabajo`
--

LOCK TABLES `Trabajo` WRITE;
/*!40000 ALTER TABLE `Trabajo` DISABLE KEYS */;
INSERT INTO `Trabajo` VALUES (1,'Encargada de ventas',1),(2,'Barista',2),(3,'Asistente de ventas',3);
/*!40000 ALTER TABLE `Trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `UsuarioID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Documento` varchar(10) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Correo` varchar(50) DEFAULT NULL,
  `Clave` varchar(50) DEFAULT NULL,
  `Rol` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`UsuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'Juan','Sánchez','1234567890','3001234567','juan.sanchez@example.com','password123','Administrador'),(2,'María','López','0987654321','3007654321','maria.lopez@example.com','password123','Cobrador'),(3,'Pedro','García','1122334455','3001122334','pedro.garcia@example.com','password123','Usuario');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-13 17:14:46
