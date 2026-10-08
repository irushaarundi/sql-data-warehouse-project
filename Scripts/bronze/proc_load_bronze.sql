/*
==================================================================================================

Stored Procedure: Load Bronze Layer (Source -> Bronze)

==================================================================================================
Script Purpose:
  This stored procedure loads date into the 'bronze' schema from external CSV files.
  It performs the bronze tables befor loading data.
  - Truncates the bronze tables befor loading data.
  - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
  This store procedure doesn't accept any parameters or return any values.
Usage Example:
  EXEC bronze.load_bronze;
==================================================================================================
*/

EXEC bronze.load_bronze
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	DECLARE @start_time_1 DATETIME, @end_time_1 DATETIME
	BEGIN TRY
		SET @start_time_1 = GETDATE();
		PRINT '======================================================';
		PRINT 'Loading Bronze Bronze Layer';
		PRINT '======================================================';

		PRINT '------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------------';
		--crm_cust_info

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_cust_info'; 
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Insterting Data into: bronze.crm_cust_info';
	
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------';

		-- crm_prd_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_prd_info'; 
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Insterting Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' second';
		PRINT '-------------------------------------------------';
		--crm_sales_details
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_sales_details'; 
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Insterting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' second';
		PRINT '-------------------------------------------------';

		PRINT '------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------------';

		--erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.erp_cust_az12'; 
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Insterting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' second';
		PRINT '-------------------------------------------------';


		--erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.erp_loc_a101'; 
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Insterting Data into: bronze.erp_loc_a101';

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' second';
		PRINT '-------------------------------------------------';


		--erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.erp_px_cat_g1v2'; 
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Insterting Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\SQL_Warehouse_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' second';
		PRINT '-------------------------------------------------';

	END TRY
	BEGIN CATCH
		PRINT '======================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '======================================================'
	END CATCH
	SET @end_time_1 = GETDATE();
	PRINT '>> Bronze Layer Load Duration:' + CAST(DATEDIFF(second, @start_time_1,@end_time_1) AS NVARCHAR) + ' second';
	PRINT '-------------------------------------------------';

END
