
### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 1 — Protección de credenciales
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1
# Actividad 1 — Protección de credenciales
###  Objetivo
Identificar los riesgos de almacenar contraseñas en texto claro y comprender cómo proteger las credenciales mediante funciones de hash en PostgreSQL utilizando la extensión pgcrypto.

## Comandos ejecutadoa
```sql
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
```
## Resultados obtenidos
Se creó la tabla usuarios_insegura y se insertó el usuario juan con su contraseña almacenada en texto claro. Al ejecutar la consulta, se observa que la contraseña aparece directamente en la tabla, lo que representa un riesgo de seguridad si una persona no autorizada obtiene acceso de lectura.

## Pregunta
### ¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?
La persona podría ver directamente las contraseñas almacenadas y utilizarlas para acceder a las cuentas de los usuarios.

## Comandos ejecutados
```sql
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

```
## Resultados obtenidos
Al ejecutar la función crypt() junto con gen_salt('bf'), PostgreSQL genera una cadena hash para la contraseña. Al ejecutar la consulta nuevamente, se obtiene una cadena diferente debido a que cada ejecución genera un salt nuevo, aunque se utilice la misma contraseña.

## Preguntas
### ¿Son iguales? 
no
### Si no son iguales, ¿por qué? 
Porque cada ejecución genera un salt diferente, que se incorpora al resultado del hash.
### ¿Qué función cumple gen_salt()?
Genera el salt y los parámetros necesarios para el algoritmo seleccionado.
### ¿Qué función cumple crypt()?
Genera un hash de la contraseña usando el salt y el algoritmo indicado.
### ¿Esto es cifrado reversible?
No, es un mecanismo de hash para verificar contraseñas, no para recuperar la contraseña original.

## Comandos ejecutados
```sql
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
```

## Resultados obtenidos
Se creó la tabla usuarios_segura y se insertó el usuario juan con su contraseña almacenada como hash. Al verificar la contraseña correcta, el resultado es true, mientras que con una contraseña incorrecta el resultado es false. Esto demuestra que es posible verificar una contraseña sin almacenar ni recuperar su valor original.

## Preguntas
### ¿Qué resultado obtuviste con la contraseña correcta?
true porque la contraseña coincide con el hash almacenado.
### ¿Qué resultado obtuviste con la contraseña incorrecta?
false porque no coincide con el hash almacenado.
### ¿Por qué no es necesario recuperar la contraseña original?
Porque se puede comprobar si la contraseña introducida es correcta comparando su hash con el almacenado.
### ¿Por qué un hash no debe confundirse con cifrado?
Porque el cifrado permite recuperar el dato original utilizando una clave, mientras que el hash de contraseña está diseñado para verificarla sin recuperarla.

## Conclusión
En esta actividad aprendí que almacenar contraseñas en texto claro representa un riesgo para la seguridad de los usuarios. Mediante las funciones crypt() y gen_salt() de PostgreSQL es posible almacenar hashes de contraseñas y verificar si una contraseña introducida es correcta sin guardar la contraseña original. Por lo tanto, las credenciales deben protegerse utilizando mecanismos especializados de hash para contraseñas.