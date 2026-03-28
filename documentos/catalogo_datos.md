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
