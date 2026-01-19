INSERT INTO Day1_Data_Cleaning VALUES
('P0002','Product 2','Electronics',750,20,750);

INSERT INTO Day1_Data_Cleaning VALUES
('P0003','Product 3','Food',120,50,120);

INSERT INTO Day1_Data_Cleaning VALUES
('P0004','Product 4','Furniture',1500,5,1500);

INSERT INTO Day1_Data_Cleaning VALUES
('P0005','Product 5','Stationary',45,200,45);

INSERT INTO Day1_Data_Cleaning VALUES
('P0006','Product 6','Clothing',399,30,399);

INSERT INTO Day1_Data_Cleaning VALUES
('P0007','Product 7','Electronics',999,15,999);

INSERT INTO Day1_Data_Cleaning VALUES
('P0008','Product 8','Food',220,80,220);

INSERT INTO Day1_Data_Cleaning VALUES
('P0009','Product 9','Furniture',850,7,850);

INSERT INTO Day1_Data_Cleaning VALUES
('P0010','Product 10','Stationary',60,150,60);

Total rows checkSELECT COUNT(*) AS total_rows
FROM Day1_Data_Cleaning;

SELECT COUNT(*) AS total_rows
FROM Day1_Data_Cleaning;

SELECT *
FROM Day1_Data_Cleaning
FETCH FIRST 5 ROWS ONLY;
 WHERE – Filtering
SELECT *
FROM Day1_Data_Cleaning
WHERE category = 'Clothing';

ORDER BY – Sorting (price high to low)
SELECT *
FROM Day1_Data_Cleaning
ORDER BY price DESC;

GROUP BY – Aggregations
SELECT 
    category,
    COUNT(*) AS total_products,
    AVG(price) AS avg_price,
    SUM(price) AS total_price
FROM Day1_Data_Cleaning
GROUP BY category;

HAVING – Group filter
SELECT 
    category,
    AVG(price) AS avg_price
FROM Day1_Data_Cleaning
GROUP BY category
HAVING AVG(price) > 500;

BETWEEN – Range filtering
SELECT *
FROM Day1_Data_Cleaning
WHERE price BETWEEN 300 AND 800;

