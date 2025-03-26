/*Seleccionar todos los empleados:*/
SELECT *
FROM employees;


/*Obtener el nombre y apellido de todos los empleados:*/
SELECT employees.first_name, employees.last_name
FROM employees

/*Contar el número total de empleados:*/
SELECT COUNT(*) AS "Numero de Empleados"
FROM employees

/*Obtener los empleados cuyo primer nombre es 'John':*/
SELECT first_name
FROM employees
WHERE first_name = 'John'

/*Listar los apellidos únicos de los empleados:*/
SELECT DISTINCT(last_name)
FROM employees;

/*Obtener los empleados que fueron contratados después del año 2000:*/
SELECT *
FROM employees
WHERE hire_date >= '2000-01-01'
ORDER BY hire_date asc;

/*Contar el número de empleados contratados en cada año:*/
SELECT COUNT(*) AS "Contratados este año"
FROM employees
WHERE hire_date like '2000%';

SELECT YEAR(hire_date) AS "año_contratacion", COUNT(*) AS "numero_empleados"
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_date;

/*Encontrar el empleado con el número de empleado más alto:*/
SELECT emp_no
from employees
ORDER BY emp_no DESC
LIMIT 1;

SELECT MAX(emp_no), first_name AS "Maximo numero de empleado"
FROM employees


/*Obtener los nombres y apellidos de los empleados cuyo apellido comienza con 'S':*/
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE "S%"
ORDER BY last_name and first_name ASC;

/*Contar la cantidad de empleados con cada género:*/
SELECT COUNT(*)
FROM employees
WHERE gender = "F";

SELECT COUNT(*)
FROM employees
WHERE gender = "M";

SELECT gender, COUNT(*) AS "Numero de empleados"
FROM employees
GROUP BY gender;


/*Obtener los primeros 10 empleados ordenados por fecha de contratación ascendente:*/
SELECT emp_no
FROM employees
ORDER BY emp_no ASC
LIMIT 10

/*Listar los empleados nacidos antes del 1 de enero de 1960:*/
SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE birth_date <= '1960-01-01'
ORDER BY birth_date asc

/*Calcular la edad promedio de los empleados:*/



/*Encontrar los empleados cuya fecha de contratación es en el mismo año que su fecha de nacimiento (ignorando el año de nacimiento):*/
SELECT *
FROM employees
WHERE SUBSTR(birth_date, 5, 10) = SUBSTR(hire_date, 5, 10)
ORDER BY birth_date;

/*Obtener el número de empleados nacidos en cada mes:*/
SELECT MONTH(birth_date) AS "Mes de nacimiento", COUNT(*) AS "numero empleados"
FROM employees
GROUP BY month(birth_date)
ORDER BY birth_date ASC ;


/*QUERY CON JOIN*/

/*Obtener los salarios de los empleado*/
SELECT CONCAT(e.last_name, ' ', e.first_name), s.*
FROM employees e, salaries s 
WHERE e.emp_no = s.emp_no
ORDER BY e.last_name DESC, e.first_name ASC;

SELECT CONCAT(e.last_name, ',' , e.first_name), s.*
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY e.last_name DESC, e.first_name ASC;

/*Obtener la lista de empleados con los salarios acumulados ordenado de mayor a menor.*/
SELECT CONCAT (e.last_name, ' ' , e.first_name), s.*
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY s.salary DESC, s.from_date DESC;

/*Obtener todos los salarios del  empleado 499999*/
SELECT CONCAT (e.last_name, e.first_name), s.*
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.emp_no = 499999
ORDER BY s.from_date ASC;

/*LIstar los empleados de un departamento */
SELECT CONCAT (e.last_name, e.first_name), d.*, de.emp_no
FROM employees e, departments d
JOIN dept_emp de ON de.emp_no = e.emp_no,
WHERE d.dept_no = de.dept_no

