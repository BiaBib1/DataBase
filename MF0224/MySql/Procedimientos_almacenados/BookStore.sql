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


-- PARTE 1. Diseño de la Base de Datos
-- Elige MySQL o SQLite como el SGBD.
/* Se ha optado por MySQL como SGBD para la base de datos por las siguientes razones:
  - MySQL admite múltiples usuarios con un sistema de privilegios avanzado, mientras que SQLite no cuenta con un sistema de usuarios, siendo una base de datos de archivo único sin autenticación integrada.
  - MySQL permite el uso de triggers complejos, mientras que SQLite tiene triggers más limitados y no soporta procedimientos almacenados.
  - Mysqldump permite realizar copias de seguridad estructuradas con un simple comando, mientras que SQLite requiere copias manuales del archivo .sqlite, por lo tanto MySQL se puede automatizar fácilmente.
  - Una base de datos real podría crecer con la adición de nuevas tablas (por ejemplo, Editores, Promociones) y el aumento de pedidos, MySQL soporta grandes volúmenes de datos a diferencia de SQLite.
*/

-- 2. Diseña un esquema de base de datos

-- 3. Explicación de las decisiones de diseño: 
/* La base de datos es un sistema de gestión de ventas de libros, que incluye las tablas clientes, libros, pedidos e items_pedido.
La tabla clientes almacena la información de los clientes, incluyendo su nombre (VARCHAR), apellido (VARCHAR), email (VARCHAR) y teléfono (INT).
La tabla libros almacena información sobre los libros, incluyendo su título (VARCHAR), autor (VARCHAR), género (VARCHAR), precio (FLOAT) y cantidad en stock (INT).
La tabla pedidos almacena información sobre los pedidos realizados por los clientes, incluyendo el id del cliente (INT), la fecha del pedido (DATE) y el monto total (FLOAT).
La tabla items_pedido almacena información sobre los libros incluidos en cada pedido, incluyendo el id del libro (INT), la cantidad (INT) y el precio por ítem (FLOAT).

Las relaciones entre las tablas son las siguientes:
- Un cliente puede realizar múltiples pedidos, pero un pedido pertenece a un solo cliente (1:N).
- Un pedido puede incluir múltiples libros, y un libro puede estar en múltiples pedidos (N:M).
- La tabla items_pedido actúa como tabla intermedia para gestionar la relación entre pedidos y libros.
- La tabla pedidos tiene una relación de 1:N con la tabla items_pedido, ya que un pedido puede incluir múltiples ítems.
- La tabla libros tiene una relación de 1:N con la tabla items_pedido, ya que un libro puede estar en múltiples pedidos.

Se han creado índices para optimizar las consultas, especialmente en los campos que se utilizan con frecuencia en búsquedas y uniones.
- Se han creado índices en los campos id_cliente, fecha_pedido, id_libro y título para mejorar el rendimiento de las consultas.
- Se ha creado un índice único en el campo teléfono de la tabla clientes para garantizar que no haya duplicados y mejorar la búsqueda por número. */


-- PARTE 2. e 3. Creación de la Base de Datos y Gestión de Usuarios

-- 1. Creación de la base de datos, tablas y datos.
/* Siguiendo el diseño de la base de datos previamente explicado, se procede con la creación de las diferentes tablas necesarias.
Primero la tabla 'clientes' seguida de la inserción de sus datos, luego 'libros' con 11 filas de datos, 'pedidos' también con datos
al igual que la tabla 'items_pedido'. */

-- Volcando estructura de base de datos para bookstore
CREATE DATABASE IF NOT EXISTS `bookstore`; 
USE `bookstore`;

-- Volcando estructura para tabla bookstore.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `apellido` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '0',
  `telefono` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `idx_clientes_telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bookstore.clientes: ~10 rows (aproximadamente)
INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellido`, `email`, `telefono`) 
VALUES
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


