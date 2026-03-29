/*
===============================================================================
Procedimiento Almacenado: Cargar Capa Plata (Bronce -> Plata)
===============================================================================

Propósito del Script:
    Este procedimiento almacenado ejecuta el proceso ETL (Extracción, Transformación y Carga)
    para poblar las tablas del esquema 'plata' a partir del esquema 'bronce'.

Acciones Realizadas:
    - Trunca las tablas de Plata.
    - Inserta datos transformados y depurados desde Bronce hacia las tablas Plata.

Parámetros:
    Ninguno.
    Este procedimiento almacenado no acepta parámetros ni retorna valores.

Ejemplo de Uso:
    EXEC plata.load_plata;
===============================================================================
*/
CREATE OR ALTER PROCEDURE plata.carga_plata AS
BEGIN
	DECLARE @inicio DATETIME, @fin DATETIME, @inicio_batch DATETIME, @fin_batch DATETIME
	SET @inicio_batch = GETDATE();
	BEGIN TRY
		PRINT '===================================';
		PRINT 'Cargando Capa Plata';
		PRINT '===================================';

		PRINT '-----------------------------------';
		PRINT 'Cargando Tablas del CRM';
		PRINT '-----------------------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.crm_cust_info';
		TRUNCATE TABLE plata.crm_cust_info;

		PRINT '>>> Insertando Datos en: plata.crm_cust_info';
		INSERT INTO plata.crm_cust_info(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date)
		SELECT
		cst_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			 ELSE 'n/a'
		END AS cst_marital_status,
		CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			 ELSE 'n/a'
		END AS cst_gndr,
		cst_create_date
		FROM(
		SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
		FROM bronce.crm_cust_info
		WHERE cst_id IS NOT NULL
		) r
		WHERE flag_last = 1
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.crm_prd_info';
		TRUNCATE TABLE plata.crm_prd_info;

		PRINT '>>> Insertando Datos en: plata.crm_prd_info';
		INSERT INTO plata.crm_prd_info(
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
		)
		SELECT
		prd_id,
		REPLACE(TRIM(SUBSTRING(prd_key, 1, 5)),'-', '_') AS cat_id,
		TRIM(SUBSTRING(prd_key, 7, LEN(prd_key))) AS prd_key,
		prd_nm,
		COALESCE(prd_cost, 0) AS prd_cost,
		CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
			 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
			 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
			 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
			 ELSE 'n/a'
		END AS prd_line,
		CAST(prd_start_dt AS DATE) AS prd_start_dt,
		CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
		FROM bronce.crm_prd_info
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.crm_sales_details';
		TRUNCATE TABLE plata.crm_sales_details;

		PRINT '>>> Insertando Datos en: plata.crm_sales_details';
		INSERT INTO plata.crm_sales_details(
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
		)
		SELECT
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
			 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
		END AS sls_order_dt,
		CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
			 ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
		END AS sls_ship_dt,
		CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
			 ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
		END AS sls_due_dt,
		CASE WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity*ABS(sls_price)  
			 THEN sls_quantity*ABS(sls_price)
			 ELSE sls_sales
		END AS sls_sales,
		sls_quantity,
		CASE WHEN sls_price <= 0 OR sls_price IS NULL THEN sls_sales/NULLIF(sls_quantity,0)
			 ELSE sls_price
		END AS sls_price
		FROM bronce.crm_sales_details
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		PRINT '-----------------------------------';
		PRINT 'Cargando Tablas del ERP';
		PRINT '-----------------------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.erp_cust_az12';
		TRUNCATE TABLE plata.erp_cust_az12;

		PRINT '>>> Insertando Datos en: plata.erp_cust_az12';
		INSERT INTO plata.erp_cust_az12(
		cid,
		bdate,
		gen
		)
		SELECT
		CASE WHEN cid like 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
			 ELSE cid
		END AS cid,
		CASE WHEN LEN(bdate) != 10 OR bdate > GETDATE() THEN NULL
			 ELSE bdate
		END AS bdate,
		CASE WHEN TRIM(UPPER(gen)) IN ('M', 'Male') THEN 'Male'
			 WHEN TRIM(UPPER(gen)) IN ('F', 'Female') THEN 'Female'
			 ELSE 'n/a'
		END AS gen
		from bronce.erp_cust_az12
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.erp_loc_a101';
		TRUNCATE TABLE plata.erp_loc_a101;

		PRINT '>>> Insertando Datos en: plata.erp_loc_a101';
		INSERT INTO plata.erp_loc_a101(
		cid,
		cntry
		)
		SELECT
		REPLACE(cid, '-' , '') as cid,
		CASE WHEN TRIM(UPPER(cntry)) = 'DE' THEN 'Germany'
			 WHEN TRIM(UPPER(cntry)) IN ('USA', 'US') THEN 'United States'
			 WHEN TRIM(cntry) = '' OR TRIM(cntry) IS NULL THEN 'n/a'
			 ELSE TRIM(cntry)
		END AS cntry
		FROM bronce.erp_loc_a101
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: plata.erp_px_cat_g1v2';
		TRUNCATE TABLE plata.erp_px_cat_g1v2;

		PRINT '>>> Insertando Datos en: plata.erp_px_cat_g1v2';
		INSERT INTO plata.erp_px_cat_g1v2(
		id,
		cat,
		subcat,
		maitenance
		)
		SELECT
		id,
		cat,
		subcat,
		maitenance
		FROM bronce.erp_px_cat_g1v2
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @fin_batch = GETDATE();
		PRINT '===================================';
		PRINT 'La carga de la Capa de Plata fue Completada';
		PRINT '	- Duración Total: ' + CAST(DATEDIFF(second, @inicio_batch, @fin_batch) AS NVARCHAR) + ' segundos';
	END TRY
	BEGIN CATCH
		PRINT '===================================';
		PRINT 'OCURRIÓ UN ERROR DURANTE LA CARGA CAPA BRONCE';
		PRINT 'Mensaje de Error' + ERROR_MESSAGE();
		PRINT 'Mensaje de Error' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Mensaje de Error' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================';
	END CATCH
END
