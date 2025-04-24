-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.6.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- PARTE 1 --

-- Volcando estructura de base de datos para datasolutionsdb
CREATE DATABASE IF NOT EXISTS `datasolutionsdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `datasolutionsdb`;

-- Volcando estructura para tabla datasolutionsdb.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla datasolutionsdb.clientes: ~10 rows (aproximadamente)
INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `ciudad`, `fecha_registro`) VALUES
	(1, 'Ana', 'Garcia', 'Madrid', '2024-02-02'),
	(2, 'Maria', 'Lopez', 'Tarragona', '2025-03-06'),
	(3, 'Gorka', 'Martinez', 'Valencia', '2022-10-18'),
	(4, 'David', 'Perez', 'Barcelona', '2020-11-19'),
	(5, 'Julia', 'Maion', 'Valladolid', '2021-09-26'),
	(6, 'Esteban', 'Soresina', 'Sevilla', '2022-04-24'),
	(7, 'Francisco', 'Arko', 'Granada', '2023-06-11'),
	(8, 'Lorea', 'Nazabal', 'Bilbao', '2022-01-25'),
	(9, 'Idoia', 'Gurmendi', 'Donostia', '2025-03-22'),
	(10, 'Uxua', 'Arego', 'Pamplona', '2022-11-03');

-- Creacion de los usuarios con diferentes provilegios
CREATE USER 'consultor'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'consultor'@'localhost';
GRANT SELECT  ON `datasolutionsdb`.* TO 'consultor'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'admin_venta'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'admin_venta'@'localhost';
GRANT SELECT, INSERT, UPDATE  ON TABLE `datasolutionsdb`.`clientes` TO 'admin_venta'@'localhost';
FLUSH PRIVILEGES;

EXPLAIN SELECT * 
FROM clientes 
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';

-- PARTE 2 --

-- Archivo generado con SQLiteStudio v3.4.17 el ju. abr. 24 14:08:36 2025
--
-- Codificaciòn de texto usada: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabla: clientes
CREATE TABLE IF NOT EXISTS clientes (id INTEGER, nombre TEXT, apellido TEXT, ciudad TEXT, fecha_registro NUMERIC, PRIMARY KEY (id));

INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (1, 'Ana', 'Garcia', 'Madrid', '2024-02-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (2, 'Maria', 'Lopez', 'Tarragona', '2025-03-06');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (3, 'Gorka', 'Martinez', 'Valencia', '2022-10-18');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (4, 'David', 'Perez', 'Barcelona', '2020-11-19');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (5, 'Julia', 'Maion', 'Valladolid', '2021-09-26');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (6, 'Esteban', 'Soresina', 'Sevilla', '2022-04-24');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (7, 'Francisco', 'Arko', 'Granada', '2023-06-11');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (8, 'Lorea', 'Nazabal', 'Bilbao', '2024-01-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (9, 'Idoia', 'Gurmendi', 'Donostia', '2025-03-22');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) VALUES (10, 'Uxua', 'Arego', 'Pamplona', '2022-11-03');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
