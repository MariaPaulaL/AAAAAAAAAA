use sakila;

SELECT
    s.store_id AS Tienda,
    CONCAT(st.first_name, ' ', st.last_name) AS Vendedor,
    SUM(CASE WHEN MONTH(r.rental_date) = 5 THEN 1 ELSE 0 END) AS Prestamos_Mayo,
    SUM(CASE WHEN MONTH(r.rental_date) = 6 THEN 1 ELSE 0 END) AS Prestamos_Junio,
    SUM(CASE WHEN MONTH(r.rental_date) = 6 THEN 1 ELSE 0 END) - SUM(CASE WHEN MONTH(r.rental_date) = 5 THEN 1 ELSE 0 END) AS Diferencia,
    IFNULL(((SUM(CASE WHEN MONTH(r.rental_date) = 6 THEN 1 ELSE 0 END) - SUM(CASE WHEN MONTH(r.rental_date) = 5 THEN 1 ELSE 0 END)) / NULLIF(SUM(CASE WHEN MONTH(r.rental_date) = 5 THEN 1 ELSE 0 END), 0)) * 100, 0) AS Porcentaje_Crecimiento
FROM
    rental r
INNER JOIN
    staff st ON r.staff_id = st.staff_id
INNER JOIN
    store s ON st.store_id = s.store_id
WHERE
    MONTH(r.rental_date) IN (5, 6)
GROUP BY
    s.store_id, Vendedor
ORDER BY
    s.store_id, Vendedor
LIMIT 5;