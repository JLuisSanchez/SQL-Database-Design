/* ROLE, USERS AND PRIVILEGES CREATION */


/* Creación de roles */
CREATE ROLE 'admin_store_role';
CREATE ROLE 'read_store_role';
CREATE ROLE 'write_store_role';

/* Agregar permisos a los roles */
GRANT ALL PRIVILEGES ON store.* TO 'admin_store_role';
GRANT SELECT ON store.* TO 'read_store_role';
GRANT SELECT, INSERT ON store.* TO 'write_store_role';

/* Creación de cuentas de usuario */
CREATE USER "admin"@"localhost" IDENTIFIED BY "adm2020";
CREATE USER "arturo_torres"@"localhost" IDENTIFIED BY "arturoZXC123";
CREATE USER "jose_ibarra"@"localhost" IDENTIFIED BY "josestoredb";
CREATE USER "andrea_rodriguez"@"localhost" IDENTIFIED BY "adi1989";

/* Asignar roles a los usuarios */
GRANT 'admin_store_role' TO "admin"@"localhost";
GRANT 'read_store_role' TO "arturo_torres"@"localhost";
GRANT 'write_store_role' TO "jose_ibarra"@"localhost";
GRANT 'write_store_role' TO "andrea_rodriguez"@"localhost";

/* Aplicar los roles a los usuarios */
SET DEFAULT ROLE ALL TO "admin"@"localhost";
SET DEFAULT ROLE ALL TO "arturo_torres"@"localhost";
SET DEFAULT ROLE ALL TO "jose_ibarra"@"localhost";
SET DEFAULT ROLE ALL TO "andrea_rodriguez"@"localhost";

/* Eliminar permiso SELECT del rol write_store_role */
REVOKE SELECT ON store.* FROM write_store_role;

START TRANSACTION; /* Ejemplo de una transacción */

INSERT INTO customer (id, first_name, last_name, email, password, address, phone)
VALUES (126, "Miguel", "Rodríguez", "miguel.rod@gmail.com", "123asd", "Río Santiago #435, col. Arboledas", "4774890981");

SELECT * FROM customer WHERE id = 126;

INSERT INTO payment_method (id, type_method, customer_id) /* Generar un error con un campo customer_id inexistente */
VALUES (245, "card", 1268);

ROLLBACK;

START TRANSACTION;

INSERT INTO customer (id, first_name, last_name, email, password, address, phone)
VALUES (126, "Miguel", "Rodríguez", "miguel.rod@gmail.com", "123asd", "Río Santiago #435, col. Arboledas", "4774890981");

SELECT * FROM customer WHERE id = 126;

INSERT INTO payment_method (id, type_method, customer_id) /* Generar un error con un campo customer_id inexistente */
VALUES (245, "card", 126);

COMMIT;