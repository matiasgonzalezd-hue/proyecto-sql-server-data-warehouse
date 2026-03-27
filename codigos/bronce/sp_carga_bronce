/*
=====================================================================================

Procedimiento Almacenado: Carga la Capa de Bronce (Fuentes -->	Bronce)

=====================================================================================

Propósito del Código:
	Este Procedimiento Almacenado carga data en el schema 'bronce' dese archivos CSV externos.
	Realiza las siguientes acciones:
	- Trunca las tablas de bronce antes de realizar la carga.
	- Usa el comando 'BULK INSERT' para cargar la data desde los archivos CSV a las tablas del schema bronce.

Parámetros: Ninguno
	Este Procedimiento Almacenado no acepta ningún parámetro o retorna algun valor.

Ejemplo de uso:
	EXEC.bronce.load_bronce;

=====================================================================================
*/


CREATE OR ALTER PROCEDURE bronce.load_bronce AS
BEGIN
	DECLARE @inicio DATETIME, @fin DATETIME, @inicio_batch DATETIME, @fin_batch DATETIME
	SET @inicio_batch = GETDATE();
	BEGIN TRY
		PRINT '===================================';
		PRINT 'Cargando Capa Bronce';
		PRINT '===================================';

		PRINT '-----------------------------------';
		PRINT 'Cargando Tablas del CRM';
		PRINT '-----------------------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.crm_cust_info';
		TRUNCATE TABLE bronce.crm_cust_info;

		PRINT '>>> Insertando Datos en: bronce.crm_cust_info';
		BULK INSERT bronce.crm_cust_info
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.crm_prd_info';
		TRUNCATE TABLE bronce.crm_prd_info;

		PRINT '>>> Insertando Datos en: bronce.crm_prd_info';
		BULK INSERT bronce.crm_prd_info
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.crm_sales_details';
		TRUNCATE TABLE bronce.crm_sales_details;

		PRINT '>>> Insertando Datos en: bronce.crm_sales_details';
		BULK INSERT bronce.crm_sales_details
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ---------------------';

		PRINT '-----------------------------------';
		PRINT 'Cargando Tablas del ERP';
		PRINT '-----------------------------------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.erp_cust_az12';
		TRUNCATE TABLE bronce.erp_cust_az12;

		PRINT '>>> Insertando Datos en: bronce.erp_cust_az12';
		BULK INSERT bronce.erp_cust_az12
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.erp_loc_a101';
		TRUNCATE TABLE bronce.erp_loc_a101;

		PRINT '>>> Insertando Datos en: bronce.erp_loc_a101';
		BULK INSERT bronce.erp_loc_a101
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ------';

		SET @inicio = GETDATE();
		PRINT '>>> Truncando Tabla: bronce.erp_px_cat_g1v2';
		TRUNCATE TABLE bronce.erp_px_cat_g1v2;

		PRINT '>>> Insertando Datos en: bronce.erp_px_cat_g1v2';
		BULK INSERT bronce.erp_px_cat_g1v2
		FROM 'C:\Users\matia\Desktop\Portafolio\Proyecto DataWarehouse End to End PBI\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @fin = GETDATE();
		PRINT '>>> Duración de la Carga:' + CAST(DATEDIFF(second, @inicio, @fin) AS NVARCHAR) + ' segundos';
		PRINT '>>> ------';

		SET @fin_batch = GETDATE();
		PRINT '===================================';
		PRINT 'La carga de la Capa de Bronce fue Completada';
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
