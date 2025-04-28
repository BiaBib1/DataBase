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

-- 1. Creación y Configuración de la Base de Datos (MySQL) --
/* Se procederá con la creación de una base de datos que llamaremos DataSolutionDB con MySQL y, dentro de ella, una tabla clientes.
Se continuará estableciendo los campos de la tabla con sus respectivos valores y restricciones, 
definiendo, por ejemplo, el campo 'id' como entero, autoincrementable y como clave primaria.  */

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

/* Se procede a insertar los datos en la tabla, con los campos completados. */

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

-- 2. Creacion de Usuarios: --
/* A continuación, la creación de dos usuarios con sus respectivos permisos, utilizando los comandos CREATE USER y GRANT:
        el primero, 'consultor', con permisos de lectura sobre todas las tablas de la base de datos;
        el segundo, 'admin_venta', con permisos de lectura, inserción y actualización sobre la tabla clientes.
FLUSH PRIVILEGES se utiliza para actualizar los permisos de los usuarios.*/

-- Creacion de los usuarios con diferentes provilegios
CREATE USER 'consultor'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'consultor'@'localhost';
GRANT SELECT  ON `datasolutionsdb`.* TO 'consultor'@'localhost';
FLUSH PRIVILEGES;
            
CREATE USER 'admin_venta'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON *.* TO 'admin_venta'@'localhost';
GRANT SELECT, INSERT, UPDATE  ON TABLE `datasolutionsdb`.`clientes` TO 'admin_venta'@'localhost';
FLUSH PRIVILEGES;

-- 3. OPTIMIZACION DE CONSULTAS: --
/*Crear índices es recomendable para optimizar las consultas, especialmente cuando se realizan búsquedas sobre columnas específicas, como en este caso. */
SELECT * 
FROM clientes 
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';

/* En este caso, creamos índices con el comando CREATE INDEX, definiéndolos como idx_ciudad o idx_fecha en la tabla clientes
para las columnas ciudad y fecha_registro.
Aquí una versión optimizada. */

CREATE INDEX idx_ciudad_fecha ON clientes (ciudad, fecha_registro);

/* Para optimizar aún más la consulta, podemos usar EXPLAIN para analizar el plan de ejecución de la consulta.
EXPLAIN proporciona información sobre cómo la base de datos ejecutará la consulta, incluidos los índices utilizados y el número de filas examinadas.*/

EXPLAIN SELECT * 
FROM clientes 
WHERE ciudad = 'Madrid' AND fecha_registro > '2024-01-01';

/* Con SHOW PROCESSLIST podemos visualizar los procesos en curso
y con el comando KILL, indicando su ID, eliminarlos. */
-- Gestion de procesos
SHOW PROCESSLIST;

KILL <id_proceso>;


-- PARTE 2 --
/* Creacion de una base de datos clientes.db en Sqlite3, con la tabla clientes, con los mismos campos de la tabla clientes de MySQL.
Con el orden INSERt INTO se insertan los mismos datos. */

-- Volcando estructura de base de datos para clientes.db
CREATE DATABASE IF NOT EXISTS clientes.db;
USE clientes.db;

-- Tabla: clientes
CREATE TABLE IF NOT EXISTS clientes (
    id             INTEGER,
    nombre         TEXT,
    apellido       TEXT,
    ciudad         TEXT,
    fecha_registro NUMERIC,
    PRIMARY KEY (
        id
    )
);

