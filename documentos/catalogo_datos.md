## 1. oro.dim_clientes

- **Propósito:** Almacena detalles de clientes enriquecidos con datos demográficos y geográficos.
- **Columnas:**

| Nombre de columna | Tipo de dato | Descripción |
|---|---|---|
| cliente_key | INT | Clave sustituta que identifica de forma única cada registro de cliente en la tabla de dimensión. |
| id_cliente | INT | Identificador numérico único asignado a cada cliente. |
| numero_cliente | NVARCHAR(50) | Identificador alfanumérico que representa al cliente, utilizado para seguimiento y referencia. |
| nombre_cliente | NVARCHAR(50) | Nombre del cliente, tal como está registrado en el sistema. |
| apellido_cliente | NVARCHAR(50) | Apellido del cliente. |
| pais | NVARCHAR(50) | País de residencia del cliente (por ejemplo, 'United States'). |
| estado_marital | NVARCHAR(50) | Estado civil del cliente (por ejemplo, 'Married', 'Single'). |
| sexo_cliente | NVARCHAR(50) | Género del cliente (por ejemplo, 'Male', 'Female', 'n/a'). |
| fecha_nacimiento | DATE | Fecha de nacimiento del cliente, con formato YYYY-MM-DD (por ejemplo, 1971-10-06). |
| fecha_creacion | DATE | Fecha y hora en que el registro del cliente fue creado en el sistema. |

## 2. gold.dim_producto

- **Propósito:** Proporciona información sobre los productos y sus atributos.
- **Columnas:**

| Nombre de columna | Tipo de dato | Descripción |
|---|---|---|
| producto_key | INT | Clave sustituta que identifica de forma única cada registro de producto en la tabla de dimensión de productos. |
| id_producto | INT | Identificador único asignado al producto para seguimiento y referencia internos. |
| numero_producto | NVARCHAR(50) | Código alfanumérico estructurado que representa al producto, usado con frecuencia para categorización o inventario. |
| nombre_producto | NVARCHAR(50) | Nombre descriptivo del producto, incluyendo detalles clave como tipo, color y tamaño. |
| id_categoria | NVARCHAR(50) | Identificador único de la categoría del producto, que la vincula con su clasificación de alto nivel. |
| categoria | NVARCHAR(50) | Clasificación general del producto (por ejemplo, Bicicletas, Componentes) para agrupar artículos relacionados. |
| subcategoria | NVARCHAR(50) | Clasificación más detallada del producto dentro de la categoría, como el tipo de producto. |
| Mantencion | NVARCHAR(50) | Indica si el producto requiere mantenimiento (por ejemplo, 'Sí', 'No'). |
| costo | INT | Costo o precio base del producto, medido en unidades monetarias. |
| linea_producto | NVARCHAR(50) | Línea o serie específica de producto a la que pertenece (por ejemplo, Road, Mountain). |
| fecha_inicio | DATE | Fecha en que el producto estuvo disponible para la venta o uso. |
