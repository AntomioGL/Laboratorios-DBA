### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 8 — Analizar un escenario de seguridad
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1

# Actividad 8 — Analizar un escenario de seguridad
## Objetivo
Identificar los principales riesgos de seguridad relacionados con el almacenamiento de información sensible, la transmisión de datos, la gestión de claves criptográficas y la protección de respaldos, así como proponer mecanismos para reducir dichos riesgos.

## Pregunta 1. ¿Cuáles son los principales riesgos?
Los principales riesgos son la exposición de contraseñas almacenadas en texto claro, el acceso no autorizado a los RFC y a la información financiera, la interceptación de datos transmitidos por conexiones que no validan correctamente la identidad del servidor, la filtración de claves criptográficas incluidas en archivos SQL y el acceso a respaldos sin protección adicional.

Estos problemas podrían provocar robo de credenciales, suplantación de identidad, divulgación de información personal y financiera, y descifrado de datos protegidos si las claves quedan expuestas. Además, una filtración puede afectar la confidencialidad de la información incluso cuando los usuarios y permisos de la base de datos están configurados correctamente.

## Pregunta 2. ¿Qué mecanismo utilizarías para cada elemento?
Nombre y correo electrónico: aplicar controles de acceso y limitar la consulta de estos datos a usuarios autorizados. Cifrar los datos cuando el nivel de riesgo o los requisitos aplicables lo justifiquen.
Contraseña: utilizar un algoritmo especializado de hash para contraseñas, como Argon2id o bcrypt, con salt y parámetros adecuados. Nunca almacenarla en texto claro.
RFC: utilizar cifrado para proteger la confidencialidad del dato y restringir el acceso a las personas autorizadas.
Información financiera: utilizar cifrado en reposo y durante la transmisión mediante TLS, además de controles de acceso y auditoría.
Claves criptográficas: almacenarlas en un gestor de secretos o sistema de gestión de claves (KMS), restringir su acceso y establecer procedimientos de rotación y revocación.
Conexiones con PostgreSQL: configurar TLS con certificados válidos y utilizar sslmode=verify-full cuando corresponda, para verificar el certificado y la identidad del servidor.
Respaldos de la base de datos: cifrarlos, restringir el acceso, almacenarlos en ubicaciones seguras y comprobar periódicamente que puedan restaurarse correctamente.
## Pregunta 3. ¿Cuál de los problemas consideras más crítico y por qué?
Considero que almacenar las contraseñas en texto claro es uno de los problemas más críticos, porque cualquier persona que consiga acceso de lectura a la tabla podría conocer inmediatamente las credenciales. Si los usuarios reutilizan esas contraseñas en otros servicios, el impacto podría extenderse más allá de la base de datos afectada.

Por esta razón, las contraseñas deben protegerse mediante algoritmos especializados de hash. También es importante corregir los demás problemas, especialmente la exposición de claves criptográficas, ya que una clave filtrada podría permitir descifrar información protegida.

## Pregunta 4. ¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos? Justifica tu respuesta.
No. Configurar correctamente los usuarios y permisos es una medida importante, pero no elimina todos los riesgos de seguridad.

Los permisos controlan quién puede acceder a los objetos de la base de datos, pero no protegen por sí solos las contraseñas almacenadas en texto claro, no cifran automáticamente los datos sensibles, no garantizan que las conexiones validen la identidad del servidor y tampoco protegen los respaldos o las claves publicadas en archivos SQL.

Por eso se necesita una estrategia de seguridad por capas que combine control de acceso, hash de contraseñas, cifrado de datos, TLS, gestión segura de claves, protección de respaldos y auditoría.

## Conclusión
En esta actividad comprendí que la seguridad de una base de datos no depende únicamente de configurar usuarios y permisos. También es necesario proteger las contraseñas, cifrar la información sensible, asegurar las conexiones, administrar correctamente las claves criptográficas y proteger los respaldos. La combinación de estas medidas ayuda a reducir los riesgos de filtración y acceso no autorizado a la información.