-- Insercion de datos en la tabla clientes
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (1, 'Ana', 'Garcia', 'Madrid', '2024-02-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (2, 'Maria', 'Lopez', 'Tarragona', '2025-03-06');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (3, 'Gorka', 'Martinez', 'Valencia', '2022-10-18');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (4, 'David', 'Perez', 'Barcelona', '2020-11-19');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (5, 'Julia', 'Maion', 'Valladolid', '2021-09-26');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (6, 'Esteban', 'Soresina', 'Sevilla', '2022-04-24');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (7, 'Francisco', 'Arko', 'Granada', '2023-06-11');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (8, 'Lorea', 'Nazabal', 'Bilbao', '2024-01-02');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (9, 'Idoia', 'Gurmendi', 'Donostia', '2025-03-22');
INSERT INTO clientes (id, nombre, apellido, ciudad, fecha_registro) 
VALUES (10, 'Uxua', 'Arego', 'Pamplona', '2022-11-03');


-- Parte 3: Automatización de Tareas y Seguridad --

-- 1. Copias de seguridad --
/*En esta parte se crea una tabla de backup de clientes, con la misma estructura que la tabla clientes,
y se inserta una copia de los datos.*/

-- Creacion tabla de backup de clientes
CREATE TABLE IF NOT EXISTS clientes_backup LIKE clientes;
INSERT INTO clientes_backup SELECT * FROM clientes;

/* Ademas tramite el comando MYSQLDUMP en el CMD de Windows se pueden crear copias de seguridad de la tabla clientes
en diferentes formatos (sql, csv) indicando el usuario, el nombre de la base datos, la tabla, la ruta de la carpeta
y el formado elegido*/
    -- modificar el usuario y el nombre del usuario en la ruta
mysqldump -u usuario -p DataSolutionsDB clientes > C:/Users/NombreUsuario/Downloads/clientes_backup.sql

/* Aqui el codigo de un fichero .bat para crear un backup automatico de la tabla clientes en formato sql*/
    -- Modificar User, password y UserName en Path
@echo off
:: === Configura tus datos aquí ===
set MYSQL_USER=User
set MYSQL_PASSWORD=****
set MYSQL_DATABASE=DataSolutionsDB
set MYSQL_TABLE=clientes
set BACKUP_PATH=C:\Users\UserName\Downloads\clientes_backup.sql
set MYSQL_BIN_PATH="C:\Program Files\MariaDB 11.6\bin"

:: === Realiza el volcado de la tabla ===
%MYSQL_BIN_PATH%\mysqldump.exe -u %MYSQL_USER% -p%MYSQL_PASSWORD% %MYSQL_DATABASE% %MYSQL_TABLE% > "%BACKUP_PATH%"

echo.
echo Backup completado! El file si encuentra in Downloads.

pause

-- Creacion de un backup de clientes en formato csv en la carpeta C:\Program Files\MariaDB 11.6\data\datasolutionsdb
SELECT * FROM clientes INTO OUTFILE 'clientes_backup.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- 2. Procedimientos almacenados --
/* En esta parte se crea un procedimiento almacenado que valide la integridad de los datos al insertar un nuevo cliente en la tabla clientes de MySQL.
 Este procedimiento verifica que el campo fecha_registro no sea una fecha futura.*/

-- Creacion del procedimiento almacenado
DELIMITER //
CREATE PROCEDURE InsertarClienteSeguro(
    IN nombre VARCHAR(255),
    IN apellido VARCHAR(255),
    IN ciudad VARCHAR(100),
    IN fecha_registro DATE,
    OUT mensaje VARCHAR(255)
)
BEGIN
    -- Validamos que la fecha no sea futura
    IF fecha_registro > CURDATE() THEN
        SET mensaje = 'Error: Esta no es una maquina del tiempo';
    ELSE
        -- Si la fecha es válida, insertamos el cliente
        INSERT INTO clientes (nombre, apellido, ciudad, fecha_registro)
        VALUES (nombre, apellido, ciudad, fecha_registro);
        SET mensaje = 'Cliente insertado correctamente';
    END IF;
END //
DELIMITER ;

-- Para lanzar el procedimiento hay que ejecutar
CALL InsertarClienteSeguro('Juan', 'Pérez', 'Madrid', '2025-05-10', @mensaje);
SELECT @mensaje; -- Verifica si hubo error o éxito


-- 3. Disparador (Trigger)  --
/*I trigger sono procedure automatiche che vengono eseguite dal database in risposta a eventi specifici. 
Le operazioni che possono attivare un trigger includono INSERT, UPDATE o DELETE e possono essere eseguite prima o dopo l'evento (BEFORE o AFTER).
In questo caso, creiamo un trigger che si attiva AFTER un'operazione di UPDATE sulla tabella clientes.
I trigger è associato a una tabella e viene eseguito automaticamente quando si verifica l'evento.
Qui creiamo una tabella di audit chiamata log_clientes per registrare le modifiche apportate (datos_nuevos).*/

-- Creacion de la tabla log_clientes
CREATE TABLE IF NOT EXISTS log_clientes (
    id INT NOT NULL AUTO_INCREMENT,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(50) NULL,
    operacion VARCHAR(20) NULL,
    datos_antiguos VARCHAR(255) NULL,
    datos_nuevos VARCHAR(255) NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creacion del trigger
DELIMITER //
CREATE TRIGGER tr_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Verifica se cambia il nome
    IF NEW.nombre != OLD.nombre THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.nombre, NEW.nombre);
    END IF;
    
    -- Verifica se cambia il cognome
    IF NEW.apellido != OLD.apellido THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.apellido, NEW.apellido);
    END IF;
    
	 -- Verifica se cambia la città
    IF NEW.ciudad != OLD.ciudad THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.ciudad, NEW.ciudad);
    END IF;
    
    -- Verifica se cambia la fecha_registro
    IF NEW.fecha_registro != OLD.fecha_registro THEN
        INSERT INTO log_clientes (usuario, operacion, datos_antiguos, datos_nuevos)
        VALUES (CURRENT_USER(), 'UPDATE', OLD.fecha_registro, NEW.fecha_registro);
    END IF;
