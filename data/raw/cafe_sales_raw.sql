SELECT * FROM cafe_sales_raw;

SELECT 
COUNT(*) AS Total_rows,
SUM(`transaction id` is NULL OR `transaction id`= '') As MISSING_TRANSACTION_IDs,
SUM(`ITEM` IS NULL OR `ITEM` = '') AS MISSING_ITEMS,
SUM(`QUANTITY` IS NULL OR `Quantity` = '') AS MISSING_QUANTITY_VALUE,
SUM(`PRICE PER UNIT` IS NULL OR `PRICE PER UNIT` = '') AS MISSING_PricePerUnit,
SUM(`TOTAL SPENT` IS NULL OR `PRICE PER UNIT` = '') AS MISSING_TOTAL_SPENT,
SUM(`Payment Method`IS NULL OR `Payment Method`= '') AS MISSING_PAYMENT_METHOD,
SUM(`Location` IS NULL OR `Location` = '') AS MISSING_LOCATION,
SUM(`Transaction date` IS NULL OR `Transaction date`= '') AS MISSING_TransactionDate
FROM cafe_sales_raw;

SELECT * FROM cafe_sales_raw 
WHERE ITEM IS NULL
OR ITEM = '' ;

SELECT * FROM cafe_sales_raw
WHERE `PAYMENT METHOD`IS NULL
OR `PAYMENT METHOD` = '' ;

SELECT * FROM cafe_sales_raw
WHERE `Location` IS NULL
OR `Location` = '' ;

SELECT * FROM cafe_sales_raw
WHERE `TRANSACTION DATE` IS NULL
OR `TRANSACTION DATE` = '' ;

SELECT 
COUNT(*) AS INCOMPLETE_ROWS
FROM cafe_sales_raw
WHERE 
`item` IS NULL OR `item` = '' 
OR `Payment Method` IS NULL OR `Payment Method` = ''
OR `Location` IS NULL OR `LOCATION` = ''
OR `Transaction Date` IS NULL OR `Transaction Date`	= '' ;

SELECT * FROM cafe_sales_raw
WHERE 
(`Item` IS NULL OR `ITEM` = '')
AND(`payment method` IS NULL OR `Payment Method` = '')
AND(`LOCATION` IS NULL OR `LOCATION` = '')
AND(`Transaction Date` IS NULL OR `Transaction Date` = '');

SELECT
 `item`, 
 COUNT(*) AS Frequency
 FROM CAFE_SALES_RAW
 GROUP BY `item`
 ORDER BY Frequency DESC;
 
SELECT
`Payment method`,
 COUNT(*) AS Frequency
 FROM cafe_sales_raw
 GROUP BY `Payment method`
 ORDER BY Frequency DESC;
 
 SELECT
 `Location`,
 COUNT(*) AS Frequency
 FROM cafe_sales_raw
 GROUP BY  `Location`
 ORDER BY Frequency DESC;
 
 SELECT `Transaction Date`,
 COUNT(*) AS Frequency
 FROM cafe_sales_raw
 GROUP BY `Transaction Date`
 ORDER BY Frequency DESC;
 
-- checking if there is any duplicate in transaction id 
SELECT `Transaction Id`,
COUNT(*) AS Frequency
FROM cafe_sales_raw
GROUP BY `Transaction Id`
HAVING COUNT(*) > 1;

DESCRIBE cafe_sales_raw;
-- TOTAL SPENT SHOULD BE NUMERIC Data Type
-- TRANSACTION DATE SHOULD BE DATE Data Type

-- Before changing the data types we need to make sure Total Spent does Not contain values like ERROR, UNKNOWN, or blanks that would prevent conversion
SELECT `Total Spent`,
COUNT(*) AS Frequency
FROM cafe_sales_raw
GROUP BY `Total Spent`
ORDER BY Frequency DESC;

-- Before cleaning them we will see whether the actual numbers look consistent
SELECT `Total Spent`,
COUNT(*) AS Frequency
FROM cafe_sales_raw
WHERE `Total Spent` NOT IN('','ERROR','UNKNOWN')
GROUP BY `Total Spent`
ORDER BY `Total Spent`;

-- INSPECTING 
SELECT `Quantity`, `price per unit`, `Total Spent`
FROM cafe_sales_raw
WHERE `Total Spent` NOT IN ('ERROR' , '' , 'UNKNOWN')
LIMIT 20;

-- NOW FINDING INCORRECT TOTAL SPENT VALUE 
SELECT `Transaction ID`, `Quantity`,`price per unit`, `Total Spent`,
(`Quantity` * `price per unit`) AS expected_total
FROM cafe_sales_raw
WHERE `Total Spent` NOT IN ('ERROR', '' ,'UNKNOWN')
AND (`Total Spent` + 0)<>(`Quantity` * `Price Per Unit`);
