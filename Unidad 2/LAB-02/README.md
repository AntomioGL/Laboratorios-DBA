# Laboratorio 02 — Cifrado de credenciales y protección de datos
## Introducción
En este laboratorio se estudiaron diferentes mecanismos para proteger la información almacenada en PostgreSQL y los datos transmitidos entre el cliente y el servidor. Se trabajó con la extensión pgcrypto para proteger contraseñas mediante hashes y cifrar información sensible, como el RFC de un cliente.

También se analizó la importancia de utilizar conexiones seguras mediante TLS, administrar correctamente las claves criptográficas y evitar la publicación accidental de información confidencial en repositorios GitLab.

El objetivo principal fue comprender que la seguridad de una base de datos requiere varias medidas de protección y no depende únicamente de los usuarios y permisos.

## Protección de credenciales
Durante la actividad se comparó el almacenamiento de contraseñas en texto claro con el uso de hashes.

El texto claro permite leer directamente la contraseña almacenada. Si una persona obtiene acceso de lectura a la tabla, podría conocer las credenciales de los usuarios.

El hash es una representación que se obtiene mediante una función diseñada para proteger contraseñas. En PostgreSQL se utilizaron las funciones crypt() y gen_salt() de la extensión pgcrypto. Al generar un salt diferente, el resultado puede cambiar incluso cuando se utiliza la misma contraseña. Para comprobar una contraseña se compara el resultado calculado con el hash almacenado, sin recuperar la contraseña original.

El cifrado, en cambio, transforma los datos mediante un algoritmo y una clave, permitiendo recuperar la información original mediante el procedimiento de descifrado y la clave correcta.

Se comprobó que las contraseñas no deben almacenarse en texto claro y que el hash para contraseñas no es equivalente al cifrado reversible.

## Protección de datos sensibles
En la actividad de cifrado se utilizó el RFC como ejemplo de información sensible. Se creó la tabla clientes_protegidos con una columna de tipo BYTEA para almacenar el dato cifrado.

Se utilizó pgp_sym_encrypt() para cifrar el RFC y pgp_sym_decrypt() para recuperar el dato original utilizando la clave correcta.

Con este procedimiento se comprendió que el cifrado permite proteger información sensible almacenada en una tabla. Sin embargo, también es necesario proteger las claves criptográficas, porque una persona que consiga la clave podría intentar descifrar los datos.

Los nombres y otros datos personales también deben protegerse mediante controles de acceso y, cuando el riesgo lo requiera, mecanismos adicionales de seguridad.

## TLS: 
Protección de datos durante la comunicación TLS permite proteger la información durante la transmisión entre un cliente y un servidor mediante cifrado. La validación adecuada de certificados también permite comprobar la identidad del servidor.

Durante las pruebas en PostgreSQL se obtuvieron los siguientes resultados:

SHOW ssl;: off.
SHOW ssl_min_protocol_version;: TLSv1.2.
SHOW port;: 5432.
SHOW listen_addresses;: *.
inet_client_addr(): ::1.
inet_client_port(): 52574.
pg_stat_ssl.ssl: false.
pg_stat_ssl.version: NULL.
pg_stat_ssl.cipher: NULL.

Estos resultados indican que SSL está deshabilitado en el servidor local y que la sesión comprobada no utiliza TLS. Aunque la versión mínima configurada del protocolo es TLSv1.2, esto no significa que TLS esté activo.

También se intentó establecer una conexión mediante psql utilizando sslmode=require, pero PostgreSQL rechazó la conexión porque el servidor local no soporta SSL en su configuración actual.

Por lo tanto, para disponer de una conexión protegida sería necesario habilitar y configurar correctamente TLS en el servidor, además de verificar los certificados según los requisitos de seguridad.

## Gestión de claves
Las claves criptográficas son necesarias para descifrar información protegida. Si se almacenan directamente en archivos SQL, código fuente o repositorios GitLab, pueden quedar expuestas a personas no autorizadas.

Una clave publicada accidentalmente podría utilizarse para intentar descifrar información sensible. Además, eliminar la clave de un archivo no garantiza que desaparezca de las versiones anteriores del repositorio.

En un entorno productivo, las claves deben almacenarse en un gestor de secretos o sistema de gestión de claves (KMS), con acceso restringido, auditoría y procedimientos de rotación y revocación.

Si una clave real se expone, debe considerarse comprometida y sustituirse de acuerdo con un procedimiento de respuesta a incidentes.

## Resultados
Durante el laboratorio se realizaron las siguientes actividades:

Se identificaron los riesgos de almacenar contraseñas en texto claro.
Se utilizaron crypt() y gen_salt() para generar y verificar hashes de contraseñas.
Se creó una tabla para almacenar credenciales protegidas.
Se utilizó pgp_sym_encrypt() para cifrar un RFC y pgp_sym_decrypt() para recuperar el dato original.
Se analizó el riesgo de incluir claves directamente en consultas SQL.
Se consultó la configuración SSL de PostgreSQL y el estado de la conexión mediante pg_stat_ssl.
Se comprobó que el servidor local tenía SSL deshabilitado y que la sesión examinada no utilizaba TLS.
Se estudiaron los riesgos relacionados con la publicación de secretos en repositorios y la protección de respaldos.
Estos ejercicios permitieron reconocer las diferencias entre hash, cifrado y protección de la comunicación, así como la importancia de administrar las claves de manera segura.