END//
DELIMITER ;

-- Para probar el trigger, actualizamos un cliente
UPDATE clientes SET ciudad = 'Modena' WHERE id = 1;

--PARTE 4: Planificación de Tareas --

-- 1. Planificación de Copias de Seguridad:--
/* per piancificare una copia di sicurezza automatica creiamo un file.bat utilizzando mysqldump,
all'interno del quale creiamo la connessione col il database, una cartella per il file che si genererà
e il file stesso in .sql */

    -- Modificare l'utente e la password
@echo Starting BackUp

set MYSQL_BIN="C:\Program Files\MariaDB 5.5\bin\mysqldump.exe"
set DB_USER=Usuario
set DB_PASS=****
set DB_NAME=DataSolutionsDB
set BACKUP_DIR="C:\BackupMySQL"

:: Crea carpeta si no existe
if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

:: Genera nombre file con data
set BACKUP_FILE=%DB_NAME%_%DATE:/=-%.sql

:: Ejecuta backup
%MYSQL_BIN% -u%DB_USER% -p%DB_PASS% %DB_NAME% > %BACKUP_DIR%\%BACKUP_FILE%

echo Backup completado en %BACKUP_DIR%\%BACKUP_FILE%
pause

/*Pianificazione automatica con Task Scheduler di Windows:

Cerca "Utilità di pianificazione" nel menu Start
Crea task:
Azione → "Crea attività di base"
Nome: "Backup MySQL giornaliero"
Trigger: Quotidiano (es. alle 23:00)
Azione: "Avvia un programma"
Programma: C:\percorso\backup_mysql.bat
*/

-- 2. Monitoreo del Rendimiento: --

/*dbeaver
Performance Dashboard:
Menu Database > Performance > Dashboard mostra in tempo reale:
    Query attive
    Utilizzo CPU/RAM
    Latenza delle query
Explain Plan:
Click destro su una query > Explain Execution Plan per analizzare l'uso degli indici.*/

/*HeidiSQL
Session Manager:
Menu Tools > Session Manager elenca tutte le connessioni attive con:
    Tempo di esecuzione
    Query in corso
    Stato (Lock, Sending data, etc.)*/


SHOW FULL PROCESSLIST;
/*Mostra tutte le connessioni attive e le query in esecuzione.*/
SHOW STATUS LIKE 'Threads_connected';

/*Mostra le query in esecuzione da più di 10 secondi.*/
SELECT * FROM information_schema.processlist 
WHERE COMMAND != 'Sleep' AND TIME > 10
ORDER BY TIME DESC;




/* quasi
DELIMITER //
CREATE TRIGGER tr_auditoria_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes (
        usuario,
        operacion,
        datos_antiguos,
        datos_nuevos
    ) VALUES (
        CURRENT_USER(),
        'UPDATE',
        -- Solo los campos clave
        OLD.nombre,
        NEW.nombre
    );
END//
DELIMITER ;
*/
/*DELIMITER //
CREATE TRIGGER trg_audit_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes (
		fecha_modificacion, 
		usuario, 
		operacion, 
		datos_antiguos, 
		datos_nuevos
	)
    VALUES (
        CURRENT_TIMESTAMP,
        CURRENT_USER(),
        'UPDATE',
        NEW.id, 
		NEW.nombre, 
		NEW.apellido, 
		NEW.ciudad, 
		NEW.fecha_registro
    );
END;
//
DELIMITER ;
*/


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
