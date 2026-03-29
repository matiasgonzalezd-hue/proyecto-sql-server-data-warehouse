# 🏗️ Proyecto SQL Server Data Warehouse

Construcción de un **Data Warehouse moderno por capas** utilizando **SQL Server**, incluyendo procesos de **ETL**, **modelado de datos** y **analítica**.

---

## 📌 Consideraciones Generales

### 🔤 Convención de nombres
Se utilizará la convención **snake_case**, es decir:

- Letras en minúsculas
- Separación de palabras mediante guion bajo (`_`)

**Ejemplos:**
- `dim_productos`
- `fecha_orden`
- `precio_unitario`

### 🌎 Idioma
Todo el proyecto utilizará **nomenclatura en español**, tanto en objetos como en documentación, siempre que sea compatible con buenas prácticas técnicas excepto por la información del dataset que está en inglés sin embargo, se generaran nombres de columnas descriptivas en español en las views en SQL Server en la capa oro.

### ⚠️ Palabras reservadas
Se debe **evitar el uso de palabras reservadas de SQL** como nombres de tablas, columnas, vistas, procedimientos almacenados u otros objetos.

---

## 🧱 Convenciones para el nombramiento de tablas

### 🥉 Capa Bronze
En la capa **Bronze**, los nombres de las tablas deben comenzar con el nombre del sistema de origen y mantener el nombre original de la entidad sin renombrarla.

**Estructura:**

`<sistema_origen>_<entidad>`

**Donde:**
- `<sistema_origen>`: nombre del sistema fuente, por ejemplo: `crm`, `erp`, `sales`, etc.
- `<entidad>`: nombre original de la tabla en el sistema fuente

**Ejemplos:**
- `erp_info_clientes`
- `crm_ventas`
- `erp_productos`

> 📍 Objetivo: conservar la trazabilidad y fidelidad respecto al sistema de origen.

### 🥈 Capa Silver
En la capa **Silver**, los nombres de las tablas también deben comenzar con el nombre del sistema de origen y conservar el nombre original de la entidad.

**Estructura:**

`<sistema_origen>_<entidad>`

**Donde:**
- `<sistema_origen>`: nombre del sistema fuente
- `<entidad>`: nombre original de la tabla procesada

**Ejemplos:**
- `erp_info_clientes`
- `crm_ventas`
- `erp_productos`

> 📍 Objetivo: mantener consistencia entre Bronze y Silver, facilitando el seguimiento del linaje de datos.

### 🥇 Capa Oro
En la capa **Gold**, los nombres deben ser descriptivos y alineados a la lógica de negocio, utilizando un prefijo según el tipo de tabla.

**Estructura:**

`<categoria>_<entidad>`

**Donde:**
- `<categoria>`: rol de la tabla dentro del modelo analítico
  - `dim` → tabla de dimensión
  - `fact` → tabla de hechos
- `<entidad>`: nombre funcional y descriptivo de la entidad de negocio

**Ejemplos:**
- `dim_clientes`
- `dim_productos`
- `fact_ventas`

> 📍 Objetivo: facilitar el entendimiento del modelo dimensional para análisis y reportería.

## 🧾 Convenciones para el nombramiento de columnas

### 🔑 Llaves surrogadas
Todas las **Primary Keys (PK)** de las tablas dimensionales deben utilizar el sufijo `_key`.

**Estructura:**

`<nombre_tabla>_key`

**Ejemplos:**
- `cliente_key`
- `producto_key`
- `tiempo_key`

> 📍 Estas columnas representan llaves surrogadas generadas internamente en el Data Warehouse.

### 🛠️ Columnas técnicas
Todas las columnas técnicas o de metadata deben comenzar con el prefijo `dwh_`, seguido de un nombre descriptivo.

**Estructura:**

`dwh_<nombre_columna>`

**Ejemplos:**
- `dwh_fecha_carga`
- `dwh_fecha_actualizacion`
- `dwh_origen_registro`

**Propósito:**
- Registrar metadata del proceso de carga
- Facilitar auditoría y trazabilidad
- Apoyar controles de calidad y seguimiento de ETL

## ⚙️ Convenciones para procedimientos almacenados

Todos los procedimientos almacenados utilizados para la carga de datos deben seguir una convención simple y consistente.

**Estructura:**

`carga_<capa>`

**Donde:**
- `<capa>`: representa la capa objetivo del proceso de carga

**Ejemplos:**
- `carga_bronce`
- `carga_plata`
- `carga_oro`

> 📍 Esta nomenclatura permite identificar rápidamente el propósito del procedimiento y la capa que alimenta.

## ✅ Resumen de estándares

| Elemento | Convención |
|----------|------------|
| Tablas Bronze | `<sistema_origen>_<entidad>` |
| Tablas Silver | `<sistema_origen>_<entidad>` |
| Tablas Gold | `<categoria>_<entidad>` |
| Llaves surrogadas | `<nombre_tabla>_key` |
| Columnas técnicas | `dwh_<nombre_columna>` |
| Procedimientos ETL | `carga_<capa>` |

## 🎯 Objetivo de estas convenciones

Estas reglas de nombramiento buscan:

- Mantener la **consistencia** en todo el proyecto
- Facilitar la **lectura y mantenimiento** del código
- Mejorar la **trazabilidad** entre capas
- Alinear el modelo con buenas prácticas de **Data Warehousing**
- Hacer que el proyecto sea más **escalable y profesional**

## 📁 Estructura de carpetas

```text
proyecto-sql-server-data-warehouse/
│
├── codigos/                            # Scripts SQL para ETL y transformaciones
│   ├── bronce/                         # Scripts para extraer y cargar datos en bruto
│   ├── plata/                         # Scripts para limpiar y transformar datos
│   ├── oro/                           # Scripts para crear modelos analíticos
│ 
├── datasets/                           # Datasets en bruto utilizados para el proyecto (datos ERP y CRM)
│
├── documentos/                         # Documentación del proyecto y detalles de arquitectura
│   ├── arquitectura_datos.png          # Archivo de Draw.io que muestra la arquitectura del proyecto
│   ├── catalogo_datosg.md              # Catálogo de datasets, incluyendo descripciones de campos y metadatos
│   ├── flujo_datos.png                 # Archivo de Draw.io para el diagrama de flujo de datos
│   ├── data_models.drawio              # Archivo de Draw.io para los modelos de datos (esquema estrella)
│   ├── integracion_datos.drawio        # Archivo de Draw.io que muestra como se integra la data en el DWH
│
├── tests/                              # Scripts de prueba y archivos de calidad
│
├── README.md                           # Descripción general del proyecto e instrucciones
├── LICENSE                             # Información de licencia del repositorio
└── requirements.txt                    # Dependencias y requisitos del proyecto
```
