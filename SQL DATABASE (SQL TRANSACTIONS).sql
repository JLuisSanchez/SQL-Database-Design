/* SQL TRANSACTIONS */ 

START TRANSACTION; 

SELECT * FROM customer WHERE id = 548;

SELECT * FROM payment_method WHERE customer_id = 548;

INSERT INTO purchase_order(id, payment_method_id, customer_id)
VALUES (266, 185, 548);

SELECT * FROM purchase_order WHERE id = 266;

SELECT * FROM product WHERE id = 317;

INSERT INTO purchase_order_detail(id, amount, price_per_unit, product_description, product_id, purchase_order_id, product_name)
VALUES (267, 5, 8890, "Tamaño de pantalla real 57.5' x 33.3'", 555, 266666, "Pantalla smart TV 50'");

ROLLBACK;

SELECT * FROM purchase_order WHERE id = 266;

START TRANSACTION; 

INSERT INTO purchase_order(id, payment_method_id, customer_id)
VALUES (266, 185, 548);

SELECT * FROM purchase_order WHERE id = 266;

INSERT INTO purchase_order_detail (id, amount, price_per_unit, product_description, product_id, purchase_order_id, product_name)
VALUES (267, 5, 8890, "Tamaño de pantalla real 57.5' x 33.3'", 317, 266666, "Pantalla smart TV 50'");

COMMIT;
