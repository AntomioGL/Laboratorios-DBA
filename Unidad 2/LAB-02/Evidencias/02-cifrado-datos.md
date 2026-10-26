### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 2 — Cifrado de información sensible
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1

# Actividad 2 — Cifrado de información sensible

## Objetivo
Comprender cómo proteger información sensible, como el RFC de un cliente, mediante cifrado simétrico en PostgreSQL utilizando las funciones de la extensión pgcrypto.

## Comandos ejecutados
```sql
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
```
## Resultados obtenidos
Al ejecutar el comando CREATE TABLE, se creó correctamente la tabla clientes_protegidos para almacenar el nombre del cliente y su RFC cifrado.

Al ejecutar el comando INSERT, se insertó el registro de Ana López y su RFC se cifró utilizando la función pgp_sym_encrypt(). Al consultar la tabla, el RFC original ya no aparece directamente, sino que se muestra el contenido cifrado en formato binario.

Finalmente, al ejecutar la función pgp_sym_decrypt() con la clave correcta, se recuperó el RFC original.

## Preguntas
### ¿Qué diferencia existe entre crypt() y pgp_sym_encrypt()?
La función crypt() genera hashes para proteger y verificar contraseñas, mientras que pgp_sym_encrypt() cifra información mediante una clave simétrica y permite recuperar el dato original utilizando la función pgp_sym_decrypt() y la clave correcta.

### ¿Cuál de los dos mecanismos permite recuperar el dato original?
pgp_sym_encrypt() permite recuperar el dato original mediante pgp_sym_decrypt(), siempre que se disponga de la clave correcta. En cambio, crypt() se utiliza para verificar contraseñas y no para recuperar la contraseña original.

### ¿Qué ocurre si se utiliza una clave incorrecta?
Se devuelve un error al intentar descifrar el dato con una clave incorrecta, por lo que no se obtiene el RFC original.

### ¿Qué problema de seguridad representa colocar la clave directamente en una consulta?
La clave puede quedar expuesta en archivos SQL, repositorios Git, registros de ejecución o capturas de pantalla.

## Conclusión

En esta actividad aprendí que el cifrado simétrico permite proteger información sensible, como el RFC de un cliente, y recuperar el dato original utilizando la clave correcta. También comprendí que el hash de contraseñas y el cifrado son mecanismos diferentes. Finalmente, es importante proteger las claves criptográficas y evitar almacenarlas directamente en el código o en repositorios.