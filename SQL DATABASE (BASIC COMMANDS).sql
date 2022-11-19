/* DATABASE CREATION (DATABASE, TABLE, FIELDS, FOREIGN KEY, INSERT INTO, VALUES) */

CREATE DATABASE store;

USE store;
CREATE TABLE store(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NULL
);

CREATE TABLE product(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
price DOUBLE NOT NULL,
description VARCHAR(150) NULL
);

ALTER TABLE product
ADD store_id INT NOT NULL;

DESCRIBE product;

ALTER TABLE product
ADD CONSTRAINT fk_store_product
FOREIGN KEY (store_id) REFERENCES store(id);

USE store;
CREATE TABLE customer (
id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
address VARCHAR(50) NULL,
phone VARCHAR(10) NULL
);

CREATE TABLE payment_method (
id INT NOT NULL PRIMARY KEY,
type_method VARCHAR(50) NOT NULL
);

ALTER TABLE payment_method
ADD customer_id INT NOT NULL;

ALTER TABLE payment_method
ADD CONSTRAINT fk_customer_payment_method
FOREIGN KEY (customer_id) REFERENCES customer(id);

CREATE TABLE purchase_order(
id INT NOT NULL PRIMARY KEY,
payment_method_id INT NOT NULL,
customer_id INT NOT NULL
);

CREATE TABLE purchase_order_detail(
id INT NOT NULL PRIMARY KEY,
amount INT NOT NULL,
price_per_unit DOUBLE NOT NULL,
product_description VARCHAR(150) NULL,
product_id INT NOT NULL,
purchase_order_id INT NOT NULL
);

ALTER TABLE purchase_order
ADD CONSTRAINT fk_customer_purchase_order
FOREIGN KEY (customer_id) REFERENCES customer(id);

ALTER TABLE purchase_order
ADD CONSTRAINT fk_payment_method_purchase_order
FOREIGN KEY (payment_method_id) REFERENCES payment_method(id);

ALTER TABLE purchase_order_detail
ADD CONSTRAINT fk_purchase_order_purchase_order_detail
FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id);

ALTER TABLE purchase_order_detail
ADD CONSTRAINT fk_product_purchase_order_detail
FOREIGN KEY (product_id) REFERENCES product(id);

/* Añadir datos a la tabla store */
ALTER TABLE purchase_order_detail
ADD product_name VARCHAR(100) NOT NULL;

INSERT INTO store(id, name, address)
VALUES (459,"Electronic Technologies North", "Blvd. López Mateos #459");

INSERT INTO store(id, name, address)
VALUES (346, "Electronic Technologies Central", "Av. Insurgentes #346");

/* Añadir registros a tabla product */
INSERT INTO product (id, name, price, description, store_id)
VALUES (301, "Computadora de escritorio - Todo en uno", 15499.00, "Todo lo que necesitas para este regreso a clases.", 549);

INSERT INTO product (id, name, price, description, store_id)
VALUES (305, "Celular ET - 15a", 3590.00, "Ideal para el trabajo", 549);

INSERT INTO product (id, name, price, description, store_id)
VALUES (310, "Laptop - Quinta generación", 9099.00, "Económica pero duradera, simplemente lo mejor del año.", 549);

/* Edición del registro en la tabla product */
UPDATE product
SET name = "Celular ET2019 - 19xs", description = "Ideal para el trabajo y la escuela."
WHERE id = 305;

UPDATE product
SET description = "Todo lo que buscas en una computadora de escritorio"
WHERE id = 301;

UPDATE product
SET price = 9999.00
WHERE id = 310;

/* Eliminacion de registros "Celular ET2019 - 19xs" de la tabla product*/
DELETE FROM product
WHERE id = 305;

/* Consulta de registros */
SELECT *
FROM store;

SELECT name, price, description
FROM product;

/* Registro de nuevos productos */
INSERT INTO product (id, name, price, description, store_id)
VALUES (611, "Horno tostador", 1499.00, "Horno tostador de 4 rebanadas, acero inoxidable.", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (512, "Freidora con temporizador", 1590.00, "Puede cocinar cualquier alimento, desde papas fritas hasta verduras y mucho más.", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (815, "Batidora", 999.00, "5 velocidades, color rojo", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (531, "Fuente de chocolate", 789.90, "Mejora la limpieza gracias a sus piezas desmontables.", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (912, "Máquina de palomitas de maiz", 830.00, "La máquina ocupa aceite caliente para la elaboración de las palomitas.", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (412, "Sandwichera", 459.00, "Sandwichera para desayuno, color gris", 346);

INSERT INTO product (id, name, price, description, store_id)
VALUES (317, "Pantalla smart TV 50'", 8890.00, "Tamaño de pantalla real 57.5' x 33.3'", 459);

INSERT INTO product (id, name, price, description, store_id)
VALUES (679, "Cámara de seguridad", 1497.00, "Incluye soporte técnico 24/7.", 459);

INSERT INTO product (id, name, price, description, store_id)
VALUES (923, "Soporte para TV", 279.00, "Adaptable a pantalla de 26'-65', hasta 50 kg de carga.", 459);

INSERT INTO product (id, name, price, description, store_id)
VALUES (873, "Laptop 1945", 15499.00, "Unidad de estado sólido de 256 GB y memoria RAM de 8 GB.", 459);

INSERT INTO product (id, name, price, description, store_id)
VALUES (682, "Coche estéreo GPS - Navegación", 1299.00, "Pantalla táctil, conexión bluetooth, no incluye DVD.", 459);

/* Ordenar los productos por precio del menor al mayor */
SELECT *
FROM product
ORDER BY price ASC;

/* Ordenar los productos por precio del mayor al menor */
SELECT *
FROM product
ORDER BY price DESC;

/* Uso de restringir datos - Obtener los primeros 5 registros de la tabla product */
SELECT *
FROM product
LIMIT 5;

/* Uso de restringir datos - Obtener 5 registros omitiendo los 3 primeros registros */
SELECT *
FROM product
LIMIT 3,5;

/* Agrupar datos por sucursal y uso de COUNT */
SELECT store_id, COUNT(*)
FROM product
GROUP BY store_id; 

/* Insertar una nueva tienda en la base de datos */
INSERT INTO store(id, name, address)
VALUES (111, "Sucursal", "Blvd Obregón #423");

/* Realizar una intersección entre 2 tablas con INNER JOIN */
SELECT *
FROM store
INNER JOIN product ON store.id = product.store_id;

/* Buscar coincidencias de la tabla izquierda con los registros de la tabla derecha */
SELECT *
FROM store 
LEFT JOIN product ON store.id = product.store_id;

/* Buscar coincidencias de la tabla derecha con los registros de la tabla izquierda */
SELECT *
FROM store
RIGHT JOIN product ON store.id = product.store_id;

/* Consultas anidadas */
SELECT *
FROM store
WHERE id = (
	SELECT store_id FROM product WHERE id = 310
);

/* Generar una vista */
CREATE VIEW product_description AS 
SELECT name, description, price FROM product;
/* Consultar la vista */
SELECT * FROM product_description;

INSERT INTO purchase_order(id, payment_method_id, customer_id)
VALUES (10, 121, 103);