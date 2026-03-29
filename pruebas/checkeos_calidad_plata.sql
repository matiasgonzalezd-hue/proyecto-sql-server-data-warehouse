/*
===============================================================================
Controles de Calidad
===============================================================================
Propósito del Script:
    Este script realiza diversos controles de calidad para validar la consistencia,
    precisión y estandarización de los datos en la capa 'plata'. Incluye validaciones para:
    - Valores nulos o claves primarias duplicadas.
    - Espacios no deseados en campos de texto.
    - Estandarización y consistencia de los datos.
    - Rangos y secuencias de fechas inválidas.
    - Consistencia de datos entre campos relacionados.

Notas de Uso:
    - Ejecutar estos controles después de la carga de datos en la Capa Plata.
    - Investigar y corregir cualquier discrepancia encontrada durante las validaciones.
===============================================================================
*/

-- ====================================================================
-- Validando 'plata.crm_cust_info'
-- ====================================================================
-- Validar NULLs o duplicados en la Clave Primaria
-- Resultado esperado: Sin resultados
SELECT 
    cst_id,
    COUNT(*) 
FROM plata.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Validar espacios no deseados
-- Resultado esperado: Sin resultados
SELECT 
    cst_key 
FROM plata.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Estandarización y consistencia de datos
SELECT DISTINCT 
    cst_marital_status 
FROM plata.crm_cust_info;

-- ====================================================================
-- Validando 'plata.crm_prd_info'
-- ====================================================================
-- Validar NULLs o duplicados en la Clave Primaria
-- Resultado esperado: Sin resultados
SELECT 
    prd_id,
    COUNT(*) 
FROM plata.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Validar espacios no deseados
-- Resultado esperado: Sin resultados
SELECT 
    prd_nm 
FROM plata.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Validar NULLs o valores negativos en el costo
-- Resultado esperado: Sin resultados
SELECT 
    prd_cost 
FROM plata.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Estandarización y consistencia de datos
SELECT DISTINCT 
    prd_line 
FROM plata.crm_prd_info;

-- Validar secuencia inválida de fechas (fecha de inicio > fecha de término)
-- Resultado esperado: Sin resultados
SELECT 
    * 
FROM plata.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ====================================================================
-- Validando 'plata.crm_sales_details'
-- ====================================================================
-- Validar fechas inválidas
-- Resultado esperado: Sin fechas inválidas
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Validar secuencia inválida de fechas (fecha de orden > fecha de envío / vencimiento)
-- Resultado esperado: Sin resultados
SELECT 
    * 
FROM plata.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Validar consistencia de datos: Ventas = Cantidad * Precio
-- Resultado esperado: Sin resultados
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM plata.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- Validando 'plata.erp_cust_az12'
-- ====================================================================
-- Identificar fechas fuera de rango
-- Resultado esperado: Fechas de nacimiento entre 1924-01-01 y hoy
SELECT DISTINCT 
    bdate 
FROM plata.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Estandarización y consistencia de datos
SELECT DISTINCT 
    gen 
FROM plata.erp_cust_az12;

-- ====================================================================
-- Validando 'plata.erp_loc_a101'
-- ====================================================================
-- Estandarización y consistencia de datos
SELECT DISTINCT 
    cntry 
FROM plata.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- Validando 'plata.erp_px_cat_g1v2'
-- ====================================================================
-- Validar espacios no deseados
-- Resultado esperado: Sin resultados
SELECT 
    * 
FROM plata.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Estandarización y consistencia de datos
SELECT DISTINCT 
    maintenance 
FROM plata.erp_px_cat_g1v2;