-- Volcando estructura para tabla bookstore.libros
CREATE TABLE IF NOT EXISTS `libros` (
  `id_libro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL,
  `autor` varchar(50) NOT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `precio` float NOT NULL,
  `cantidad_en_stock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_libro`),
  KEY `idx_libros_autor` (`titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bookstore.libros: ~11 rows (aproximadamente)
INSERT INTO `libros` (`id_libro`, `titulo`, `autor`, `genero`, `precio`, `cantidad_en_stock`) 
VALUES
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

-- Volcando estructura para tabla bookstore.pedidos
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL DEFAULT '0',
  `fecha_pedido` date NOT NULL,
  `monto_total` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pedido`),
  KEY `idx_pedidos_fecha` (`fecha_pedido`),
  KEY `idx_pedidos_cliente` (`id_cliente`),
  CONSTRAINT `FK_pedidos_clientes` FOREIGN KEY (`id_cliente`) 
  REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bookstore.pedidos: ~10 rows (aproximadamente)
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

-- Volcando estructura para tabla bookstore.items_pedido
CREATE TABLE IF NOT EXISTS `items_pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_libro` int(11) NOT NULL DEFAULT '0',
  `cantidad` int(11) NOT NULL DEFAULT '0',
  `precio_por_item` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pedido`,`id_libro`) USING BTREE,
  KEY `FK_id_libro` (`id_libro`),
  CONSTRAINT `FK_id_libro` FOREIGN KEY (`id_libro`) 
  REFERENCES `libros` (`id_libro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_pedido` FOREIGN KEY (`id_pedido`) 
  REFERENCES `pedidos` (`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bookstore.items_pedido: ~10 rows (aproximadamente)
INSERT INTO Items_Pedido (id_pedido, id_libro, cantidad, precio_por_item) VALUES
(1, 1, 2, 13.66),
(2, 2, 1, 9.99),
(3, 3, 2, 15.59),
(4, 4, 1, 18.29),
(5, 5, 1, 14.59),
(6, 6, 1, 17.50),
(7, 7, 1, 21.99),
(8, 8, 1, 11.39),
(9, 9, 1, 17.99),
(10, 10, 1, 15.20);


-- 2. Creación de usuarios y privilegios
/* Creacion de un usuario Gerente (acceso completo a todos los datos)*/
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'password_gerente';
GRANT ALL PRIVILEGES ON bookshop.* TO 'gerente'@'localhost';

/*Creazione utente AgenteVentas (acceso de lectura a las tablas libros, clientes y pedidos,
 y acceso de escritura solo a la tabla pedidos)*/
CREATE USER 'agente_ventas'@'localhost' IDENTIFIED BY 'password_agente';
GRANT SELECT ON bookshop.libros TO 'agente_ventas'@'localhost';
GRANT SELECT ON bookshop.clientes TO 'agente_ventas'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookshop.pedidos TO 'agente_ventas'@'localhost';
GRANT SELECT ON bookshop.items_pedido TO 'agente_ventas'@'localhost';


-- PARTE 4: Scripring para optimizar

-- 1. Crear un procedimiento almacenado para gestión de Inventario: 
-- Actualizar automáticamente la cantidad_en_stock en la tabla libros cuando se realiza un nuevo pedido.
/* Al activarse, el procedimiento almacenado insertará en la tabla pedidos el nuevo pedido, registrando la fecha actual gracias a CURDATE
y calculando el monto total multiplicando la cantidad por el precio del libro individual.
Luego procederá a insertar en la tabla items_pedido los valores del nuevo pedido y actualizará la cantidad_en_stock en la tabla libros. */

DELIMITER //

CREATE PROCEDURE realizar_pedido(
  IN pid_pedido INT,
  IN pid_cliente INT,
  IN pid_libro INT,
  IN pcantidad INT,
  IN pprecio DECIMAL(10,2)
)
BEGIN
  -- Inserisce il nuovo ordine (semplificato)
  INSERT INTO pedidos (id_pedido, id_cliente, fecha_pedido, monto_total)
  VALUES (pid_pedido, pid_cliente, CURDATE(), pcantidad * pprecio);

  -- Inserisce l'item
  INSERT INTO items_pedido (id_pedido, id_libro, cantidad, precio_por_item)
  VALUES (pid_pedido, pid_libro, pcantidad, pprecio);

  -- Aggiorna lo stock
  UPDATE libros
  SET cantidad_en_stock = cantidad_en_stock - pcantidad
  WHERE id_libro = pid_libro;
END;
//

DELIMITER ;

-- Ejecutar el procedimiento para un nuevo pedido
/* con la función CALL en la que insertamos id_pedido, id_cliente, id_libro, cantidad y una SELECT para calcular el precio del monto_total.
Elegimos el 1001 como id_pedido para diferenciarlo de los pedidos ya insertados anteriormente,
y suponemos que la clienta Ana Garcia desea 3 copias del libro "Canne al Vento", cuyo precio se identifica mediante
una SELECT en la tabla libros donde el id del libro corresponde al del pedido. */

CALL realizar_pedido(1001, 1, 2, 3, (SELECT precio FROM libros WHERE id_libro = 2));

-- 2. Informes de Ventas:
-- Generar un trigger para el informe diario de ventas que resuma el monto total de ventas por género.
/* Primero se procede a crear una tabla que pueda almacenar los informes de ventas,
luego procedemos con la creación del TRIGGER report_ventas que realizará, después de un INSERT en la tabla pedidos,
un INSERT en la nueva tabla report_ventas_diaria con el total de ventas y la suma de los pedidos divididos por género. */

-- Crear tabla para almacenar el informe diario de ventas
CREATE TABLE report_ventas_diarias (
    id_report INT AUTO_INCREMENT PRIMARY KEY,
    data_report DATE NOT NULL,
    genero VARCHAR(50) NOT NULL,
    total_ventas DECIMAL(10,2) NOT NULL,
    numero_pedidos INT NOT NULL
);

-- Trigger para el informe diario de ventas
DELIMITER //
CREATE TRIGGER report_ventas
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    -- Elimina posibles registros anteriores con la misma fecha
    DELETE FROM report_ventas_diarias WHERE data_report = DATE(NEW.fecha_pedido);
    
    -- Inserta los nuevos datos agregados
    INSERT INTO report_ventas_diarias (data_report, genero, total_ventas, numero_pedidos)
    SELECT 
        DATE(NEW.fecha_pedido),
        l.genero,
        SUM(ip.cantidad * ip.precio_por_item),
        COUNT(DISTINCT p.id_pedido)
    FROM pedidos p
    JOIN items_pedido ip ON p.id_pedido = ip.id_pedido
    JOIN libros l ON ip.id_libro = l.id_libro
    WHERE DATE(p.fecha_pedido) = DATE(NEW.fecha_pedido)
    GROUP BY l.genero;
END //
DELIMITER ;

-- Para activar el trigger generamos nuevos pedidos
CALL realizar_pedido(1002, 1, 1, 1, (SELECT precio FROM libros WHERE id_libro = 1));
CALL realizar_pedido(1003, 1, 8, 1, (SELECT precio FROM libros WHERE id_libro = 8));
CALL realizar_pedido(1004, 1, 10, 2, (SELECT precio FROM libros WHERE id_libro = 10));
CALL realizar_pedido(1005, 3, 11, 1, (SELECT precio FROM libros WHERE id_libro = 11));
CALL realizar_pedido(1006, 2, 11, 1, (SELECT precio FROM libros WHERE id_libro = 11));
CALL realizar_pedido(1007, 2, 3, 1, (SELECT precio FROM libros WHERE id_libro = 3));


-- Consulta para verificar el informe diario de ventas
/* Al realizar una SELECT de la nueva tabla creada, se podrá visualizar que durante el día se realizaron
6 pedidos del género "Narrativa" y 1 del género "Avventura" */

SELECT  *
FROM report_ventas_diarias;

-- 3. Respaldo y Recuperación: 
-- Implementar un script para respaldar la base de datos a un archivo.
/* Para la copia de seguridad se ha optado por utilizar un archivo batch de Windows,
que ejecuta `mysqldump` para realizar el respaldo de la base de datos "bookstore" y lo guarda en una carpeta de respaldo.
La carpeta se crea si no existe ya, y el archivo de respaldo se nombra con la fecha actual.
Para ejecutar el archivo, es suficiente copiar el script en un bloc de notas y guardarlo con extensión .bat,
luego ejecutarlo. */

@echo Starting BackUp

set MYSQL_BIN="C:\Program Files\MariaDB 5.5\bin\mysqldump.exe"
set DB_USER=root
set DB_PASS=0000
set DB_NAME=BookStore
set BACKUP_DIR="C:\BackupMySQL"

:: Crea carpeta si no existe
if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

:: Genera nombre file con data
set BACKUP_FILE=%DB_NAME%_%DATE:/=-%.sql

:: Ejecuta backup
%MYSQL_BIN% -u%DB_USER% -p%DB_PASS% %DB_NAME% > %BACKUP_DIR%\%BACKUP_FILE%

echo Backup completado en %BACKUP_DIR%\%BACKUP_FILE%
pause

-- PARTE 5. Indexes y optimización de consultas

-- 1. Creacion de una cosnulta compleja:
/* Aquí una consulta compleja que recupera datos de múltiples tablas listando todos los clientes 
que han realizado pedidos de libros del género 'Narrativa' en el último mes.
La función CONCAT agrupa bajo el alias Cliente el nombre y apellido de cada cliente,
la fecha_pedido nos permite verificar que se trate de datos del mes actual,
uniendo la tabla items_pedido y libros es posible obtener también los títulos de los libros y la cantidad de ejemplares
vendidos del género 'Narrativa' */

SELECT p.fecha_pedido, 
concat(c.id_cliente, '. ', c.nombre, ' ', c.apellido) AS Cliente, 
l.id_libro, l.titulo, ip.cantidad, p.monto_total
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN items_pedido ip ON p.id_pedido = ip.id_pedido
JOIN libros l ON ip.id_libro = l.id_libro
WHERE l.genero = 'Narrativa'
AND p.fecha_pedido >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- 2. Optimizacion consulta para analizar el plan de ejecución
/* La consulta anterior ha sido optimizada para mejorar su rendimiento y acelerar la ejecución.
En este caso se ha optado por utilizar un JOIN entre las tablas clientes, pedidos, items_pedido y libros.
Con la función EXPLAIN es posible analizar el plan de ejecución de la consulta
y verificar si la optimización ha sido exitosa. */

EXPLAIN SELECT p.fecha_pedido, 
concat(c.id_cliente, '. ', c.nombre, ' ', c.apellido) AS Cliente, 
l.id_libro, l.titulo, ip.cantidad, p.monto_total
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN items_pedido ip ON p.id_pedido = ip.id_pedido
JOIN libros l ON ip.id_libro = l.id_libro
WHERE l.genero = 'Narrativa'
AND p.fecha_pedido >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);

-- 3. Creacion de indices como tecnica de optimización para mejorar el rendimiento de la consulta
/* Además, para acelerar la consulta anterior, se prefirió indexar los campos utilizados en la SELECT,
es decir, la fecha_pedido para verificar que correspondiera al mes correcto y los títulos de los libros.
También se añadió un índice adicional para el campo 'telefono', ya que es una clave única en la tabla clientes.
En el supuesto de un pedido realizado por teléfono, sería más rápido obtener los datos de los pedidos
a través del propio número. */


CREATE INDEX idx_pedidos_fecha ON pedidos(fecha_pedido);
CREATE INDEX idx_libros_autor ON libros(titulo);
CREATE INDEX idx_pedidos_cliente ON pedidos(id_cliente);
CREATE INDEX idx_clientes_telefono ON clientes(telefono);

-- PARTE 6. Planificación de Tareas Administrativa

-- 1. Programacion de una tarea para realizar copias de seguridad
/* Para la planificación de las actividades administrativas se ha elegido utilizar el Programador de tareas de Windows,
que permite ejecutar automáticamente el archivo .bat creado previamente para la copia de seguridad de la base de datos.
A continuación, el script de copia de seguridad diaria para MariaDB/MySQL, que ejecuta mysqldump para hacer una copia de seguridad de la base de datos "bookstore"
creando la conexión con el usuario y la contraseña correspondientes.
El archivo .sql generado se guarda en una carpeta de respaldo, creada si no existe, y se nombra con la fecha actual.
Además, el archivo .bat se encarga de eliminar los archivos de respaldo más antiguos de 30 días,
para evitar ocupar demasiado espacio. */

  -- Modificar el usuario y la contraseña
@echo off
:: Script di backup diario per MariaDB/MySQL - BookShop

:: Configurazione
set DB_USER=root
set DB_PASSWORD=0000
set DB_NAME=BookStore
set BACKUP_DIR=C:\BackupDB
set MYSQL_BIN="C:\Program Files\MariaDB 5.5\bin\mysqldump.exe"

:: Crea directory backup si no existe
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Nombre file backup
set BACKUP_FILE=%DB_NAME%_%DATE:/=-%.sql

:: Ejecuta backup
%MYSQL_BIN% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% > %BACKUP_DIR%\%BACKUP_FILE%

:: Elimina backup mas viejos de 30 dias
forfiles /p "%BACKUP_DIR%" /m BookShop_Backup_*.sql /d -30 /c "cmd /c del @file"

echo Backup completato: %BACKUP_FILE%
pause

/*Planificación automática con el Programador de tareas de Windows:

    Busca "Programador de tareas" en el menú de Inicio
    Crear tarea:
    Acción → "Crear tarea básica"
    Nombre: "Copia de seguridad diaria de MySQL"
    Disparador: Diario (por ejemplo, a las 23:00)
    Acción: "Iniciar un programa"
    Programa: C:\ruta\backup_mysql.bat
    Finalizando: "Finalizar".
*/

-- 2. Explicacion de la importancia de la planificación de tareas administrativa
/* La planificación de las actividades administrativas es un aspecto fundamental en la gestión de una base de datos.
Automatizar operaciones como las copias de seguridad garantiza que el sistema se mantenga estable, seguro y eficiente a lo largo del tiempo.
Una copia de seguridad estructurada (con la fecha en el nombre del archivo, como en tu caso) permite restaurar rápidamente
el estado anterior de la base de datos en caso de accidentes de hardware, errores humanos, ataques informáticos o corrupción de datos
que puedan causar pérdidas irreversibles. Además, mysqldump es la herramienta más común para exportar datos de manera estructurada. */

/*Realización de una base de datos completa para una librería (BookShop), utilizando MySQL como sistema de gestión, con una estructura bien organizada y funcionalidades avanzadas.
Puntos Clave Desarrollados:

Diseño de la Base de Datos
Creación de tablas bien estructuradas (Libros, Clientes, Pedidos, Items_Pedido).
Elección de claves primarias/foráneas para garantizar la integridad referencial.
Uso de tipos de datos apropiados (DECIMAL para precios, INT para ID, VARCHAR para texto).

Gestión de Usuarios y Permisos
Diferenciación de roles (Gerente vs AgenteVentas) con privilegios específicos.
Asignación de permisos granulares (por ejemplo, solo lectura en Libros, pero modificación en Pedidos).

Automatización con Scripts y Triggers
Procedimientos almacenados para actualizar automáticamente el stock (cantidad_en_stock).
Triggers para generar reportes diarios (ventas por género).
Scripts de copia de seguridad programados (a través de .bat).

Optimización de Consultas (UF1470)
Uso de EXPLAIN para analizar el rendimiento.
Creación de índices en campos críticos (género, fecha_pedido).

Planificación de Actividades (UF1468)
Copias de seguridad automatizadas a través del Programador de Tareas de Windows.*/

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
