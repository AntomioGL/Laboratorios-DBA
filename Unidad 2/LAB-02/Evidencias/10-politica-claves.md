### UNIVERSIDAD AUTÓNOMA DE SINALOA
#### FACULTAD DE INFORMÁTICA CULIACÁN

### ASIGNATURA: 
Gestión de Seguridad y Desempeño de Bases de Datos

### TRABAJO: 
Actividad 10 — Crear una política mínima de protección de claves

### MAESTRO: 
Alexis Moises Montaño Araujo

### ALUMNO: 
Gastelum Landeros Antonio

### GRUPO: 
4-1

# Actividad 10 — Política mínima de protección de claves
## Objetivo
Establecer reglas básicas para proteger las claves criptográficas, controlar su uso y prevenir su exposición, pérdida o utilización por personas no autorizadas.

## Política de protección de claves criptográficas
### Generación: 
las claves criptográficas deben generarse mediante herramientas o sistemas seguros que utilicen generadores de números aleatorios adecuados. No deben crearse utilizando contraseñas personales ni valores fáciles de adivinar.
### Almacenamiento: 
las claves deben guardarse en un gestor de secretos o sistema de gestión de claves (KMS). No deben almacenarse directamente en archivos SQL, código fuente ni repositorios GitLab.
### Acceso: 
únicamente los usuarios y servicios autorizados podrán utilizar las claves. Se deben asignar permisos mínimos necesarios y revisar periódicamente quién tiene acceso.
### Rotación: 
las claves deben renovarse según una periodicidad definida por la organización, los requisitos del sistema y el nivel de riesgo. También deben cambiarse cuando exista sospecha de exposición.
### Respaldo: 
las claves necesarias para recuperar información deben contar con respaldos protegidos, cifrados y con acceso restringido. Se debe comprobar que los procedimientos de recuperación funcionen correctamente.
### Revocación: 
las claves que estén comprometidas, hayan dejado de utilizarse o ya no sean necesarias deben revocarse o deshabilitarse para impedir su uso posterior.
### Exposición accidental: 
si una clave se publica por error en GitLab, debe considerarse comprometida. Se debe revocar o sustituir, revisar los posibles accesos y eliminar la exposición del repositorio y de su historial cuando corresponda.
### Eliminación: 
las claves que ya no sean necesarias deben eliminarse de forma segura, considerando sus copias de respaldo y las obligaciones de conservación. Antes de eliminarlas, se debe verificar que no sean necesarias para descifrar información que deba conservarse.

## Conclusión
Una política de protección de claves permite reducir los riesgos de acceso no autorizado, pérdida de información y exposición de datos sensibles. La generación segura, el almacenamiento adecuado, el control de acceso y la rotación de claves son medidas fundamentales para mantener la seguridad de una base de datos.

# Verificación final del laboratorio
## 1. Credenciales 
### ¿Una contraseña debe cifrarse o protegerse mediante un mecanismo de derivación de claves para contraseñas?

Una contraseña debe protegerse mediante un algoritmo especializado de hash para contraseñas, como Argon2id o bcrypt, con salt y parámetros adecuados. No debe almacenarse en texto claro ni cifrarse como si necesitáramos recuperar su valor original.

## 2. Datos sensibles
### ¿Qué diferencia existe entre enmascaramiento, seudonimización y cifrado?
Enmascaramiento: oculta total o parcialmente un dato para evitar mostrar su valor completo, por ejemplo, presentar solo los últimos cuatro caracteres de un RFC.
Seudonimización: sustituye los datos identificadores por códigos o identificadores alternativos. La identificación de la persona puede seguir siendo posible si se dispone de información adicional.
Cifrado: transforma los datos mediante un algoritmo y una clave para que no puedan leerse directamente. El dato original puede recuperarse utilizando la clave correcta y el procedimiento de descifrado correspondiente.
## 3. Comunicaciones
### ¿Qué problema resuelve TLS?

TLS protege la información durante la transmisión entre un cliente y un servidor mediante cifrado. También permite verificar la identidad del servidor cuando se configura correctamente la validación de certificados, ayudando a prevenir la interceptación y la suplantación.

## 4. Claves
### ¿Dónde debería almacenarse una clave criptográfica en un entorno real?

Una clave criptográfica debe almacenarse en un gestor de secretos o sistema de gestión de claves (KMS), con controles de acceso, auditoría y mecanismos de protección adecuados. No debe guardarse directamente en el código fuente ni en el mismo repositorio que los scripts que la utilizan.

## 5. Repositorio
### ¿Es correcto subir una contraseña o clave real a GitLab aunque el repositorio sea privado?

No. Un repositorio privado reduce la exposición, pero no convierte un secreto en información apropiada para almacenar dentro del código. Las claves y contraseñas reales deben mantenerse fuera del repositorio y administrarse mediante mecanismos seguros.