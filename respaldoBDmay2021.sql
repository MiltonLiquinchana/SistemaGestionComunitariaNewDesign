-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: ProyectoSistemaAgua
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `LimiteDias`
--

DROP TABLE IF EXISTS `LimiteDias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LimiteDias` (
  `pk_LimiteDias` int NOT NULL AUTO_INCREMENT,
  `LimiteDias` int NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_LimiteDias`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `LimiteDias_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LimiteDias`
--

LOCK TABLES `LimiteDias` WRITE;
/*!40000 ALTER TABLE `LimiteDias` DISABLE KEYS */;
INSERT INTO `LimiteDias` VALUES (1,15,1),(2,11,2),(3,10,3);
/*!40000 ALTER TABLE `LimiteDias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` (
  `pk_actividad` int NOT NULL AUTO_INCREMENT,
  `fecha_participacion` date NOT NULL,
  `descripcion_Actividad` varchar(200) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_actividad`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `actividad_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canton`
--

DROP TABLE IF EXISTS `canton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canton` (
  `cod_canton` char(10) NOT NULL,
  `nombre_canton` varchar(100) NOT NULL,
  `fk_provincia` char(10) NOT NULL,
  PRIMARY KEY (`cod_canton`),
  UNIQUE KEY `cod_canton` (`cod_canton`),
  KEY `fk_provincia` (`fk_provincia`),
  CONSTRAINT `canton_ibfk_1` FOREIGN KEY (`fk_provincia`) REFERENCES `provincia` (`cod_provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canton`
--

LOCK TABLES `canton` WRITE;
/*!40000 ALTER TABLE `canton` DISABLE KEYS */;
INSERT INTO `canton` VALUES ('1702','Cayambe','17'),('1704','Pedro Moncayo','17');
/*!40000 ALTER TABLE `canton` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobro_agua`
--

DROP TABLE IF EXISTS `cobro_agua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cobro_agua` (
  `pk_cobro_agua` int NOT NULL AUTO_INCREMENT,
  `fk_consumo` int NOT NULL,
  `fecha_cacelacion` date NOT NULL,
  `dias_retraso` int NOT NULL,
  `fk_multas` int NOT NULL,
  `valor_multa` decimal(8,2) NOT NULL,
  `total_multa` decimal(8,2) NOT NULL,
  `tarifa_basicaC` decimal(8,2) NOT NULL,
  `tarifa_ambienteC` decimal(8,2) NOT NULL,
  `alcantarilladoC` decimal(8,2) NOT NULL,
  `totalpagar` decimal(8,2) NOT NULL,
  `deposito` decimal(8,2) NOT NULL,
  `cambio` decimal(8,2) NOT NULL,
  `fk_estado_pagos` int NOT NULL,
  PRIMARY KEY (`pk_cobro_agua`),
  KEY `fk_consumo` (`fk_consumo`),
  KEY `fk_multas` (`fk_multas`),
  KEY `fk_estado_pagos` (`fk_estado_pagos`),
  CONSTRAINT `cobro_agua_ibfk_1` FOREIGN KEY (`fk_consumo`) REFERENCES `consumo` (`pk_consumo`),
  CONSTRAINT `cobro_agua_ibfk_2` FOREIGN KEY (`fk_multas`) REFERENCES `multas` (`pk_multas`),
  CONSTRAINT `cobro_agua_ibfk_3` FOREIGN KEY (`fk_estado_pagos`) REFERENCES `estado_pagos` (`pk_estado_pagos`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobro_agua`
--

LOCK TABLES `cobro_agua` WRITE;
/*!40000 ALTER TABLE `cobro_agua` DISABLE KEYS */;
INSERT INTO `cobro_agua` VALUES (48,53,'2021-03-10',18,3,0.20,3.60,3.00,0.50,0.20,122.10,123.00,0.90,1),(49,54,'2021-02-20',0,1,0.20,0.00,3.00,0.50,0.00,50.00,0.00,0.00,2),(50,55,'2021-03-20',0,1,0.20,0.00,2.50,0.25,0.00,2.50,0.00,0.00,2),(51,56,'2021-03-21',0,1,0.20,0.00,2.50,0.25,0.00,2.50,0.00,0.00,2);
/*!40000 ALTER TABLE `cobro_agua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobro_cuotas`
--

DROP TABLE IF EXISTS `cobro_cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cobro_cuotas` (
  `pk_cobro_cuotas` int NOT NULL AUTO_INCREMENT,
  `fk_comunero` int NOT NULL,
  `fk_cuotas` int NOT NULL,
  `fecha_cancelacion` date NOT NULL,
  `dias_retraso` char(10) NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `fk_saldos` int NOT NULL,
  `fk_multas` int NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `fk_estado_pagos` int NOT NULL,
  PRIMARY KEY (`pk_cobro_cuotas`),
  KEY `fk_comunero` (`fk_comunero`),
  KEY `fk_cuotas` (`fk_cuotas`),
  KEY `fk_saldos` (`fk_saldos`),
  KEY `fk_multas` (`fk_multas`),
  KEY `fk_estado_pagos` (`fk_estado_pagos`),
  CONSTRAINT `cobro_cuotas_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`),
  CONSTRAINT `cobro_cuotas_ibfk_2` FOREIGN KEY (`fk_cuotas`) REFERENCES `cuotas` (`pk_cuotas`),
  CONSTRAINT `cobro_cuotas_ibfk_3` FOREIGN KEY (`fk_saldos`) REFERENCES `saldos` (`pk_saldos`),
  CONSTRAINT `cobro_cuotas_ibfk_4` FOREIGN KEY (`fk_multas`) REFERENCES `multas` (`pk_multas`),
  CONSTRAINT `cobro_cuotas_ibfk_5` FOREIGN KEY (`fk_estado_pagos`) REFERENCES `estado_pagos` (`pk_estado_pagos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobro_cuotas`
--

LOCK TABLES `cobro_cuotas` WRITE;
/*!40000 ALTER TABLE `cobro_cuotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cobro_cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobro_participacion`
--

DROP TABLE IF EXISTS `cobro_participacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cobro_participacion` (
  `pk_cobro_participacion` int NOT NULL AUTO_INCREMENT,
  `fk_registros_participacion` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `fk_multa` int NOT NULL,
  `fk_saldos` int NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `fk_estado_pagos` int NOT NULL,
  PRIMARY KEY (`pk_cobro_participacion`),
  KEY `fk_registros_participacion` (`fk_registros_participacion`),
  KEY `fk_multa` (`fk_multa`),
  KEY `fk_saldos` (`fk_saldos`),
  KEY `fk_estado_pagos` (`fk_estado_pagos`),
  CONSTRAINT `cobro_participacion_ibfk_1` FOREIGN KEY (`fk_registros_participacion`) REFERENCES `registros_participacion` (`pk_registros_participacion`),
  CONSTRAINT `cobro_participacion_ibfk_2` FOREIGN KEY (`fk_multa`) REFERENCES `multas` (`pk_multas`),
  CONSTRAINT `cobro_participacion_ibfk_3` FOREIGN KEY (`fk_saldos`) REFERENCES `saldos` (`pk_saldos`),
  CONSTRAINT `cobro_participacion_ibfk_4` FOREIGN KEY (`fk_estado_pagos`) REFERENCES `estado_pagos` (`pk_estado_pagos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobro_participacion`
--

LOCK TABLES `cobro_participacion` WRITE;
/*!40000 ALTER TABLE `cobro_participacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `cobro_participacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comuna`
--

DROP TABLE IF EXISTS `comuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comuna` (
  `pk_comuna` int NOT NULL AUTO_INCREMENT,
  `nombre_comuna` varchar(200) NOT NULL,
  `direccion_comuna` varchar(500) DEFAULT NULL,
  `fk_parroquia` char(10) NOT NULL,
  PRIMARY KEY (`pk_comuna`),
  KEY `fk_parroquia` (`fk_parroquia`),
  CONSTRAINT `comuna_ibfk_1` FOREIGN KEY (`fk_parroquia`) REFERENCES `parroquia` (`cod_parroquia`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comuna`
--

LOCK TABLES `comuna` WRITE;
/*!40000 ALTER TABLE `comuna` DISABLE KEYS */;
INSERT INTO `comuna` VALUES (1,'Compania Lote3','Via Quinche','170252'),(2,'Comite San Isidro De Cajas','Panamericana Norte a 200 metros antes de Cajas','170252'),(3,'Chumillos','Via Quinche','170252'),(4,'Quinchucajas','Via Quinche','170252'),(5,'Paccha','Via a Pambamarca','170252');
/*!40000 ALTER TABLE `comuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunero`
--

DROP TABLE IF EXISTS `comunero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunero` (
  `pk_comunero` int NOT NULL AUTO_INCREMENT,
  `cedula` varchar(15) NOT NULL,
  `primer_nombre` varchar(25) NOT NULL,
  `segundo_nombre` varchar(25) NOT NULL,
  `primer_apellido` varchar(25) NOT NULL,
  `segundo_apellido` varchar(25) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int NOT NULL,
  `fk_comuna` int NOT NULL,
  `direccion_vivienda` varchar(500) DEFAULT NULL,
  `referencia_geografica` varchar(500) DEFAULT NULL,
  `fk_estadoComunero` int NOT NULL,
  PRIMARY KEY (`pk_comunero`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `fk_comuna` (`fk_comuna`),
  KEY `fk_estadoComunero` (`fk_estadoComunero`),
  CONSTRAINT `comunero_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`),
  CONSTRAINT `comunero_ibfk_2` FOREIGN KEY (`fk_estadoComunero`) REFERENCES `estadoComunero` (`pk_estadoComunero`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunero`
--

LOCK TABLES `comunero` WRITE;
/*!40000 ALTER TABLE `comunero` DISABLE KEYS */;
INSERT INTO `comunero` VALUES (3,'1707616395','VICTOR','MANUEL','ALVA','INLAGO','0995887459','2020-03-21',15,2,'CALLE 9 DE OCTUBRE','JUNTO A LA CASA COMUNAL ',1),(14,'1754429361','MILTON','FELIPE','LIQUINCHANA','QUILO','0995883099','1999-05-30',21,2,'CALLE 9 DE OCTUBRE','SEGUNDO PUENTE AMARILLO',1),(18,'1059876051','MARIA','ROSARIO','QUILO','SANCHEZ','0995887066','2020-07-23',32,2,'CALLE 9 DE OCTUBRE','CERCA DE TIO CAJAS',1),(19,'1782528564','HECTOR','SELIANO','LIQUINCHANA','PERUGACHI','0995658159','2020-07-29',30,3,'CALLE 9 DE OCTUBRE','PRIMER PUENTE AMARILLO',1),(20,'1754429888','MiltonF','FELIPE','LIQUINCHANA','QUILO','0995883088','1999-05-30',21,2,'Comunidad San Isidro de cajas','Casa comunal a la derecha- segundo puente amarillo - sobre el canal de riego',2),(22,'1754489876','Milton','Felipe','Liquinchana','Quiilo','0995883099','1999-05-30',22,2,'Comunidad San Isidro de Cajas','Segundo puente amarillo',1),(24,'1003459000','Cintia','Daniela','Liquinchana','Quilo','tvybnjmk,','2021-02-11',21,2,'CALLE 9 DE OCTUBRE','SEGUNDO PUENTE AMARILLO',1),(26,'8775987898','Marcelo','Patricio','farinango','quilo','0995883697','1999-05-30',19,2,'Comunidad','san Isidro',1),(76,'1234567892','Cintiaaaa','Sakela','Lekaa','Quilo','0995883099','2021-03-06',18,2,'Comunidad','SEGUNDO PUENTE AMARILLO',1),(77,'789456138','Cintia','Daniela','Liquinchana','Quilo','0995887066','2021-02-28',25,2,'CALLE 9 DE OCTUBRE','SEGUNDO PUENTE AMARILLO',1),(79,'1234567891','Cintiaaaa','FELIPE','Lekaa','QUILO','0995883099','2021-03-26',25,2,'Comunidad','Sobre el canal de riego',1);
/*!40000 ALTER TABLE `comunero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumo`
--

DROP TABLE IF EXISTS `consumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumo` (
  `pk_consumo` int NOT NULL AUTO_INCREMENT,
  `lectura_anterior` int NOT NULL,
  `lectura_actual` int NOT NULL,
  `fecha_lectura` date NOT NULL,
  `fecha_limite_pago` date NOT NULL,
  `consumo_mcubico` int NOT NULL,
  `total_pagar` decimal(8,2) NOT NULL,
  `fk_medidor` int NOT NULL,
  `fk_tipoconsumo` int NOT NULL,
  PRIMARY KEY (`pk_consumo`),
  KEY `fk_medidor` (`fk_medidor`),
  KEY `fk_tipoconsumo` (`fk_tipoconsumo`),
  CONSTRAINT `consumo_ibfk_1` FOREIGN KEY (`fk_medidor`) REFERENCES `medidor` (`pk_medidor`),
  CONSTRAINT `consumo_ibfk_2` FOREIGN KEY (`fk_tipoconsumo`) REFERENCES `tipoconsumo` (`pk_tipoconsumo`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumo`
--

LOCK TABLES `consumo` WRITE;
/*!40000 ALTER TABLE `consumo` DISABLE KEYS */;
INSERT INTO `consumo` VALUES (53,0,200,'2021-02-09','2021-02-20',200,100.00,1,2),(54,0,100,'2021-02-09','2021-02-20',100,50.00,2,2),(55,200,205,'2021-03-09','2021-03-20',5,2.50,1,1),(56,205,206,'2021-03-10','2021-03-21',1,2.50,1,1);
/*!40000 ALTER TABLE `consumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuotas` (
  `pk_cuotas` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` date NOT NULL,
  `fecha_limite_pago` date NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_cuotas`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `cuotas_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuotas`
--

LOCK TABLES `cuotas` WRITE;
/*!40000 ALTER TABLE `cuotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoComunero`
--

DROP TABLE IF EXISTS `estadoComunero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoComunero` (
  `pk_estadoComunero` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`pk_estadoComunero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoComunero`
--

LOCK TABLES `estadoComunero` WRITE;
/*!40000 ALTER TABLE `estadoComunero` DISABLE KEYS */;
INSERT INTO `estadoComunero` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estadoComunero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_asistencia`
--

DROP TABLE IF EXISTS `estado_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_asistencia` (
  `pk_estado_asistencia` int NOT NULL AUTO_INCREMENT,
  `estado_asistencia` varchar(10) NOT NULL,
  PRIMARY KEY (`pk_estado_asistencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_asistencia`
--

LOCK TABLES `estado_asistencia` WRITE;
/*!40000 ALTER TABLE `estado_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_pagos`
--

DROP TABLE IF EXISTS `estado_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_pagos` (
  `pk_estado_pagos` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`pk_estado_pagos`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_pagos`
--

LOCK TABLES `estado_pagos` WRITE;
/*!40000 ALTER TABLE `estado_pagos` DISABLE KEYS */;
INSERT INTO `estado_pagos` VALUES (1,'Pagado'),(2,'Impaga');
/*!40000 ALTER TABLE `estado_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `pk_login` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `contraseña` varchar(25) NOT NULL,
  `fk_tipousuario` int NOT NULL,
  `fk_comunero` int NOT NULL,
  PRIMARY KEY (`pk_login`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `fk_tipousuario` (`fk_tipousuario`),
  KEY `fk_comunero` (`fk_comunero`),
  CONSTRAINT `login_ibfk_1` FOREIGN KEY (`fk_tipousuario`) REFERENCES `tipousuario` (`pk_tipousuario`),
  CONSTRAINT `login_ibfk_2` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (8,'MILTO','158',1,14),(13,'SELIANO','rp3z8ZYRJ8zNnF5',1,19),(44,'qwe','789',2,76),(45,'qwerty','7896',1,77),(46,'CIMilton','15879',3,79);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medidor`
--

DROP TABLE IF EXISTS `medidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medidor` (
  `pk_medidor` int NOT NULL AUTO_INCREMENT,
  `numero_medidor` varchar(30) NOT NULL,
  `fecha_conexion` date NOT NULL,
  `fk_comunero` int NOT NULL,
  PRIMARY KEY (`pk_medidor`),
  UNIQUE KEY `numero_medidor_UNIQUE` (`numero_medidor`),
  KEY `fk_comunero` (`fk_comunero`),
  CONSTRAINT `medidor_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medidor`
--

LOCK TABLES `medidor` WRITE;
/*!40000 ALTER TABLE `medidor` DISABLE KEYS */;
INSERT INTO `medidor` VALUES (1,'5555','1999-05-30',3),(2,'5556','1999-05-30',3),(3,'987','1999-05-30',19),(4,'548','1999-05-30',14),(7,'12345','1999-05-30',77),(8,'123456','1999-05-30',24);
/*!40000 ALTER TABLE `medidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multas`
--

DROP TABLE IF EXISTS `multas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multas` (
  `pk_multas` int NOT NULL AUTO_INCREMENT,
  `tipo_multa` varchar(50) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_multas`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `multas_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multas`
--

LOCK TABLES `multas` WRITE;
/*!40000 ALTER TABLE `multas` DISABLE KEYS */;
INSERT INTO `multas` VALUES (1,'Sin Recargo',0.00,1),(2,'Retraso',0.20,1),(3,'Retraso',0.50,2);
/*!40000 ALTER TABLE `multas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parroquia`
--

DROP TABLE IF EXISTS `parroquia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parroquia` (
  `cod_parroquia` char(10) NOT NULL,
  `nombre_parroquia` varchar(100) NOT NULL,
  `fk_canton` char(10) NOT NULL,
  PRIMARY KEY (`cod_parroquia`),
  UNIQUE KEY `cod_parroquia` (`cod_parroquia`),
  KEY `fk_canton` (`fk_canton`),
  CONSTRAINT `parroquia_ibfk_1` FOREIGN KEY (`fk_canton`) REFERENCES `canton` (`cod_canton`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parroquia`
--

LOCK TABLES `parroquia` WRITE;
/*!40000 ALTER TABLE `parroquia` DISABLE KEYS */;
INSERT INTO `parroquia` VALUES ('170252','Cangahua','1702'),('170450','Tabacundo','1704');
/*!40000 ALTER TABLE `parroquia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provincia` (
  `cod_provincia` char(10) NOT NULL,
  `nombre_provincia` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_provincia`),
  UNIQUE KEY `cod_provincia` (`cod_provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES ('17','Pichincha');
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registros_participacion`
--

DROP TABLE IF EXISTS `registros_participacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registros_participacion` (
  `pk_registros_participacion` int NOT NULL AUTO_INCREMENT,
  `fk_comunero` int NOT NULL,
  `fk_tipo_actividad` int NOT NULL,
  `fk_actividad` int NOT NULL,
  `fk_estado_asistencia` int NOT NULL,
  PRIMARY KEY (`pk_registros_participacion`),
  KEY `fk_comunero` (`fk_comunero`),
  KEY `fk_tipo_actividad` (`fk_tipo_actividad`),
  KEY `fk_actividad` (`fk_actividad`),
  KEY `fk_estado_asistencia` (`fk_estado_asistencia`),
  CONSTRAINT `registros_participacion_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`),
  CONSTRAINT `registros_participacion_ibfk_2` FOREIGN KEY (`fk_tipo_actividad`) REFERENCES `tipo_actividad` (`pk_tipo_actividad`),
  CONSTRAINT `registros_participacion_ibfk_3` FOREIGN KEY (`fk_actividad`) REFERENCES `actividad` (`pk_actividad`),
  CONSTRAINT `registros_participacion_ibfk_4` FOREIGN KEY (`fk_estado_asistencia`) REFERENCES `estado_asistencia` (`pk_estado_asistencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros_participacion`
--

LOCK TABLES `registros_participacion` WRITE;
/*!40000 ALTER TABLE `registros_participacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `registros_participacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_agua`
--

DROP TABLE IF EXISTS `reporte_agua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_agua` (
  `pk_reporte_agua` int NOT NULL AUTO_INCREMENT,
  `fk_comunero` int NOT NULL,
  `fk_medidor` int NOT NULL,
  `fk_cobro_agua` int NOT NULL,
  `fk_consumo` int NOT NULL,
  PRIMARY KEY (`pk_reporte_agua`),
  KEY `fk_comunero` (`fk_comunero`),
  KEY `fk_medidor` (`fk_medidor`),
  KEY `fk_cobro_agua` (`fk_cobro_agua`),
  KEY `fk_consumo` (`fk_consumo`),
  CONSTRAINT `reporte_agua_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`),
  CONSTRAINT `reporte_agua_ibfk_2` FOREIGN KEY (`fk_medidor`) REFERENCES `medidor` (`pk_medidor`),
  CONSTRAINT `reporte_agua_ibfk_3` FOREIGN KEY (`fk_cobro_agua`) REFERENCES `cobro_agua` (`pk_cobro_agua`),
  CONSTRAINT `reporte_agua_ibfk_4` FOREIGN KEY (`fk_consumo`) REFERENCES `consumo` (`pk_consumo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_agua`
--

LOCK TABLES `reporte_agua` WRITE;
/*!40000 ALTER TABLE `reporte_agua` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_agua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_cuotas`
--

DROP TABLE IF EXISTS `reporte_cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_cuotas` (
  `pk_reporte_cuotas` int NOT NULL AUTO_INCREMENT,
  `fk_comunero` int NOT NULL,
  `fk_cuotas` int NOT NULL,
  `fk_cobro_cuotas` int NOT NULL,
  PRIMARY KEY (`pk_reporte_cuotas`),
  KEY `fk_comunero` (`fk_comunero`),
  KEY `fk_cuotas` (`fk_cuotas`),
  KEY `fk_cobro_cuotas` (`fk_cobro_cuotas`),
  CONSTRAINT `reporte_cuotas_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`),
  CONSTRAINT `reporte_cuotas_ibfk_2` FOREIGN KEY (`fk_cuotas`) REFERENCES `cuotas` (`pk_cuotas`),
  CONSTRAINT `reporte_cuotas_ibfk_3` FOREIGN KEY (`fk_cobro_cuotas`) REFERENCES `cobro_cuotas` (`pk_cobro_cuotas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_cuotas`
--

LOCK TABLES `reporte_cuotas` WRITE;
/*!40000 ALTER TABLE `reporte_cuotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_participacion`
--

DROP TABLE IF EXISTS `reporte_participacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_participacion` (
  `pk_reporte_participacion` int NOT NULL AUTO_INCREMENT,
  `fk_comunero` int NOT NULL,
  `fk_registros_participacion` int NOT NULL,
  `fk_cobro_participacion` int NOT NULL,
  PRIMARY KEY (`pk_reporte_participacion`),
  KEY `fk_comunero` (`fk_comunero`),
  KEY `fk_registros_participacion` (`fk_registros_participacion`),
  KEY `fk_cobro_participacion` (`fk_cobro_participacion`),
  CONSTRAINT `reporte_participacion_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`),
  CONSTRAINT `reporte_participacion_ibfk_2` FOREIGN KEY (`fk_registros_participacion`) REFERENCES `registros_participacion` (`pk_registros_participacion`),
  CONSTRAINT `reporte_participacion_ibfk_3` FOREIGN KEY (`fk_cobro_participacion`) REFERENCES `cobro_participacion` (`pk_cobro_participacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_participacion`
--

LOCK TABLES `reporte_participacion` WRITE;
/*!40000 ALTER TABLE `reporte_participacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_participacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saldos`
--

DROP TABLE IF EXISTS `saldos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saldos` (
  `pk_saldos` int NOT NULL AUTO_INCREMENT,
  `tipo_saldo` varchar(50) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `fk_comunero` int NOT NULL,
  PRIMARY KEY (`pk_saldos`),
  KEY `fk_comunero` (`fk_comunero`),
  CONSTRAINT `saldos_ibfk_1` FOREIGN KEY (`fk_comunero`) REFERENCES `comunero` (`pk_comunero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saldos`
--

LOCK TABLES `saldos` WRITE;
/*!40000 ALTER TABLE `saldos` DISABLE KEYS */;
/*!40000 ALTER TABLE `saldos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_actividad`
--

DROP TABLE IF EXISTS `tipo_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_actividad` (
  `pk_tipo_actividad` int NOT NULL AUTO_INCREMENT,
  `tipo_Actividad` varchar(50) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_tipo_actividad`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `tipo_actividad_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_actividad`
--

LOCK TABLES `tipo_actividad` WRITE;
/*!40000 ALTER TABLE `tipo_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_descuento`
--

DROP TABLE IF EXISTS `tipo_descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_descuento` (
  `pk_tipo_descuento` int NOT NULL AUTO_INCREMENT,
  `tipo_descuento` varchar(30) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `valor_descuento` decimal(10,2) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_tipo_descuento`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `tipo_descuento_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_descuento`
--

LOCK TABLES `tipo_descuento` WRITE;
/*!40000 ALTER TABLE `tipo_descuento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoconsumo`
--

DROP TABLE IF EXISTS `tipoconsumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoconsumo` (
  `pk_tipoconsumo` int NOT NULL AUTO_INCREMENT,
  `tipo_consumo` varchar(20) NOT NULL,
  `limitem_cubico` int NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `tarifa_basica` decimal(8,2) NOT NULL,
  `tarifa_ambiente` decimal(8,2) NOT NULL,
  `alcantarillado` decimal(8,2) NOT NULL,
  `fk_comuna` int NOT NULL,
  PRIMARY KEY (`pk_tipoconsumo`),
  KEY `fk_comuna` (`fk_comuna`),
  CONSTRAINT `tipoconsumo_ibfk_1` FOREIGN KEY (`fk_comuna`) REFERENCES `comuna` (`pk_comuna`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoconsumo`
--

LOCK TABLES `tipoconsumo` WRITE;
/*!40000 ALTER TABLE `tipoconsumo` DISABLE KEYS */;
INSERT INTO `tipoconsumo` VALUES (1,'Domestico',10,0.25,2.50,0.25,0.00,2),(2,'Comercial',15,0.50,3.00,0.50,0.00,2),(3,'Empresarial',40,1.00,5.00,2.00,0.00,1),(6,'Exagerado',100,5.00,25.00,10.00,1.00,1),(7,'Domestico',20,0.10,5.00,0.50,0.30,3);
/*!40000 ALTER TABLE `tipoconsumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `pk_tipousuario` int NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(25) NOT NULL,
  PRIMARY KEY (`pk_tipousuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Administrador General'),(2,'Administrador'),(3,'Tesoreria');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ProyectoSistemaAgua'
--

--
-- Dumping routines for database 'ProyectoSistemaAgua'
--
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_comunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_comunero`(
pk_comuner int,
cedul varchar(15),
primer_nombr varchar(25),
segundo_nombr varchar(25),
primer_apellid varchar(25),
segundo_apellid varchar(25),
telefon varchar(15),
fecha_nacimient date,
eda int,
fk_comun int,
direccion_viviend varchar(500),
referencia_geografic varchar(500)
)
update comunero set 
cedula =cedul,
primer_nombre = primer_nombr,
segundo_nombre = segundo_nombr,
primer_apellido = primer_apellid,
segundo_apellido = segundo_apellid,
telefono = telefon,
fecha_nacimiento = fecha_nacimient,
edad = eda,
fk_comuna = fk_comun,
direccion_vivienda = direccion_viviend,
referencia_geografica = referencia_geografic 
where pk_comunero=pk_comuner ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_usuario`(
usua varchar(50),
contras varchar(25),
fk_tipusu int,
pk_comun int
)
update login set usuario=usua,contraseña=contras,fk_tipousuario=fk_tipusu where fk_comunero=pk_comun ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscarConsumoImpaga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarConsumoImpaga`(pk_medid int)
begin
select pk_consumo,fecha_lectura
from consumo join cobro_agua
on consumo.pk_consumo=cobro_agua.fk_consumo
where fk_medidor=pk_medid and fk_estado_pagos=2;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscarDatosConsumoImpaga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDatosConsumoImpaga`(fk_consum int,fk_comun int)
begin
select consumo_mcubico,tipo_consumo,fecha_lectura, fecha_limite_pago,total_pagar as subtotal,
(if(curdate()>fecha_limite_pago,"Retraso","Sin Recargo"))as tipo_multa,
(
if(curdate()>fecha_limite_pago,(select valor_multa from cobro_agua where fk_consumo=fk_consum),"0")
)as valor_multa,tarifa_ambiente,alcantarillado from consumo
join tipoconsumo
on pk_tipoconsumo=fk_tipoconsumo
where pk_consumo=fk_consum;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaDatosComunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaDatosComunero`(dato varchar(300),fk_comun int)
select pk_comunero,cedula,primer_nombre, segundo_nombre,primer_apellido,segundo_apellido from comunero 
where (cedula=dato or CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato) and fk_comuna=fk_comun ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaDatosFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaDatosFactura`(pk_consum int)
select primer_apellido, segundo_apellido, primer_nombre, segundo_nombre, cedula, telefono,direccion_vivienda,
numero_medidor, fecha_lectura,fecha_limite_pago,lectura_anterior, lectura_actual,tipo_consumo,consumo_mcubico,tarifa_basicaC,
consumo.total_pagar as subtotal,tarifa_ambienteC, alcantarilladoC,tipo_multa,dias_retraso,valor_multa as total_multa, 
cobro_agua.totalpagar,deposito,cambio from comunero
join medidor
on pk_comunero=fk_comunero
join consumo
on pk_medidor=fk_medidor
join tipoconsumo
on pk_tipoconsumo=fk_tipoconsumo
join cobro_agua
on pk_consumo=fk_consumo
join multas
on pk_multas=fk_multas
where pk_consumo=pk_consum ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaLimiteDias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaLimiteDias`(fk_comun int)
select LimiteDias from LimiteDias
where fk_comuna=fk_comun ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaMedidoresComunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaMedidoresComunero`(dato varchar(300))
select pk_medidor,numero_medidor from medidor where fk_comunero=(select pk_comunero from comunero where cedula=dato or CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarmaximoConsumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarmaximoConsumo`(pk_medid int)
select max(lectura_actual) as lectura_actual from consumo where fk_medidor=pk_medid ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaTipoConsumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaTipoConsumo`(fk_comun int)
select pk_tipoconsumo,tipo_consumo,limitem_cubico,valor,tarifa_basica,tarifa_ambiente,alcantarillado
 from tipoconsumo
 where fk_comuna=fk_comun
 order by limitem_cubico asc ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consulta_comunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_comunero`(id_comuna int)
select pk_comunero,cedula,primer_nombre,segundo_nombre,
primer_apellido,segundo_apellido,telefono,edad 
from comunero
join comuna
on fk_comuna=pk_comuna
where fk_comuna=id_comuna and fk_estadoComunero=1 ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consulta_comuneroID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_comuneroID`(id_comunero int)
select cedula,primer_nombre,segundo_nombre,
primer_apellido,segundo_apellido,telefono,direccion_vivienda,
referencia_geografica,nombre_comuna,fecha_nacimiento,edad,
(select usuario from login where fk_comunero=id_comunero) as usuario,
(select contraseña from login where fk_comunero=id_comunero) as contraseña,
(
select pk_tipousuario from tipousuario
where pk_tipousuario=(select fk_tipousuario from login where fk_comunero=id_comunero)
 ) as pk_tipousuario
 from comunero
 join comuna
 on comunero.fk_comuna=comuna.pk_comuna
 where pk_comunero=id_comunero ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `datos_lectura_medidor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `datos_lectura_medidor`(num_medidor varchar(30))
select max(lectura_actual) as lectura_actual from consumo where fk_medidor=(select pk_medidor from medidor where numero_medidor=num_medidor) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_comunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_comunero`(
pk_comuner int
)
delete from comunero where pk_comunero=pk_comuner ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_login`(pk_comun int)
delete from login where fk_comunero=pk_comun ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtraComunero_cedula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `filtraComunero_cedula`(
cedul varchar(25)
)
select * from comunero
where cedula like concat('%',cedul,'%') ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtraComunero_nomape` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `filtraComunero_nomape`(
primernombre varchar(25),
segundonombre varchar(25),
primerapellido varchar(25),
segundoapellido varchar(25)
)
select * from comunero
where primer_nombre like '%primernombre%' 
or segundo_nombre like '%segundonombre%'
or primer_apellido like '%primerapellido%'
or segundo_apellido like '%segundoapellido%' ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GuardarActualizarEliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GuardarActualizarEliminar`(
accion varchar(10),
pk_comuner varchar(7),
cedul varchar(15),
primer_nombr varchar(25) ,
segundo_nombr varchar(25),
primer_apellid varchar(25),
segundo_apellid varchar(25),
telefon varchar(15),
fecha_nacimient date,
eda int,
fk_comun int,
direccion_viviend varchar(500),
referencia_geografic varchar(500),
usuari varchar(50),
contrase varchar(25),
fk_tipousuari int
)
begin
if accion="Guardar" then
insert into comunero(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,fecha_nacimiento,edad,fk_comuna,direccion_vivienda,referencia_geografica,fk_estadoComunero)
				values(cedul,primer_nombr,segundo_nombr,primer_apellid,segundo_apellid,telefon,fecha_nacimient,eda,fk_comun,direccion_viviend,referencia_geografic,1);
                insert into login(usuario,contraseña,fk_tipousuario,fk_comunero)
							values(usuari,contrase,fk_tipousuari,(select pk_comunero from comunero where cedula=cedul));
elseif accion="Actualizar" then
update comunero set 
cedula =cedul,
primer_nombre = primer_nombr,
segundo_nombre = segundo_nombr,
primer_apellido = primer_apellid,
segundo_apellido = segundo_apellid,
telefono = telefon,
fecha_nacimiento = fecha_nacimient,
edad = eda,
fk_comuna = fk_comun,
direccion_vivienda = direccion_viviend,
referencia_geografica = referencia_geografic 
where pk_comunero=pk_comuner;
update login set usuario=usuari,contraseña=contrase,fk_tipousuario=fk_tipousuari where fk_comunero=pk_comuner;
elseif accion="Eliminar" then
update comunero set fk_estadoComunero=2 where pk_comunero=pk_comuner;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardarConsumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarConsumo`(
lectura_ante int,
lectura_actual int,
fecha_lectu varchar(15),
fecha_limit varchar(15),
consumo_mcubic int,
total_pag double,
fk_medido int,
fk_tipoconsum int,
fk_comun int)
BEGIN
insert into consumo (lectura_anterior,lectura_actual,fecha_lectura,fecha_limite_pago,consumo_mcubico,total_pagar,fk_medidor,fk_tipoconsumo)
values(lectura_ante,lectura_actual,fecha_lectu,fecha_limit,consumo_mcubic,total_pag,fk_medido,fk_tipoconsum);
insert into cobro_agua(
fk_consumo,
fecha_cacelacion,
dias_retraso,
fk_multas,
valor_multa,
total_multa,
tarifa_basicaC,
tarifa_ambienteC,
alcantarilladoC,
totalpagar,
deposito,
cambio,
fk_estado_pagos) 
values((select max(pk_consumo) as pk_consumo from consumo where fk_medidor=fk_medido),fecha_limit,0,1,
(select valor from multas where fk_comuna=1 and tipo_multa="Retraso"),0,
(select tarifa_basica from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
(select tarifa_ambiente from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
(select alcantarillado from tipoconsumo where pk_tipoconsumo=fk_tipoconsum),
total_pag,
0,0,2);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardarPagoConsumo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarPagoConsumo`(
dias_retras int, 
valor_totalmulta double,
total_pagado double,
fk_consum int,
fk_comun int,
deposit double,
cambi double)
update cobro_agua set fecha_cacelacion=curdate(),dias_retraso=dias_retras,
fk_multas=(select if(curdate()>(select fecha_limite_pago from consumo where pk_consumo=fk_consum),
(select pk_multas from multas where tipo_multa="Retraso" and fk_comuna=fk_comun),1)),
total_multa=valor_totalmulta,
totalpagar=total_pagado,
deposito=deposit,
cambio=cambi,
fk_estado_pagos=1
where fk_consumo=fk_consum ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardar_comunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_comunero`(
cedul varchar(15),
primer_nombr varchar(25) ,
segundo_nombr varchar(25),
primer_apellid varchar(25),
segundo_apellid varchar(25),
telefon varchar(15),
fecha_nacimient date,
eda int,
fk_comun int,
direccion_viviend varchar(500),
referencia_geografic varchar(500)
)
Insert into comunero(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,fecha_nacimiento,edad,fk_comuna,direccion_vivienda,referencia_geografica) 
			  values(cedul,primer_nombr,segundo_nombr,primer_apellid,segundo_apellid,telefon,fecha_nacimient,eda,fk_comun,direccion_viviend,referencia_geografic) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardar_pago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_pago`(dias_re int, fecha_limite_pag varchar(15),ced varchar(15),valor_mul double,total_pagado double, fk_consu int)
update cobro_agua set fecha_cacelacion=curdate(),dias_retraso=dias_re,
fk_multas=(select if(curdate()>fecha_limite_pag,(select pk_multas from multas where tipo_multa="Retraso" and fk_comuna=(select fk_comuna from comunero where cedula=ced)),1)),
valor_multa=valor_mul,
totalpagar=total_pagado,
fk_estado_pagos=1 where fk_consumo=fk_consu ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardar_tipousuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_tipousuario`(
pk_tipousuari int,
tipo_usuari varchar(25)
)
insert into tipousuario(pk_tipousuario, tipo_usuario)values(pk_tipousuari, tipo_usuari) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `guardar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_usuario`(
usuari varchar(50),
contraseñ varchar(25),
fk_tipousuari int,
cedul varchar(15)
)
insert into login(usuario,contraseña,fk_tipousuario,fk_comunero) values(usuari,contraseñ,fk_tipousuari,(select pk_comunero from comunero where cedula = cedul )) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listarAbonados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAbonados`(dato varchar(300))
select cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,pk_medidor,numero_medidor
 from comunero
 join medidor
 on fk_comunero=pk_comunero
 where (cedula=dato or CONCAT(primer_apellido," ",segundo_apellido," ",primer_nombre," ",segundo_nombre) = dato) and fk_estadoComunero=1 ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarConsumosAbonados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarConsumosAbonados`(fk_medid int)
begin
if((select count(*) from consumo join cobro_agua
on pk_consumo=fk_consumo 
join medidor
on pk_medidor=consumo.fk_medidor
where fk_estado_pagos=2 and fk_medidor=fk_medid)>0) 
then 
select pk_cobro_agua, numero_medidor,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,consumo_mcubico,fecha_lectura,fecha_limite_pago,tipo_consumo,tarifa_ambienteC,alcantarilladoC,consumo.total_pagar,valor_multa,estado from medidor
join comunero
on pk_comunero=fk_comunero
join consumo
on pk_medidor=fk_medidor 
join cobro_agua
on pk_consumo=fk_consumo
join tipoconsumo
on tipoconsumo.pk_tipoconsumo=consumo.fk_tipoconsumo
join estado_pagos
on pk_estado_pagos =cobro_agua.fk_estado_pagos
where fk_estado_pagos=2 and fk_medidor=fk_medid order by pk_cobro_agua;
 else
select pk_cobro_agua, numero_medidor,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,consumo_mcubico,fecha_lectura,fecha_limite_pago,tipo_consumo,tarifa_ambienteC,alcantarilladoC,consumo.total_pagar,valor_multa,estado from medidor
join comunero
on pk_comunero=fk_comunero
join consumo
on pk_medidor=fk_medidor 
join cobro_agua
on pk_consumo=fk_consumo
join tipoconsumo
on tipoconsumo.pk_tipoconsumo=consumo.fk_tipoconsumo
join estado_pagos
on pk_estado_pagos =cobro_agua.fk_estado_pagos
where fk_consumo=(select max(pk_consumo) from consumo join cobro_agua on pk_consumo=fk_consumo where fk_medidor=fk_medid and fk_estado_pagos=1);
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listarloginuserpass` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listarloginuserpass`(userr varchar(50), contrasenia varchar(25))
select pk_login,usuario,contraseña,pk_tipousuario,tipo_usuario,pk_comunero,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,pk_comuna,nombre_comuna from login
join tipousuario
on login.fk_tipousuario=tipousuario.pk_tipousuario
join comunero
on login.fk_comunero=comunero.pk_comunero
join comuna
on comunero.fk_comuna=comuna.pk_comuna
where usuario=userr and contraseña=contrasenia ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_comuna` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_comuna`()
select * from comuna ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_datos_comunero_ced_nom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_datos_comunero_ced_nom`(dato varchar(100))
select pk_comunero,cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido
 from comunero
 where cedula=dato or CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_medidor_comunero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_medidor_comunero`(dato varchar(100))
select pk_medidor,numero_medidor from medidor where 
 fk_comunero=(select pk_comunero from comunero where CONCAT(primer_nombre," ",segundo_nombre," ",primer_apellido," ",segundo_apellido) = dato or cedula=dato) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_tipousuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_tipousuario`()
select * from tipousuario ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_usuario`()
select * from login ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_usuarioID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_usuarioID`(fk_comuner int)
select * from login where fk_comunero=fk_comuner ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `numFac` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `numFac`(
fk_comun int
)
select count(pk_cobro_agua) as conteo from cobro_agua
join consumo
on pk_consumo=fk_consumo
join medidor
on pk_medidor=fk_medidor
join comunero
on pk_comunero=fk_comunero
where fk_comuna=fk_comun and fk_estado_pagos=1 ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pruebas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pruebas`(
cedul varchar(20)
)
begin
if(SELECT
        CASE 
            WHEN cedula IS NULL THEN 'FALSE' 
            ELSE 'TRUE' 
        END AS HasProfile 

FROM    comunero where cedula=cedul) = "TRUE"then
select "hola como estas te encontre";
else
select "hol como estas no te encontre";
end if;
end ;;
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

-- Dump completed on 2021-05-23 12:30:12
