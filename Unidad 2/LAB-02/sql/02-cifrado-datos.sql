--Nombre: Antonio Gastelum Landeros
--Grupo: 4-1
--Fecha: 25/10/2026
--Trabajo: Actividad 2 — Cifrado de información sensible

--Actividad 2 — Cifrado de información sensible

-- Crear una tabla de demostración
CREATE TABLE clientes_protegidos (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    rfc_cifrado BYTEA NOT NULL
);

--Inserta un registro utilizando cifrado simétrico:
INSERT INTO clientes_protegidos (
    nombre,
    rfc_cifrado
)
VALUES (
    'Ana López',
    pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
);

--Consulta:
SELECT * FROM clientes_protegidos;

--Recuperar el dato
--Utiliza:
SELECT
    id,
    nombre,
    pgp_sym_decrypt(
        rfc_cifrado,
        'CLAVE-DE-PRUEBA'
    ) AS rfc
FROM clientes_protegidos;