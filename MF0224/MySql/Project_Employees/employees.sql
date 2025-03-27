/*  Query */

use employees;
select * from employees;
select first_name from employees;
select * from employees
where gender = 'F';

/* la funzione COUNT(*) serve per conteggiare
"Numero de Female" è il messaggio che comare sulla colonna */
select count(*) as "numero de Female"  from employees
where gender = 'F';

/* selezionando le persone che sono state contrattate in quella data specifica*/
select * from employees
where hire_date = '1986-06-26';

/* hire before 1990. Remember date year-month-day!!! */
/* order desc ordine discendente. <= include il 1990 */
/* AND adding more conditions */
select * from employees
where hire_date <= '1990-01-01' and gender = 'F'
order by hire_date DESC, birth_date asc;

/* LIKE % ricercare qualcosa che abbia il campo indicato prima del % */
SELECT COUNT(*) AS "Contratados este año"
FROM employees
WHERE hire_date like '2000%';

/* Nuova funzione YEAR e GROUP BY *YEAR */
SELECT YEAR(hire_date) AS "año_contratacion",COUNT(*) AS "numero_empleados"
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_date;

/* Funzione LIMIT per selezionare solo un det numero */
SELECT emp_no
from employees
ORDER BY emp_no DESC
LIMIT 1
/* Otra manera FUNZIONE MAX */
SELECT MAX(emp_no), first_name AS "Maximo numero de empleado"
FROM employees

/* Conta con COUNT e raggruppa per GROUP BY, Importante la , dopo select */
/*Il COUNTO RICHIEDE IL GROUP BY*/
SELECT gender, COUNT(*) AS "Numero de empleados"
FROM employees
GROUP BY gender

/* Non è necessario group by se si usa order by e bisogna esplicitare sempre la colonna da cui prendere l'order by*/
SELECT emp_no
FROM employees
ORDER BY emp_no ASC
LIMIT 10

/* FUNZIONE SUBSTR(colonna, 1numero carattere desiderato, ultimo carattere desiderato) */
SELECT *
FROM employees
WHERE SUBSTR(birth_date, 5, 10) = SUBSTR(hire_date, 5, 10)
ORDER BY birth_date;

/* FUNZIONE DISTINCT per aggruppare tutti i valori uguali e riportare quelli diversi*/
SELECT DISTINCT(last_name)
FROM employees;

/* JOIN */
/* FUNZIONE CONCAT per concatenare colonne di ricerca = concat as "nombre completo". In questo modo si connettono le due tavole in modo semplice */
/* Le due query sono identiche ma con JOIN la seconda*/
SELECT CONCAT(e.last_name, ' ', e.first_name), s.*
FROM employees e, salaries s 
WHERE e.emp_no = s.emp_no
ORDER BY e.last_name DESC, e.first_name ASC;

SELECT CONCAT(e.last_name, ',' , e.first_name), s.*
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY e.last_name DESC, e.first_name ASC;

/* Dos JOINS */
SELECT e.first_name, e.last_name, d.dept_name, de.* 
FROM dept_emp de
JOIN departments d ON  de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
ORDER BY d.dept_name

/* Funciones SUM AVG(media) COUNT CONCAT e ROUND . */
/*SUM(s.salary)/COUNT(*) = AVG(s.salary)*/
SELECT e.emp_no, CONCAT(e.last_name, ', ' , e.first_name) as "nombre completo",  SUM(s.salary), ROUND(AVG(s.salary),2), COUNT(*)
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY e.last_name DESC, e.first_name ASC

/* ROUND y qualquiera otra funcion puede ser con AS alias que puede ser rellamado en order by*/
SELECT CONCAT(e.first_name, ', ' , e.last_name) AS "Empleado", round(AVG(s.salary),2) AS promedio, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY t.title
ORDER BY promedio DESC 

/*FUNZIONE DATEDIFF differenza fra le date inserite, con CURDATE, la data qui /365*/
SELECT e.first_name, e.last_name, e.hire_date, de.from_date AS "fecha inicio",
d.dept_name, round(DATEDIFF(CURDATE(), de.from_date) / 365, 0) AS "años en empresa"
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01'
order BY de.dept_no ASC 

/*FUNZIONE UNIX_TIMESTAMP(CURDATE()) rimanda i secondi dal 01.01.1970. Las fechas hay que trasformarlas*/
select e.*, de.from_date as "fecha inicio", 
d.dept_name, DATEDIFF(CURRENT_DATE(), de.from_date )/365 as "años en empresa", 
(UNIX_TIMESTAMP(CURRENT_DATE())- UNIX_TIMESTAMP( de.from_date )) as "segundos"
from dept_emp as de
join departments as d on de.dept_no = d.dept_no
join employees as e on de.emp_no = e.emp_no
where de.to_date = '9999-01-01'
order by de.dept_no asc