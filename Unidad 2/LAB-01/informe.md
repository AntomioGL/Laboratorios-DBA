# LAB-01 INFORME

### Clasificación
Los datos que requieren mayor protección son el nombre, el correo, el teléfono y el RFC, porque permiten identificar directamente a una persona o contactarla. La edad, la ciudad, el código postal y la fecha de alta también deben protegerse, ya que al combinarse podrían ayudar a identificar a un cliente.

## Enmascaramiento
Se ocultaron partes del correo electrónico, del teléfono y del RFC, mientras que se mantuvieron visibles algunos caracteres para permitir una referencia limitada al cliente. Esta técnica está dirigida al personal de soporte, que puede necesitar consultar información básica para atender solicitudes, pero no requiere conocer todos los datos personales. El mecanismo utilizado fue una vista llamada v_clientes_soporte, que presenta los datos enmascarados mediante expresiones SQL. Además, se restringió el acceso directo del rol soporte a la tabla original clientes.

## Seudonimización
La seudonimización se implementó generando tokens únicos mediante la función gen_random_uuid(), proporcionada por la extensión pgcrypto de PostgreSQL.
El mapa de correspondencia se almacenó en la tabla pii.mapa_cliente, donde se relaciona cada token con el identificador original del cliente. Por otra parte, la tabla analitica.clientes contiene los tokens y los atributos necesarios para realizar análisis, como la edad, la ciudad, el código postal y la fecha de alta.
El mapa de correspondencia debería estar disponible únicamente para el personal estrictamente autorizado que necesite relacionar un token con un cliente real.
Se separaron los permisos para evitar que el personal de analítica pueda consultar directamente la identidad de los clientes. El rol analista puede consultar la información de analitica.clientes, pero no debería acceder a pii.mapa_cliente ni a public.clientes.

## Anonimización
Los identificadores directos, como el nombre, el correo electrónico, el teléfono y el RFC, no se incluyeron en los resultados agregados. También se generalizó la edad mediante rangos y se utilizó una parte del código postal para representar una región más amplia.
Se combinaron los rangos de edad con la región para observar cuántos clientes pertenecían a cada grupo. Después, se utilizó la condición HAVING COUNT(*) >= 5 para suprimir los grupos con menos de cinco registros.
Aun así, permanece cierto riesgo de reidentificación si se combinan los resultados con otras fuentes de información o si se conocen características particulares de una persona.

## Retención
Para la retención se estableció un periodo hipotético de cinco años. Se utilizó una consulta SQL que identifica los registros cuya fecha de alta es anterior a la fecha actual menos cinco años.
La información debería conservarse mientras sea necesaria para la finalidad para la que fue recopilada o mientras exista una obligación válida de conservarla. Los datos que ya no sean necesarios podrían eliminarse cuando se haya verificado que no existe una razón legal, administrativa u operativa para mantenerlos.
Antes de eliminar información, deberían existir controles como la autorización del responsable, la revisión del periodo de conservación, una copia de seguridad verificada, el registro de la decisión y un procedimiento de recuperación ante eliminaciones accidentales.

## Conclusiones
### ¿Qué técnica utilizarías para un área de soporte?
Utilizaría el enmascaramiento mediante una vista, porque permite consultar información útil para atender solicitudes sin mostrar todos los datos personales del cliente.

### ¿Qué técnica utilizarías para un área de analítica?
Utilizaría la seudonimización y la separación de permisos, de esta manera los analistas pueden trabajar con tokens y atributos útiles sin tener acceso directo a los identificadores de los clientes ni al mapa de correspondencia.

### ¿Qué técnica utilizarías para publicar estadísticas?
Utilizaría la anonimización mediante agregación, generalización y supresión de grupos pequeños, antes de publicar los resultados, revisaría el riesgo de reidentificación que pudiera existir al combinar los datos con otras fuentes.

### ¿Por qué ninguna de estas técnicas sustituye al control de acceso?
Porque estas técnicas reducen la exposición de los datos, pero no impiden por sí mismas que una persona consulte información para la que no tiene autorización.

# Preguntas de reflexión
## 1. ¿Cuál es la diferencia entre enmascaramiento y seudonimización?

El enmascaramiento oculta parte de un dato, por ejemplo, mostrando solamente algunos caracteres del correo o del teléfono y la seudonimización sustituye los identificadores directos por un token que puede relacionarse con el cliente original mediante un mapa separado.

## 2. ¿Por qué la seudonimización no significa anonimización?

Porque los datos seudonimizados todavía pueden relacionarse con una persona si se tiene acceso al mapa de correspondencia o si se dispone de información adicional que permita identificarla.

## 3. ¿Por qué eliminar nombre y RFC no garantiza que un conjunto de datos sea anónimo?

Porque otros atributos, como la edad, la ciudad, el código postal y la fecha de alta, pueden combinarse para identificar a una persona, especialmente cuando existen pocos registros o características poco comunes.

## 4. ¿Qué función tienen los cuasi-identificadores?

Son atributos que, aunque no identifican directamente a una persona por sí solos, pueden ayudar a identificarla cuando se combinan con otros datos. 


## 5. ¿Por qué es importante separar el mapa de seudonimización?

Porque contiene la relación entre los tokens y los identificadores originales.

## 6. ¿Qué principio de seguridad se aplica al impedir que el analista acceda al mapa?

Se aplica el principio de mínimo privilegio, que consiste en otorgar a cada usuario solamente los permisos que necesita para realizar sus actividades.

## 7. ¿Por qué una vista puede ser preferible a entregar acceso directo a la tabla?

Porque una vista permite mostrar solamente las columnas y los datos que necesita un usuario, ademas puede aplicar enmascaramiento y limitar la exposición de información personal sin conceder acceso directo a toda la tabla original.

## 8. ¿Qué diferencia existe entre proteger un dato para visualización y protegerlo contra acceso no autorizado?

Proteger un dato para visualización significa modificar cómo se presenta y protegerlo contra el acceso no autorizado significa impedir que un usuario sin permisos pueda consultar el dato original.

## 9. ¿Por qué la retención forma parte de la protección de datos?

Porque conservar información durante más tiempo del necesario aumenta el riesgo de exposición, uso indebido o acceso no autorizado.

## 10. ¿Qué riesgo existe si una organización conserva información indefinidamente?

Existe un mayor riesgo de filtraciones, robo de identidad, uso indebido de información personal y accesos no autorizados.