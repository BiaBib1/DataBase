-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              5.5.52-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database bookstore
CREATE DATABASE IF NOT EXISTS `bookstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `bookstore`;

-- Dump della struttura di tabella bookstore.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `apellido` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `telefono` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `idx_clientes_telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella bookstore.clientes: ~10 rows (circa)
INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellido`, `email`, `telefono`) VALUES
	(1, 'Ana', 'Garcia', 'ana.garcia@g.com', 666111222),
	(2, 'Maria', 'Lopez', 'maria.lopez@g.com', 666111333),
	(3, 'Gorka', 'Martinez', 'gorka.martinez@g.com', 666111444),
	(4, 'David', 'Perez', 'david.perez@g.com', 666222555),
	(5, 'Julia', 'Maion', 'julia.maion@g.com', 666111777),
	(6, 'Esteban', 'Soresina', 'esteban.soresina@g.com', 666122333),
	(7, 'Francisco', 'Arko', 'francisco.arko@g.com', 666112444),
	(8, 'Lorea', 'Nazabal', 'lorea.nazabal@g.com', 666221777),
	(9, 'Idoia', 'Gurmendi', 'idoia.gurmendi@g.com', 666121554),
	(10, 'Uxua', 'Arego', 'uxua.arego@g.com', 666123444);

-- Dump della struttura di tabella bookstore.items_pedido
CREATE TABLE IF NOT EXISTS `items_pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_libro` int(11) NOT NULL DEFAULT '0',
  `cantidad` int(11) NOT NULL DEFAULT '0',
  `precio_por_item` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pedido`,`id_libro`) USING BTREE,
  KEY `FK_id_libro` (`id_libro`),
  CONSTRAINT `FK_id_libro` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella bookstore.items_pedido: ~10 rows (circa)
INSERT INTO `items_pedido` (`id_pedido`, `id_libro`, `cantidad`, `precio_por_item`) VALUES
	(1, 1, 2, 14),
	(2, 2, 1, 10),
	(3, 3, 2, 16),
	(4, 4, 1, 18),
	(5, 5, 1, 15),
	(6, 6, 1, 18),
	(7, 7, 1, 22),
	(8, 8, 1, 11),
	(9, 9, 1, 18),
	(10, 10, 1, 15);

-- Dump della struttura di tabella bookstore.libros
CREATE TABLE IF NOT EXISTS `libros` (
  `id_libro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio` float NOT NULL,
  `cantitad_en_stock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_libro`),
  KEY `idx_libros_autor` (`autor`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella bookstore.libros: ~11 rows (circa)
INSERT INTO `libros` (`id_libro`, `titulo`, `autor`, `genero`, `precio`, `cantitad_en_stock`) VALUES
	(1, 'Accabadora', 'Michela_Murgia', 'Narrativa', 13.66, 3),
	(2, 'Canne_al_vento', 'Grazia_Deledda', 'Narrativa', 9.99, 1),
	(3, 'Capitan_Fracassa', 'Théophile_Gautier', 'Avventura', 15.59, 2),
	(4, 'Via_col_vento', 'Margaret_Mitchell', 'Romanzo_storico', 18.29, 7),
	(5, 'Notre_Dame_de_Paris', 'Victor_Hugo', 'Romanzo_storico', 14.59, 6),
	(6, 'La_vasca_del_Führer', 'Serena Dandini', 'Biografico', 17.5, 1),
	(7, 'Il_Conte_di_Montecristo', 'Alexandre Dumas', 'Avventura', 21.99, 4),
	(8, 'Gita_al_faro', 'Virginia_Woolf', 'Narrativa', 11.39, 7),
	(9, 'Memorie_di_Adriano', 'Marguerite_Yourcenar', 'Romanzo_storico', 17.99, 3),
	(10, 'Kafka_sulla_spiaggia', 'Haruki_Murakami', 'Narrativa', 15.2, 1),
	(11, 'Le_braci', 'Sándor_Márai', 'Narrativa', 7.29, 2);

-- Dump della struttura di tabella bookstore.pedidos
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL DEFAULT '0',
  `fecha_pedido` date NOT NULL,
  `monto_total` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pedido`),
  KEY `idx_pedidos_fecha` (`fecha_pedido`),
  KEY `idx_pedidos_cliente` (`id_cliente`),
  CONSTRAINT `FK_pedidos_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dump dei dati della tabella bookstore.pedidos: ~10 rows (circa)
INSERT INTO `pedidos` (`id_pedido`, `id_cliente`, `fecha_pedido`, `monto_total`) VALUES
	(1, 1, '2023-05-10', 27.32),
	(2, 2, '2023-05-11', 9.99),
	(3, 3, '2023-05-12', 31.18),
	(4, 4, '2023-05-13', 18.29),
	(5, 5, '2023-05-14', 14.59),
	(6, 6, '2023-05-15', 17.5),
	(7, 7, '2023-05-16', 21.99),
	(8, 8, '2023-05-17', 11.39),
	(9, 9, '2023-05-18', 17.99),
	(10, 10, '2023-05-19', 15.2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Appunti

CREATE INDEX idx_libros_autor ON Libros(autor);
CREATE INDEX idx_pedidos_fecha ON Pedidos(fecha_pedido);
CREATE INDEX idx_pedidos_cliente ON Pedidos(id_cliente);
CREATE INDEX idx_clientes_telefono ON clientes(telefono);

-- Creazione utente Gerente con tutti i privilegi
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'password_gerente';
GRANT ALL PRIVILEGES ON BookShop.* TO 'gerente'@'localhost';

-- Creazione utente AgenteVentas con permessi limitati
CREATE USER 'agente_ventas'@'localhost' IDENTIFIED BY 'password_agente';
GRANT SELECT ON BookShop.Libros TO 'agente_ventas'@'localhost';
GRANT SELECT ON BookShop.Clientes TO 'agente_ventas'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BookShop.Pedidos TO 'agente_ventas'@'localhost';
GRANT SELECT ON BookShop.Items_Pedido TO 'agente_ventas'@'localhost';

-- 5 Optimizacion consulta
-- Query complessa
EXPLAIN SELECT DISTINCT c.id_cliente, c.nombre, c.apellido
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
JOIN Items_Pedido ip ON p.id_pedido = ip.id_pedido
JOIN Libros l ON ip.id_libro = l.id_libro
WHERE l.genero = 'Narrativa'
AND p.fecha_pedido >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);