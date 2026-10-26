### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 7 — Comparar protección en reposo y protección en tránsito
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1

## Completa la siguiente tabla:
| Situación | Mecanismo apropiado | ¿Qué protege? |
|---|---|---|
| Contraseña de usuario | Hash de contraseñas con un algoritmo especializado, como Argon2id o bcrypt | Evita almacenar la contraseña original y permite verificarla sin recuperarla. |
| RFC almacenado en una tabla | Cifrado de datos | Protege la confidencialidad del RFC y permite recuperarlo mediante la clave correcta. |
| Consulta enviada desde un cliente al servidor | TLS | Protege la información durante la transmisión entre el cliente y PostgreSQL. |
| Respaldo de una base de datos | Cifrado de respaldos y control de acceso | Evita que personas no autorizadas puedan leer la información respaldada. |
| Clave criptográfica | Gestor de secretos o sistema de gestión de claves (KMS) | Protege las claves, restringe el acceso y permite administrar su rotación y revocación. |

## Conclusion
Aprendí que cada tipo de información necesita un mecanismo de protección adecuado. Las contraseñas deben almacenarse mediante hashes, los datos sensibles deben cifrarse y las comunicaciones deben protegerse con TLS. Además, es importante proteger las claves criptográficas y los respaldos para evitar accesos no autorizados.