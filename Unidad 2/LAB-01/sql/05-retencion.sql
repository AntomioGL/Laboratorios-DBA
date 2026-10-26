--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 25/10/2026
--Trabajo: Actividad 7 — Retención de datos y Verificacion final 

--14. Actividad 7 — Retención de datos

SELECT * FROM clientes
WHERE fecha_alta <  CURRENT_DATE - INTERVAL '5 years';

SELECT * FROM clientes;

SELECT CURRENT_USER, SESSION_USER;

--Verificacion Final

--Área de soporte
SET ROLE soporte;
--Debe poder consultar:
SELECT * FROM v_clientes_soporte;
--pero no acceder directamente a:
SELECT * FROM clientes;

--Área de analítica
SET ROLE analista;
--Debe poder consultar:
SELECT * FROM analitica.clientes;
--pero no:
SELECT * FROM pii.mapa_cliente;
--ni:
SELECT * FROM public.clientes;

RESET ROLE;

--Información para dirección
--Debe contener información agregada y no identificadores directos.
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total_clientes
FROM public.clientes
GROUP BY 1
ORDER BY 1;

--Retención
--Debe existir una consulta que permita identificar los registros que exceden el periodo establecido.
SELECT * FROM public.clientes
WHERE fecha_alta < CURRENT_DATE - INTERVAL '5 years';