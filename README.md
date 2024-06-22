## Tarea 3

### Logros de la entrega:
* Integracion Continua Logrado (Hecho por ambos)
* Test unitarios sobre los modelos (Diego)
* Test de integracion sobre los controladores (Javier)
* Porcentaje de coverage: 85%

Se deben configurar las variables de entorno antes de ejecutar la aplicación

## Tarea 4

### Cambios Realizados para Solucionar el Error

#### Resumen del Problema
El problema inicial se presentó debido a una gestión incorrecta del stock para productos de tipo "Cancha", lo que resultaba en errores al intentar realizar reservas. Se decidió implementar una solución donde todas las canchas tienen un stock fijo de 1, junto con una fecha, hora de inicio y hora de término definidas.

#### Cambios Realizados

1. **Modelo de Producto (Product Model)**:
    - **Campos Nuevos**: Se añadieron los campos `fecha`, `hora_inicio` y `hora_fin` para gestionar la disponibilidad específica de cada cancha.
    - **Validaciones**: Se implementaron validaciones para asegurar que las canchas tienen estos campos definidos y que el stock es siempre 1.

2. **Controlador de Productos (ProductsController)**:
    - **Acción Crear (insertar)**: Se modificó para incluir y validar los nuevos campos `fecha`, `hora_inicio` y `hora_fin` cuando se crea una cancha. Si el producto es una cancha, el stock se establece automáticamente en 1.
    - **Acción Actualizar (actualizar_producto)**: Se añadió la lógica para manejar y validar los nuevos campos al actualizar una cancha.

3. **Vistas (Views)**:
    - **Crear Producto (crear)**: 
        - Se añadió un formulario para ingresar la fecha, hora de inicio y hora de término si la categoría seleccionada es "Cancha".
        - El campo de stock se oculta automáticamente para las canchas.
    - **Editar Producto (actualizar)**:
        - Similar a la vista de creación, se añadió un formulario para gestionar la fecha y horarios específicos de las canchas.
        - El campo de stock también se oculta en esta vista para las canchas.
    - **Solicitar Producto (leer)**:
        - Se ajustó para mostrar la información específica de la reserva (fecha, hora de inicio y hora de término) y no solicitar stock adicional.
        - La lógica de reserva se actualizó para reflejar que cada cancha solo puede ser reservada una vez debido a su stock fijo de 1.

4. **Controlador de Solicitudes (SolicitudController)**:
    - Se modificó para gestionar las reservas de canchas verificando que el stock sea 1 y reduciéndolo correctamente una vez hecha la reserva.
    - Se aseguraron las validaciones para que las reservas se hagan correctamente, considerando las nuevas restricciones y campos.

#### Resultado
Con estos cambios, se ha solucionado el error de gestión de stock y reservas para productos de tipo "Cancha". Ahora cada cancha tiene un stock fijo de 1, y las vistas y controladores se han ajustado para gestionar las reservas con fecha, hora de inicio y hora de término específicas, asegurando una correcta gestión y usabilidad del sistema.





