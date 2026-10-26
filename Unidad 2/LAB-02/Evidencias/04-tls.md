### UNIVERSIDAD AUTÓNOMA DE SINALOA
### FACULTAD DE INFORMÁTICA CULIACÁN
### ASIGNATURA:
Gestión de Seguridad y Desempeño de Bases de Datos
### TRABAJO:
Actividad 4 — Protección de datos durante la comunicación, Actividad 5 — Verificar el estado de TLS en PostgreSQL y Actividad 6 — Conexión mediante psql
### MAESTRO:
Alexis Moises Montaño Araujo 
### ALUMNO:
Gastelum Landeros Antonio
### GRUPO:
4-1

## Objetivo
Comprender la importancia de proteger la comunicación entre el cliente y el servidor PostgreSQL mediante TLS, verificar la configuración SSL del servidor y comprobar si la conexión actual utiliza cifrado. Además, identificar la versión mínima del protocolo, el puerto de conexión y las características de seguridad de la sesión actual para reconocer los riesgos de transmitir información sin protección.

## Comandos ejecutados
```sql
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
```
## Resultados obtenidos
Al ejecutar los comandos de verificación en PostgreSQL, se obtuvo que SSL está deshabilitado, ya que SHOW ssl; devolvió off. La versión mínima del protocolo configurada es TLSv1.2, el puerto de PostgreSQL es 5432 y la configuración `listen_addresses devolvió *, lo que indica que el servidor escucha en todas las interfaces de red configuradas.

La consulta de la conexión actual mostró la dirección del cliente ::1 y el puerto de origen 52574. Finalmente, al consultar pg_stat_ssl, se obtuvieron los valores ssl = false, version = NULL y cipher = NULL. Estos resultados confirman que la conexión actual no utiliza TLS y que no se está aplicando cifrado durante la comunicación.

## Preguntas
### ¿La conexión actual utiliza TLS?
No. El comando SHOW ssl; devolvió off, y la consulta a pg_stat_ssl mostró ssl = false. Esto confirma que mi conexión actual con PostgreSQL no utiliza TLS.
### ¿Qué versión de TLS se está utilizando?
No se está utilizando ninguna versión de TLS en la conexión actual, porque el resultado de pg_stat_ssl mostró version = NULL. Aunque SHOW ssl_min_protocol_version; devolvió TLSv1.2, ese valor indica la versión mínima permitida si SSL estuviera habilitado, no la versión utilizada en la sesión actual.
### ¿Qué algoritmo de cifrado aparece?
No aparece ningún algoritmo de cifrado TLS, porque la columna cipher devolvió NULL. Esto ocurre porque la conexión actual no utiliza TLS.
### ¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?
Una conexión protegida con TLS cifra la información que se transmite entre el cliente y el servidor, lo que dificulta que una persona no autorizada pueda leerla si intercepta el tráfico de red. En cambio, una conexión sin TLS no proporciona esa protección criptográfica durante la transmisión y la información podría quedar expuesta.

## Conclusion
En esta actividad aprendí la importancia de TLS para proteger la información durante la comunicación entre un cliente y PostgreSQL. Mediante los comandos ejecutados comprobé que SSL está deshabilitado en mi servidor local y que la conexión actual no utiliza cifrado TLS. También comprendí que configurar una versión mínima del protocolo no significa que TLS esté activo. Para proteger la información transmitida, sería necesario habilitar y configurar correctamente SSL/TLS en el servidor PostgreSQL.