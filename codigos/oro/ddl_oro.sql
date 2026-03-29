/*
===============================================================================
Script DDL: Crear Vistas de la Capa oro
===============================================================================
Propósito del Script:
    Este script crea vistas para la capa oro en el data warehouse. 
    La capa oro representa las tablas de dimensiones y hechos finales 
    (esquema estrella).

    Cada vista realiza transformaciones y combina datos provenientes de la capa plata
    para producir un conjunto de datos limpio, enriquecido y listo para el negocio.

Uso:
    - Estas vistas pueden ser consultadas directamente para análisis y reportería.
===============================================================================
*/

-- =============================================================================
-- Crear Dimensión: oro.dim_cliente
-- =============================================================================
IF OBJECT_ID('oro.dim_cliente', 'V') IS NOT NULL
    DROP VIEW oro.dim_cliente;
GO

CREATE VIEW oro.dim_cliente AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id, ci.cst_create_date) AS cliente_key,
	ci.cst_id AS id_cliente,
	ci.cst_key AS numero_cliente,
	ci.cst_firstname AS nombre_cliente,
	ci.cst_lastname AS apellido_cliente,
	ci.cst_marital_status AS estado_marital,
	loc.cntry AS pais,
	CASE WHEN ci.cst_gndr = 'n/a' THEN COALESCE(ca.gen, 'n/a')
		 ELSE ci.cst_gndr
	END AS sexo_cliente,
	ca.bdate AS fecha_nacimiento,
	ci.cst_create_date AS fecha_creacion
FROM plata.crm_cust_info as ci
LEFT JOIN plata.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN plata.erp_loc_a101 loc ON ci.cst_key = loc.cid;
GO

-- =============================================================================
-- Create Dimension: oro.dim_producto
-- =============================================================================
IF OBJECT_ID('oro.dim_producto', 'V') IS NOT NULL
    DROP VIEW oro.dim_producto;
GO

CREATE VIEW oro.dim_producto AS
SELECT
	ROW_NUMBER() OVER (ORDER BY prd.prd_start_dt, prd.prd_key) AS producto_key,
	prd.prd_id AS id_producto,
	prd.prd_key as numero_producto,
	prd.prd_line AS linea_producto,
	prd.prd_nm AS nomre_producto,
	prd.cat_id AS id_categoria,
	cat.cat AS categoria,
	cat.subcat AS subcategoria,
	cat.maitenance AS Mantencion,
	prd.prd_cost AS costo,
	CAST(prd.prd_start_dt AS DATE) AS fecha_inicio
FROM plata.crm_prd_info prd
LEFT JOIN plata.erp_px_cat_g1v2 cat ON prd.cat_id = cat.id
WHERE prd_end_dt IS NULL;
GO

-- =============================================================================
-- Create Fact Table: oro.fact_ventas
-- =============================================================================
IF OBJECT_ID('oro.fact_ventas', 'V') IS NOT NULL
    DROP VIEW oro.fact_ventas;
GO

CREATE VIEW oro.fact_ventas AS
SELECT
	sls_ord_num AS numero_orden,
	c.cliente_key,
	p.producto_key,
	sls_sales AS ventas,
	sls_quantity AS cantidad,
	sls_price AS precio,
	sls_order_dt AS fecha_orden,
	sls_ship_dt AS fecha_embarque,
	sls_due_dt AS fecha_vencimiento
FROM plata.crm_sales_details v
LEFT JOIN oro.dim_cliente c ON v.sls_cust_id = c.id_cliente
LEFT JOIN oro.dim_producto p ON v.sls_prd_key = p.numero_producto;
GO
