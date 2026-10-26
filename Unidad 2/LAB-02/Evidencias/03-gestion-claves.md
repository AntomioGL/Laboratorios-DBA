### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 3 — El problema de la gestión de claves
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1

# Actividad 3 — El problema de la gestión de claves

## Objetivo
Identificar los riesgos de escribir claves criptográficas directamente en los comandos SQL y comprender la importancia de administrarlas de manera segura.

## Comandos Ejecutados
```sql
SELECT pgp_sym_decrypt(
    rfc_cifrado,
    'CLAVE-DE-PRUEBA'
)
FROM clientes_protegidos;
```
## Resultados obtenidos
Al ejecutar la consulta utilizando la clave correcta, PostgreSQL puede descifrar el contenido de la columna rfc_cifrado y mostrar el RFC original almacenado en la tabla.

El ejemplo demuestra que la consulta funciona, pero también permite observar que la clave está escrita directamente en el código SQL.

## Pregunta 
### ¿Qué ocurriría si esta clave fuera una clave utilizada realmente por una organización y el archivo se publicara en un repositorio Git?
Si la clave fuera real y el archivo se publicara en un repositorio Git, una persona no autorizada podría obtenerla y utilizarla para intentar descifrar los datos protegidos. Aunque el repositorio fuera privado, la clave podría quedar expuesta a colaboradores sin autorización, copias del repositorio o futuras filtraciones.

## Conclusion
En esta actividad aprendí que una consulta SQL puede funcionar correctamente y aun así representar un riesgo de seguridad si contiene una clave criptográfica. Las claves deben almacenarse y administrarse mediante mecanismos seguros, con acceso restringido. En un entorno real, también se deben evitar las exposiciones accidentales y sustituir las claves comprometidas.