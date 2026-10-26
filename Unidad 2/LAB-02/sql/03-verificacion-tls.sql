--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 25/10/2026
--Trabajo: Actividad 4 — Protección de datos durante la comunicación, Actividad 5 — Verificar el estado de TLS en PostgreSQL y Actividad 6 — Conexión mediante psql

SELECT *
FROM clientes;

--Consulta:
SHOW ssl;

--También:
SHOW ssl_min_protocol_version;

--Consulta el puerto:
SHOW port;

--Y:
SHOW listen_addresses;

--Verificar la conexión actual
--Ejecuta:
SELECT
    inet_client_addr(),
    inet_client_port();

--Ahora verifica si la sesión actual utiliza TLS:
SELECT
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();