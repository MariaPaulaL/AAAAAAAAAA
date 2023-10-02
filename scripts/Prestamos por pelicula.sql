use sakila
SELECT
    f.title AS Pelicula,
    s.store_id AS id_tienda,
    s.store_name AS Tienda,
    SUM(CASE WHEN MONTH(r1.rental_date) = 5 THEN 1 ELSE 0 END) AS Mayo,
    SUM(CASE WHEN MONTH(r2.rental_date) = 6 THEN 1 ELSE 0 END) AS Junio,
    SUM(CASE WHEN MONTH(r2.rental_date) = 6 THEN 1 ELSE 0 END) - SUM(CASE WHEN MONTH(r1.rental_date) = 5 THEN 1 ELSE 0 END) AS Diferencia,
    IFNULL(((SUM(CASE WHEN MONTH(r2.rental_date) = 6 THEN 1 ELSE 0 END) - SUM(CASE WHEN MONTH(r1.rental_date) = 5 THEN 1 ELSE 0 END)) / NULLIF(SUM(CASE WHEN MONTH(r1.rental_date) = 5 THEN 1 ELSE 0 END), 0)) * 100, 0) AS Porcentaje_Crecimiento
FROM
    rental r1
INNER JOIN
    inventory i ON r1.inventory_id = i.inventory_id
INNER JOIN
    film f ON i.film_id = f.film_id
INNER JOIN
    store s ON i.store_id = s.store_id
LEFT JOIN
    rental r2 ON i.inventory_id = r2.inventory_id
WHERE
    MONTH(r1.rental_date) = 5
    OR MONTH(r2.rental_date) = 6
GROUP BY
    f.film_id, s.store_id
ORDER BY
    f.title, s.store_id
limit 5;