/*# Ejercicio Guía: Integridad Referencial en MariaDB

## Objetivo
Este ejercicio demostrará la importancia de la integridad referencial mediante:
1. Creación de tablas sin restricciones de clave foránea
2. Mostrar cómo se pueden generar inconsistencias
3. Solucionar el problema implementando integridad referencial con FOREIGN KEY

## Paso 1: Crear base de datos y tablas sin integridad referencial*/

--sql
-- Crear la base de datos
CREATE DATABASE tienda_ejemplo;
USE tienda_ejemplo;

-- Crear tabla clientes sin restricciones
CREATE TABLE clientes (
    cliente_id INT,
    nombre VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (cliente_id)
);

-- Crear tabla pedidos sin integridad referencial
CREATE TABLE pedidos (
    pedido_id INT,
    cliente_id INT,
    fecha_pedido DATE,
    total DECIMAL(10,2),
    PRIMARY KEY (pedido_id)
);


-- Paso 2: Insertar datos y mostrar inconsistencias

--sql
-- Insertar clientes
INSERT INTO clientes VALUES (1, 'Juan Pérez', 'juan@example.com');
INSERT INTO clientes VALUES (2, 'María García', 'maria@example.com');

-- Insertar pedidos (algunos válidos y otros no)
INSERT INTO pedidos VALUES (101, 1, '2023-01-15', 150.50);  -- Válido (cliente 1 existe)
INSERT INTO pedidos VALUES (102, 3, '2023-01-16', 200.75);  -- Inválido (cliente 3 no existe)

-- Mostrar los datos (se ve la inconsistencia)
SELECT * FROM clientes;
SELECT * FROM pedidos;


-- Paso 3: Identificar el problema

/*En este punto, tenemos un pedido (ID 102) que está asociado a un cliente que no existe (ID 3). 
Esto es una inconsistencia de datos que puede causar problemas en reportes y consultas.*/

-- Paso 4: Solucionar el problema con integridad referencial

-- sql
-- Primero eliminamos los datos inconsistentes
DELETE FROM pedidos WHERE cliente_id NOT IN (SELECT cliente_id FROM clientes);

-- Ahora modificamos la tabla pedidos para añadir la FOREIGN KEY
ALTER TABLE pedidos 
ADD CONSTRAINT fk_cliente
FOREIGN KEY (cliente_id) 
REFERENCES clientes(cliente_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;


-- Paso 5: Verificar que funciona la integridad referencial

-- sql
-- Intentar insertar un pedido con cliente inexistente (debe fallar)
INSERT INTO pedidos VALUES (103, 5, '2023-01-17', 300.00);

-- Insertar un pedido válido
INSERT INTO pedidos VALUES (103, 1, '2023-01-17', 300.00);  -- Éxito (cliente 1 existe)

-- Intentar eliminar un cliente con pedidos (debe fallar)
DELETE FROM clientes WHERE cliente_id = 1;

-- Actualizar un cliente (debe propagarse a los pedidos)
UPDATE clientes SET cliente_id = 10 WHERE cliente_id = 1;

-- Verificar que el cambio se propagó
SELECT * FROM pedidos;  -- El pedido del cliente 1 ahora muestra cliente_id = 10


/* Explicación de la solución

1. **Problema inicial**: Sin FOREIGN KEY, podíamos tener pedidos de clientes que no existían.
2. **Solución**: Añadimos una restricción FOREIGN KEY que:
   - Impide insertar pedidos para clientes inexistentes (`REFERENCES`)
   - Evita eliminar clientes con pedidos (`ON DELETE RESTRICT`)
   - Propaga cambios de ID de cliente a los pedidos (`ON UPDATE CASCADE`)

## Conclusión

La integridad referencial asegura que las relaciones entre tablas sean válidas. En este ejemplo:
- Previene "registros huérfanos" (pedidos sin cliente)
- Mantiene la consistencia cuando se actualizan o eliminan datos
- Garantiza que las consultas y reportes sean confiables

Este ejercicio muestra por qué es esencial diseñar bases de datos con integridad referencial desde el principio. */

