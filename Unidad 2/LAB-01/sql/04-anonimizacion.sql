--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 18/10/2026
--Trabajo: Actividad 5 — Anonimización (anonymization) y Actividad 6 — Análisis del riesgo de reidentificación

--Actividad 5 — Anonimización (anonymization)
/*El área de dirección solicita información estadística.
No necesita conocer los clientes individualmente.
El objetivo es generar información agregada y reducir el riesgo de reidentificación. */

--12.1 Generalizar la edad
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY 1;

--12.2 Generalizar la región
SELECT
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1;

--12.3 Combinar atributos
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1, 2;

--12.4 Suprimir grupos pequeños
--Como ejercicio didáctico se utilizará un umbral de cinco registros:
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1, 2
HAVING COUNT(*) >= 5;

SELECT * FROM clientes;


SELECT CURRENT_USER, SESSION_USER;

--Consulta modificada
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 44 THEN '18-44'
        WHEN edad BETWEEN 45 AND 64 THEN '45-64'
        ELSE '65+'
    END AS rango_edad,
    LEFT(codigo_postal, 1) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1, 2
HAVING COUNT(*) >= 5;
