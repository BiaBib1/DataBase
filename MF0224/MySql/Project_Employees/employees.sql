/*  Query */

use employees;
select * from employees;
select first_name from employees;
select * from employees
where gender = 'F';

/* la funzione count(*) serve per conteggiare
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
