--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 18/10/2026
--Trabajo:  Actividad 3 — Seudonimización (pseudonymization) y  Actividad 4 — Separación de funciones

--Actividad 3 — Seudonimización (pseudonymization)
/*El área de analítica necesita estudiar información de clientes sin acceder directamente a su identidad.
Para ello se utilizará un identificador sustituto denominado token.*/

--9.1 Crear los esquemas
CREATE SCHEMA pii;
CREATE SCHEMA analitica;

--9.2 Crear la tabla de correspondencia
CREATE TABLE pii.mapa_cliente (
    token UUID PRIMARY KEY,
    cliente_id BIGINT UNIQUE
        REFERENCES public.clientes(id)
);

SELECT * FROM pii.mapa_cliente;

--9.3 Generar los tokens
--Habilitar la extensión necesaria:
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--Generar un token para cada cliente:
INSERT INTO pii.mapa_cliente
(token, cliente_id)
SELECT
    gen_random_uuid(),
    id
FROM clientes;

--Verificar:
SELECT * FROM pii.mapa_cliente;

--10. Crear el conjunto de datos para analítica
--Crear una tabla que no contenga directamente los identificadores principales del cliente:
CREATE TABLE analitica.clientes AS
SELECT
    m.token AS cliente_token,
    c.edad,
    c.ciudad,
    c.codigo_postal,
    c.fecha_alta
FROM pii.mapa_cliente m
JOIN clientes c
    ON c.id = m.cliente_id;

--Verificar:
SELECT * FROM analitica.clientes;


----------------------------------------------------------------------------------------------------------------------------------------
--Actividad 4 — Separación de funciones
/*La seudonimización pierde gran parte de su utilidad si el mismo usuario puede consultar 
tanto los datos seudonimizados como el mapa que permite recuperar la identidad.*/

--Crear el rol:
CREATE ROLE analista NOLOGIN;

--Conceder acceso al conjunto de datos analítico:
GRANT USAGE ON SCHEMA analitica
TO analista;

GRANT SELECT ON analitica.clientes
TO analista;

--11.1 Verificar los permisos
--El acceso al conjunto analítico debe estar permitido:
SELECT * FROM analitica.clientes;
SET ROLE analista;

--El acceso al mapa de correspondencia debe estar restringido:
SELECT * FROM pii.mapa_cliente;

--También debe estar restringido el acceso directo a los datos originales:
SELECT *FROM public.clientes;
