/*Nivel 1 - Básico*/
/*Listar todos los actores. Muestra los nombres y apellidos de todos los actores en la base de datos.*/
SELECT a.first_name, a.last_name
FROM actor a

/*Listar todas las películas. Obtén el título y el año de lanzamiento de todas las películas.*/
SELECT f.title, f.release_year
FROM film f

/*Buscar actores por nombre. Encuentra todos los actores cuyo nombre sea "JOHNNY".*/
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name = 'Johnny'

/*Contar el número de películas. Devuelve cuántas películas hay en la base de datos.*/
SELECT COUNT(*)
FROM film f

/*Listar clientes. Muestra los nombres y correos electrónicos de todos los clientes.*/
SELECT c.first_name, c.last_name, c.email
FROM customer c

/*Películas en una categoría. Obtén todas las películas que pertenecen a la categoría "Comedy".*/
SELECT fl.title, fl.category
FROM film_list fl
WHERE category = 'Comedy'

SELECT fl.category, COUNT(*)
FROM film_list fl
WHERE category = 'Comedy'

/*Nivel 2 - Intermedio*/
/*Películas rentadas por un cliente. Encuentra todas las películas rentadas por un cliente específico (por nombre y apellido).*/
SELECT r.rental_id, c.customer_id, c.first_name, c.last_name, f.film_id, f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY c.customer_id asc

SELECT r.rental_id, c.customer_id, c.first_name, c.last_name, f.film_id, f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.customer_id = 1;

/*Duración promedio de las películas. Calcula la duración media de todas las películas en minutos.*/
SELECT COUNT(*), AVG(f.`length`) AS Duracion
FROM film f

/*Clientes activos. Lista todos los clientes que han rentado al menos una película.*/
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS Totals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY Totals DESC 

/*Películas más largas. Encuentra las 5 películas con mayor duración.*/
SELECT f.title, MAX(f.`length`) AS Duracion
FROM film f
GROUP BY f.title
ORDER BY Duracion DESC 
LIMIT 5

/*Número de películas por categoría. Devuelve el número total de películas en cada categoría.*/
SELECT c.`name`, SUM(fc.film_id) AS total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.`name`
ORDER BY total ASC 

/*Ingresos totales. Calcula la suma total de todas las rentas realizadas.*/
SELECT SUM(r.rental_id) AS Total_Rent
FROM rental r

/*Clientes sin alquileres. Encuentra los clientes que nunca han rentado una película.*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.customer_id = NULL

/*Número de alquileres por cliente. Muestra cuántas películas ha alquilado cada cliente.*/
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS Rents
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY Rents DESC 

/*Nivel 3 - Avanzado*/
/*Actor más popular. Encuentra el actor que aparece en más películas.*/
SELECT a.first_name, a.last_name, COUNT(f.film_id) AS Som
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
GROUP BY fa.actor_id
ORDER BY Som DESC 
LIMIT 1

/*Película más rentada. Obtén el título de la película que ha sido rentada más veces.*/
/*Ingresos por tienda. Calcula cuánto dinero ha generado cada tienda.*/
/*Promedio de días de alquiler. Calcula la media de días que los clientes tardan en devolver las películas.*/
/*Clientes VIP. Encuentra los 5 clientes que más dinero han gastado en alquileres.*/
/*Categoría más popular. Determina qué categoría de películas ha sido rentada más veces.*/
/*Día con más alquileres. Encuentra la fecha en la que se realizaron más rentas.*/
/*Clientes morosos. Lista a los clientes que han rentado películas pero no las han devuelto.*/
/*Películas que nunca fueron rentadas. Encuentra todas las películas que nunca han sido alquiladas.*/
/*Ingresos por mes. Obtén los ingresos totales por mes para analizar tendencias de ventas.*/
/*Empleado con más rentas. Encuentra qué empleado ha procesado más alquileres.*/

