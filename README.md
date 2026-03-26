# proyecto-sql-server-data-warehouse
Construccion de un DataWarehouse moderno por capas utilizando SQL Server, incluyendo procesos de ETL, modelado de Datos y Analiticas

-------------------------------------
-----Consideraciones Generales-------
-------------------------------------

Convención de Nombres: Se utilizará el enfoque "snake_case", con letras en minúsculas y guiones bajo ( _ ) para separar las palabras, Ejemplos; dim_productos, fecha_orden, precio_unitario,etc
Lenguaje: Se utilizará el lenguaje español
Evitar el uso de palabras reservadas de SQL en nombres: No usar palabras reservadas de SQL  como nombres de objetos


----------------------------------------------------------
-----Consideraciones para el Nombramiento de Tablas-------
----------------------------------------------------------

Reglas para la Capa de Bronce

-Todos los nombres deben comenzar con el nombre del sistema de origen y los nombres de las tablas deben coincidir conel nombre original sin renombrarlo
- <sistemaorigen>_<entidad>
	<sistemaorigen>: Nombre del sistema de origen. Ejemplos (crm, erp, folder_name, etc)
	<entidad>: Nombre exacto de la tabla del sitema de origen.
	Ejemplos: erp_info_clientes ----> Información de los clientes desde el ERP

Reglas para la Capa de Plata

-Todos los nombres deben comenzar con el nombre del sistema de origen y los nombres de las tablas deben coincidir conel nombre original sin renombrarlo
- <sistemaorigen>_<entidad>
	<sistemaorigen>: Nombre del sistema de origen. Ejemplos (crm, erp, folder_name, etc)
	<entidad>: Nombre exacto de la tabla del sitema de origen.
	Ejemplos: erp_info_clientes ----> Información de los clientes desde el ERP

Reglas para la Capa de Oro

-Todos los nombres deben usar nombres decriptivos segun la logica de negocio comenzando con el prefijo de la categoria.
- <categoria>_<entidad>
	<categorria>: Describe el rol de la tabla, como por ejemplo dim (dimension) o fact (tabla de hechos).
	<entidad>: Nombre descriptivo de la Tabla, alineando a la logica de negocio ejemplos (clientes, productos, ventas)
	Ejemplos: dim_clientes, fact_ventas, dim_productos, etc


----------------------------------------------------------
-----Consideraciones para el Nombramiento de Columnas-----
----------------------------------------------------------

Llaves Surrogadas

	Todas las PK (Primary Keys) en las tablas dimensionales deben usar el sufijo _key
	<nombre_tabla>_key
		<nombre_tabla>: Se refiere al nombre de la tabla o entidad a la que pertenece
		<_key>: Un sufijo indicando que esta columna es una Llave Surrogada
		Ejemplo: cliente_key --> Sería una llave surrogada en la tabla dim_customers

Columnas Técnicas
	Todas las columnas tecnicas deben empezar con el prefijo dwh_, seguido de un nombre descriptivo indicado el proposito de la columna
	dwh: Prefijo exclusivo para metadata generada por el sistema
	<nombre_columna>: Nombre descriptivo de la columna indicando el proposito de la columna
	Ejemplo: dwh_fecha_carga ---> Columna generada por el sistema usada para guardar la fecha en la que los registros fueron cargados

Procedimientos Almacenados
-Todos los procedimientos almacenados usados para la carga de la data deben seguir el siguien patron de nombre: carga_<capa>
	<capa>: Representa la capa en la que se esta realizando la carga de data, como bronce, plata, oro
	Ejemplos:
	carga_bronce --> Procedimiento Almacenado para cargar la data en la capa de bronce
	carga_plata --> Procedimiento Almacenado para cargar la data en la capa de plata




 