/*Listar los empleados de un departamento ordenados por fecha salida to_date*/
SELECT e.first_name, e.last_name, d.dept_name, de.* 
FROM dept_emp de
JOIN departments d ON  de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
ORDER BY de.to_date

/*Listar los empleados de un departamento actuales*/
SELECT e.emp_no, CONCAT(e.first_name, ', ', e.last_name) AS Dipendente, d.dept_name
FROM employees e
JOIN current_dept_emp cde ON e.emp_no = cde.emp_no 
JOIN departments d ON cde.dept_no = d.dept_no
ORDER BY e.emp_no asc


/*Obtener todos las titulación*/
SELECT e.first_name, e.last_name, t.*
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
ORDER BY t.title

/*Ejercicio 1*/
/*Mostrar el número de Hombre (M)  y  y de mujeres */
SELECT COUNT(*) AS "Genere"
FROM employees e
GROUP by gender = 'M', gender = 'F'

/*Ejercicio 2*/
/*Mostrar el salario medio por tipo de  empleado (title), redondeado a 2 decimales ordenado de mayor a menor*/
SELECT CONCAT(e.first_name, ', ' , e.last_name) AS "Empleado", round(AVG(s.salary),2) AS promedio, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY t.title
ORDER BY promedio DESC 

/*Ejercicio 3*/
/*Buscar todos los empleados que hayan trabajado en al menos 2 departamentos. Mostrar su nombre, apellido y el número de departamentos en los que han trabajado Mostrar todos los resultados en orden ascendente.
t.to_date ,*/

/*Ejercicio 4*/
.
/*Mostrar el nombre y apellidos del empleado mejor pagado.*/

/*Ejercicio 5*/

/*Obtener el nombre y apellido del segundo mejor empleado pagado.*/


/*http://www.forosdelweb.com/f100/limit-oracle-10-a-449714/ */

/*LIMIT 1;*/

/*Ejercicio 6*/
/*Mostrar el mes y total contrataciones del mes con mayor número de contrataciones */

/*Ejercicio 7*/
/*Mostrar el departamento y la edad de contratación más baja*/

/*Ejercicio 8*/
/*Mostrar el nombre y apellido y departamento de aquellos cuyo nombre no contenga vocales.*/

/*Ejercicio 9*/
/*Contar el número de empleado de cada titulación */
SELECT t.title, COUNT(t.emp_no) AS Numero_De_Empleados
FROM titles t
JOIN dept_emp de ON t.emp_no = de.emp_no
GROUP BY t.title
ORDER BY Numero_De_Empleados DESC

/*Ejercicio 9.1*/
/*Contar el número de empleado de cada titulación y departamento*/
SELECT t.title, COUNT(t.emp_no) AS Numero_de_empleados, d.dept_name
FROM titles t
JOIN dept_emp de ON t.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY Numero_de_empleados DESC


/*Ejercicio 9.2*/
/*Mostrar la lista de empleados activos ordenados por titulación y departamento departamento*/
SELECT cde.emp_no, CONCAT(e.first_name, ', ', e.last_name) AS Nombre_Apellido, t.title, d.dept_name
FROM employees e
JOIN current_dept_emp cde ON  e.emp_no = cde.emp_no
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_emp de ON t.emp_no = de.emp_no
JOIN departments d ON  d.dept_no = de.dept_no
ORDER BY t.title AND d.dept_name

SELECT cde.emp_no, CONCAT(e.first_name, ', ', e.last_name) AS Nombre_Apellido, cde.to_date, t.title, d.dept_name
FROM employees e
JOIN current_dept_emp cde ON  e.emp_no = cde.emp_no
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_emp de ON t.emp_no = de.emp_no
JOIN departments d ON  d.dept_no = de.dept_no
WHERE cde.to_date = '9999-01-01'
ORDER BY d.dept_no ASC 
/*Alberto solucion*/
SELECT de.*, d.dept_name
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY de.dept_no asc
