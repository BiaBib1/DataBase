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


-- Volcando estructura de base de datos para empresa
CREATE DATABASE IF NOT EXISTS `empresa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `empresa`;

-- Volcando estructura para tabla empresa.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `correo` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla empresa.clientes: ~3 rows (aproximadamente)
INSERT INTO `clientes` (`id`, `nombre`, `correo`) VALUES
	(1, 'Ana Pérez', 'ana@email.com'),
	(2, 'Carlos López', 'carlos@email.com'),
	(3, 'María Gómez', 'maria@email.com');

-- Volcando estructura para tabla empresa.transacciones
CREATE TABLE IF NOT EXISTS `transacciones` (
  `id_transaccione` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL DEFAULT 0,
  `fecha` date NOT NULL,
  `monto` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_transaccione`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla empresa.transacciones: ~5 rows (aproximadamente)
INSERT INTO `transacciones` (`id_transaccione`, `id_cliente`, `fecha`, `monto`) VALUES
	(111, 1, '2024-02-01', 200.5),
	(112, 1, '2024-02-05', 350.75),
	(113, 2, '2024-02-02', 120),
	(114, 3, '2024-02-07', 500),
	(115, 2, '2024-02-10', 250.25);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

SELECT transacciones.id_transaccione, transacciones.fecha, transacciones.monto, clientes.id
FROM transacciones, clientes
WHERE id_cliente = (
	SELECT clientes.id WHERE nombre = 'Ana Pérez'
);

/*SELECT id_transaccione, fecha, monto
FROM transacciones
WHERE id_cliente = (
	SELECT id FROM clientes WHERE nombre = 'Ana Pérez'
);
*/

SELECT transacciones.id_transaccione, transacciones.fecha, transacciones.monto, clientes.id
FROM transacciones, clientes
WHERE transacciones.id_cliente = clientes.id AND clientes.nombre = 'Ana Pérez'

SELECT *
FROM transacciones, clientes
WHERE transacciones.id_cliente = clientes.id
