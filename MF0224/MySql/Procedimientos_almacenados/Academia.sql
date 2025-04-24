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


-- Volcando estructura de base de datos para academia
CREATE DATABASE IF NOT EXISTS `academia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `academia`;

-- Volcando estructura para tabla academia.alumno
CREATE TABLE IF NOT EXISTS `alumno` (
  `ID_Alumno` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Apellidos` varchar(255) NOT NULL,
  `DNI` varchar(20) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_Alumno`),
  UNIQUE KEY `DNI` (`DNI`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla academia.alumno: ~16 rows (aproximadamente)
INSERT INTO `alumno` (`ID_Alumno`, `Nombre`, `Apellidos`, `DNI`, `Email`, `Telefono`) VALUES
	(1, 'Ana', 'García', '12345678A', 'ana.garcia@email.com', '612345678'),
	(2, 'Pedro', 'Martínez', '87654321B', 'pedro.martinez@email.com', '687654321'),
	(3, 'Lucía', 'Pérez', '23456789C', 'lucia.perez@email.com', '623456789'),
	(4, 'Javier', 'Sánchez', '98765432D', 'javier.sanchez@email.com', '698765432'),
	(5, 'María', 'López', '34567890E', 'maria.lopez@email.com', '634567890'),
	(6, 'David', 'Ruiz', '09876543F', 'david.ruiz@email.com', '609876543'),
	(7, 'Elena', 'Torres', '45678901G', 'elena.torres@email.com', '645678901'),
	(8, 'Sergio', 'Díaz', '10987654H', 'sergio.diaz@email.com', '610987654'),
	(9, 'Carmen', 'Jiménez', '56789012I', 'carmen.jimenez@email.com', '656789012'),
	(10, 'Manuel', 'Vargas', '21098765J', 'manuel.vargas@email.com', '621098765'),
	(11, 'Isabel', 'Moreno', '67890123K', 'isabel.moreno@email.com', '667890123'),
	(12, 'Raúl', 'Serrano', '32109876L', 'raul.serrano@email.com', '632109876'),
	(13, 'Paula', 'Blanco', '78901234M', 'paula.blanco@email.com', '678901234'),
	(14, 'Adrián', 'Castillo', '43210987N', 'adrian.castillo@email.com', '643210987'),
	(15, 'Silvia', 'Romero', '89012345O', 'silvia.romero@email.com', '689012345');

-- Volcando estructura para tabla academia.curso
CREATE TABLE IF NOT EXISTS `curso` (
  `ID_Curso` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Curso` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Fin` date DEFAULT NULL,
  `Max_Plazas` int(11) NOT NULL,
  PRIMARY KEY (`ID_Curso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla academia.curso: ~4 rows (aproximadamente)
INSERT INTO `curso` (`ID_Curso`, `Nombre_Curso`, `Descripcion`, `Fecha_Inicio`, `Fecha_Fin`, `Max_Plazas`) VALUES
	(1, 'Programación en Python', 'Curso básico de Python para principiantes', '2023-10-16', '2023-11-30', 20),
	(2, 'Desarrollo Web Full-Stack', 'Curso intensivo de desarrollo web con React y Node.js', '2023-11-01', '2023-12-15', 15),
	(3, 'Marketing Digital Avanzado', 'Estrategias avanzadas de marketing online', '2023-10-23', '2023-11-23', 10),
	(4, 'Análisis de Datos con R', 'Introducción al análisis de datos utilizando el lenguaje R', '2023-11-06', '2023-12-20', 12);

-- Volcando estructura para tabla academia.matricula
CREATE TABLE IF NOT EXISTS `matricula` (
  `ID_Matricula` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Alumno` int(11) DEFAULT NULL,
  `ID_Curso` int(11) DEFAULT NULL,
  `Fecha_Matricula` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`ID_Matricula`),
  KEY `ID_Alumno` (`ID_Alumno`),
  KEY `ID_Curso` (`ID_Curso`),
  CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`ID_Alumno`) REFERENCES `alumno` (`ID_Alumno`),
  CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Procedimientos almacenados
/*
1 - Verificación de Existencia:
Se verifica si el alumno y el curso existen en sus respectivas tablas.
2 -Verificación de Plazas:
Se cuenta el número de matrículas existentes para el curso y se compara con el máximo de plazas permitidas.
3 -Verificación de Matrícula Duplicada:
Se verifica si el alumno ya se encuentra matriculado en el curso.
4 - Realización de la Matrícula:
Se inserta un nuevo registro en la tabla Matricula, registrando la matrícula del alumno en el curso. Se registra la fecha de la matricula.*/

DELIMITER //

CREATE PROCEDURE MatricularAlumno(
    IN p_IDAlumno INT,
    IN p_IDCurso INT,
    OUT p_Mensaje VARCHAR(255)
)
BEGIN
    -- Declaración de variables
    DECLARE v_PlazasOcupadas INT;
    DECLARE v_MaxPlazas INT;

    -- Verificar si el alumno existe
    IF NOT EXISTS (SELECT 1 FROM Alumno WHERE ID_Alumno = p_IDAlumno) THEN
        SET p_Mensaje = 'El alumno no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Curso WHERE ID_Curso = p_IDCurso) THEN
        SET p_Mensaje = 'El curso no existe.';

    -- Verificar si hay plazas disponibles
    ELSE
        SELECT COUNT(*) INTO v_PlazasOcupadas FROM Matricula WHERE ID_Curso = p_IDCurso;
        SELECT Max_Plazas INTO v_MaxPlazas FROM Curso WHERE ID_Curso = p_IDCurso;

        IF v_PlazasOcupadas >= v_MaxPlazas THEN
            SET p_Mensaje = 'No hay plazas disponibles en el curso.';
        ELSEIF EXISTS (SELECT 1 FROM Matricula WHERE ID_Alumno = p_IDAlumno AND ID_Curso = p_IDCurso) THEN
            SET p_Mensaje = 'El alumno ya está matriculado en este curso.';
        ELSE
            -- Realizar la matrícula
            INSERT INTO Matricula (ID_Alumno, ID_Curso) VALUES (p_IDAlumno, p_IDCurso);
            SET p_Mensaje = 'Matrícula realizada con éxito.';
        END IF;
    END IF;
END //

DELIMITER ;

-- Insertar un nevo registro en la tabla matriculas
SET @mensaje = '';
CALL MatricularAlumno(1, 3, @mensaje);
SELECT @mensaje;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;