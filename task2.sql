-- task2

-- TABLES LINK
-- rm_master table link
-- https://docs.google.com/spreadsheets/d/1mU2RE9pcVP60-nlbXSgKvtWikDD178xb_WmZkf8GZUs/edit#gid=1849934484

-- rm_mapping_master table link
-- https://docs.google.com/spreadsheets/d/1SthL4EXLD-aGp11HIF1izUsdXo23LXQdJ9cW1ZJya5c/edit#gid=742607563

-- sales_master table link 
-- https://docs.google.com/spreadsheets/d/1GpD0YwsL5vOVfGCFS4JL-9IHDVvLTlT5CkX9iTQRw4E/edit#gid=1283856246

-- Solution Queries
-- A. To get the total quantity of each rm(raw material) sold in each month.
SELECT rm_mapping_master."RM ID" AS raw_material_ID
EXTRACT (MONTH FROM sales_master."Date") AS sale_month,
SUM(sales_master."Quantity") AS total_Quantity_Sold
FROM sales_master
JOIN rm_mapping_master ON sales_master."SKU"=rm_mapping_master."SKU"
GROUP BY raw_material_ID,sale_month
ORDER BY raw_material_ID,sale_month;

-- B. To get the name of vendors for each SKU.

SELECT rm_mapping_master."SKU",rm_mapping_master."RM ID" AS raw_material_ID,
rm_master."Vendor Name" AS vendor_name 
FROM rm_mapping_master
JOIN rm_master ON rm_mapping_master."RM ID"=rm_master."RM ID"

-- C. Get the most used and least used raw material based on the SKU sold.
WITH rawMaterialUsage As(
	SELECT rm_mapping_master."RM ID" AS raw_material_ID,
	rm_mapping_master."SKU" AS SKU,
	SUM(sales_master."Quantity") AS total_quantitySold
	FROM sales_master
	JOIN rm_mapping_master 
	ON sales_master."SKU"=rm_mapping_master."SKU"
	GROUP BY raw_material_ID,SKU
)
SELECT SKU , raw_material_ID AS most_raw_material_used,
total_quantitySold AS most_used_quantity
FROM rawMaterialUsage
WHERE total_quantitySold=(SELECT MAX(total_quantitySold) FROM rawMaterialUsage)
UNION 
SELECT SKU,raw_material_ID AS least_used_raw_material,
total_quantitySold AS least_used_quantity
FROM rawMaterialUsage
WHERE total_quantitySold=(SELECT MIN(total_quantitySold) FROM rawMaterialUsage)
