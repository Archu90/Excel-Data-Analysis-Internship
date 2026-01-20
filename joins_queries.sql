CREATE TABLE ORDERS (
    OrderID NUMBER PRIMARY KEY,
    ProductCode VARCHAR2(20),
    Quantity NUMBER
);

INSERT INTO Orderss VALUES (1, 'P0001', 2);
INSERT INTO Orderss VALUES (2, 'P0003', 1);
INSERT INTO Orderss VALUES (3, 'P0005', 4);
COMMIT;

SELECT 
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    (p.price * o.quantity) AS total_amount
FROM DAY1_DATA_CLEANING p
INNER JOIN Orders o
ON p.product_code = o.productcode;

SELECT 
    p.product_name,
    p.stock
FROM DAY1_DATA_CLEANING p
LEFT JOIN Orders o
ON p.product_code = o.productcode
WHERE o.productcode IS NULL;