## Problemas encontrados
Durante la actividad de conexión mediante psql, PowerShell indicó inicialmente que el comando no se reconocía. El problema se resolvió utilizando la ruta completa del ejecutable psql.exe instalado en PostgreSQL.

Posteriormente, al intentar conectarme con sslmode=require, se obtuvo un error que indicaba que el servidor no soportaba SSL. La consulta SHOW ssl; devolvió off, mientras que pg_stat_ssl mostró ssl = false, version = NULL y cipher = NULL.

Esto permitió identificar que TLS no estaba habilitado en el servidor local. Para obtener una conexión cifrada sería necesario configurar SSL/TLS y comprobar nuevamente el estado de la sesión.

## Conclusiones
En este laboratorio aprendí que proteger una base de datos requiere utilizar mecanismos adecuados para cada tipo de información. Las contraseñas deben almacenarse mediante hashes especializados, los datos sensibles pueden protegerse mediante cifrado y las comunicaciones deben utilizar TLS correctamente configurado.

También comprendí que las claves criptográficas deben mantenerse fuera del código fuente y de los repositorios. Finalmente, identifiqué que el control de acceso, la protección de respaldos y la gestión de claves son medidas complementarias necesarias para reducir los riesgos de seguridad.

# Preguntas de reflexión
### 1. ¿Por qué una contraseña no debe almacenarse como texto claro?
Porque cualquier persona que obtenga acceso de lectura a la tabla podría conocer la contraseña original y utilizarla para acceder a una cuenta. Si esa contraseña se reutiliza en otros servicios, el problema podría afectar también a esas cuentas. Por eso se deben utilizar algoritmos especializados de hash para contraseñas.

### 2. ¿Por qué un hash no es equivalente a un cifrado?
Porque un hash está diseñado para generar una representación que permita verificar una contraseña sin recuperar el texto original. El cifrado, en cambio, permite recuperar los datos mediante una clave correcta y un procedimiento de descifrado.

### 3. ¿Por qué el cifrado de una columna no sustituye al control de acceso?
Porque el cifrado protege la confidencialidad de los datos, pero no determina quién tiene permiso para consultar, modificar o eliminar registros. Además, una aplicación o usuario con acceso a la clave podría descifrar la información. Por eso el cifrado debe complementarse con permisos y controles de acceso.

### 4. ¿Por qué TLS no sustituye a los mecanismos de autorización de PostgreSQL?
Porque TLS protege la comunicación entre el cliente y el servidor, mientras que los mecanismos de autorización determinan qué operaciones puede realizar cada usuario. Una conexión cifrada no impide que un usuario autorizado para conectarse intente realizar acciones para las que tiene permisos excesivos.

### 5. ¿Qué ocurriría si una organización pierde una clave utilizada para cifrar información?
La organización podría perder la capacidad de recuperar los datos cifrados si no dispone de una copia segura de la clave o de un mecanismo de recuperación. Esto podría provocar pérdida de información y afectar las operaciones. Por ello es importante proteger las claves y mantener respaldos seguros cuando corresponda.

### 6. ¿Qué ocurriría si una clave criptográfica se publica accidentalmente en GitLab?
Una persona que obtenga la clave podría utilizarla para intentar descifrar los datos protegidos. La clave debe considerarse comprometida, revocarse o sustituirse cuando corresponda y deben revisarse los posibles accesos y las consecuencias de la exposición.

### 7. ¿Por qué un repositorio privado no debe considerarse un almacén de secretos?
Porque otras personas con acceso al repositorio podrían ver los secretos y las versiones anteriores podrían conservarlos en el historial de Git. Además, los permisos pueden cambiar y el repositorio podría exponerse accidentalmente. Por ello, las claves y contraseñas reales deben almacenarse en sistemas especializados de gestión de secretos.

##" 8. ¿Qué diferencia existe entre proteger información almacenada y proteger información durante su transmisión?
Proteger la información almacenada significa aplicar medidas como cifrado en reposo, controles de acceso y protección de respaldos. Proteger la información durante su transmisión significa utilizar mecanismos como TLS para cifrar los datos que viajan entre el cliente y el servidor. Ambas medidas son necesarias porque protegen situaciones diferentes.

### 9. ¿Por qué la gestión de claves es tan importante como el algoritmo criptográfico?
Porque la seguridad del cifrado depende tanto del algoritmo como de la protección de las claves. Si una clave se pierde, puede impedir la recuperación de los datos; si se expone, una persona no autorizada podría descifrarlos. Por eso deben controlarse el almacenamiento, el acceso, la rotación, el respaldo y la revocación de las claves.

### 10. ¿Qué mecanismo adicional implementarías en una organización para proteger los respaldos de las bases de datos?
Implementaría cifrado de respaldos, almacenamiento en una ubicación segura y separada del servidor principal, controles de acceso estrictos y copias protegidas contra modificaciones o eliminación no autorizada. También realizaría pruebas periódicas de restauración para comprobar que los respaldos sean utilizables.