--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 25/10/2026
--Trabajo:  Preparación y Actividad 1 — Protección de credenciales

-- Preparación

--Si la tabla clientes ya existe, verifica su estructura:
SELECT * FROM clientes;

--Si necesitas crear nuevamente la tabla para esta práctica:
CREATE TABLE clientes (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    rfc VARCHAR(13),
    edad INTEGER,
    ciudad VARCHAR(80),
    codigo_postal VARCHAR(10),
    fecha_alta DATE DEFAULT CURRENT_DATE
);

--Verifica que la extensión pgcrypto esté disponible:
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--Comprueba:
SELECT extname FROM pg_extension
WHERE extname = 'pgcrypto';

--Actividad 1 — Protección de credenciales

--Supongamos que una aplicación necesita almacenar información de usuarios.
--Una implementación incorrecta sería:
CREATE TABLE usuarios_insegura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);

--Insertamos un usuario de prueba:
INSERT INTO usuarios_insegura (usuario, password)
VALUES ('juan', 'Password123');

--Consulta:
SELECT * FROM usuarios_insegura;

--Generar una representación no reversible
--Para fines didácticos utilizaremos pgcrypto.
SELECT crypt(
    'Password123',
    gen_salt('bf')
);

--Observa el resultado.
--Ejecuta nuevamente:
SELECT crypt(
    'Password123',
    gen_salt('bf')
);

--Crear una tabla para credenciales protegidas
--Crea:
CREATE TABLE usuarios_segura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);

--Inserta un usuario:
INSERT INTO usuarios_segura (usuario, password_hash)
VALUES (
    'juan',
    crypt('Password123', gen_salt('bf'))
);

--Consulta:
SELECT * FROM usuarios_segura;

--Verificar una contraseña
--Para verificar una contraseña:
SELECT
    usuario,
    password_hash = crypt('Password123', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

--Prueba ahora con una contraseña incorrecta:
SELECT
    usuario,
    password_hash = crypt('OtraPassword', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';