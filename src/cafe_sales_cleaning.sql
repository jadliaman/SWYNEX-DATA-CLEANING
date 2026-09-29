-- SWYNEX Cafe Sales Data Cleaning Project
-- Dataset: Cafe Sales

-- 1. Check total rows in the raw dataset
SELECT COUNT(*) AS total_rows
FROM cafe_sales_raw;


-- 2. Check for duplicate Transaction IDs
SELECT
    `Transaction ID`,
    COUNT(*) AS frequency
FROM cafe_sales_raw
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;


-- 3. Create a separate cleaned table
CREATE TABLE cafe_sales_cleaned AS
SELECT *
FROM cafe_sales_raw;


-- 4. Clean blank, ERROR and UNKNOWN values
UPDATE cafe_sales_cleaned
SET
    `Item` = NULLIF(NULLIF(NULLIF(`Item`, ''), 'ERROR'), 'UNKNOWN'),
    `Payment Method` = NULLIF(NULLIF(NULLIF(`Payment Method`, ''), 'ERROR'), 'UNKNOWN'),
    `Location` = NULLIF(NULLIF(NULLIF(`Location`, ''), 'ERROR'), 'UNKNOWN'),
    `Transaction Date` = NULLIF(NULLIF(NULLIF(`Transaction Date`, ''), 'ERROR'), 'UNKNOWN'),
    `Total Spent` = NULLIF(NULLIF(NULLIF(`Total Spent`, ''), 'ERROR'), 'UNKNOWN');


-- 5. Check whether Total Spent matches Quantity × Price per unit
SELECT
    `Transaction ID`,
    `Quantity`,
    `Price per unit`,
    `Total Spent`,
    (`Quantity` * `Price per unit`) AS expected_total
FROM cafe_sales_cleaned
WHERE `Total Spent` IS NOT NULL
  AND (`Total Spent` + 0) <> (`Quantity` * `Price per unit`);


-- 6. Correct the data type of Total Spent
ALTER TABLE cafe_sales_cleaned
MODIFY COLUMN `Total Spent` DECIMAL(10,2);


-- 7. Correct the data type of Transaction Date
ALTER TABLE cafe_sales_cleaned
MODIFY COLUMN `Transaction Date` DATE;


-- 8. Verify the final number of rows
SELECT COUNT(*) AS total_rows
FROM cafe_sales_cleaned;


-- 9. Verify the final data types
DESCRIBE cafe_sales_cleaned;
