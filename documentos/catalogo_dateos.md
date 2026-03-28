## 1. gold.dim_customers

- **Propósito:** Almacena detalles de clientes enriquecidos con datos demográficos y geográficos.
- **Columnas:**

| Nombre de columna | Tipo de dato | Descripción |
|---|---|---|
| customer_key | INT | Clave sustituta que identifica de forma única cada registro de cliente en la tabla de dimensión. |
| customer_id | INT | Identificador numérico único asignado a cada cliente. |
| customer_number | NVARCHAR(50) | Identificador alfanumérico que representa al cliente, utilizado para seguimiento y referencia. |
| first_name | NVARCHAR(50) | Nombre del cliente, tal como está registrado en el sistema. |
| last_name | NVARCHAR(50) | Apellido del cliente. |
| country | NVARCHAR(50) | País de residencia del cliente (por ejemplo, 'Australia'). |
| marital_status | NVARCHAR(50) | Estado civil del cliente (por ejemplo, 'Casado', 'Soltero'). |
| gender | NVARCHAR(50) | Género del cliente (por ejemplo, 'Masculino', 'Femenino', 'n/a'). |
| birthdate | DATE | Fecha de nacimiento del cliente, con formato YYYY-MM-DD (por ejemplo, 1971-10-06). |
| create_date | DATE | Fecha y hora en que el registro del cliente fue creado en el sistema. |
