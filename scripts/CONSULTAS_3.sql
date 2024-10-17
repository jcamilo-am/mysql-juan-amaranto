-- 1. Obtener los nombres de los clientes y sus direcciones
SELECT p.first_name, p.last_name, a.description
FROM person p
INNER JOIN address a ON p.address_id = a.id;

-- 2. Obtener los préstamos junto con los nombres de los clientes
SELECT l.amount, p.first_name, p.last_name
FROM loan l
INNER JOIN person p ON l.client_id = p.id;

-- 3. Obtener los pagos y la información del préstamo
SELECT pay.amount, l.amount AS loan_amount
FROM payment pay
INNER JOIN loan l ON pay.loan_id = l.id;

-- 4. Obtener los negocios y sus direcciones
SELECT b.name, a.description
FROM business b
INNER JOIN address a ON b.address_id = a.id;

-- 5. Obtener las garantías y la información del préstamo correspondiente
SELECT g.type, g.description, l.amount
FROM guarantee g
INNER JOIN loan l ON g.loan_id = l.id;

-- 6. Obtener los validadores de pagos y su información
SELECT pv.comment, p.first_name, p.last_name
FROM payment_validation pv
INNER JOIN person p ON pv.administrator_id = p.id;

-- 7. Obtener los cobradores y los pagos que han manejado
SELECT p.first_name, p.last_name, pay.amount
FROM payment_collector pc
INNER JOIN payment pay ON pc.payment_id = pay.id
INNER JOIN person p ON pc.collector_id = p.id;

-- 8. Obtener información de los préstamos con sus garantes
SELECT l.amount, p.first_name AS client_name, pg.first_name AS guarantor_name
FROM loan l
INNER JOIN person p ON l.client_id = p.id
LEFT JOIN person pg ON l.guarantor_id = pg.id;

-- 9. Obtener los pagos de los préstamos que están pendientes
SELECT pay.amount, l.status
FROM payment pay
INNER JOIN loan l ON pay.loan_id = l.id
WHERE pay.status = 'Pending';

-- 10. Obtener el total de préstamos por cliente
SELECT p.first_name, p.last_name, COUNT(l.id) AS total_loans
FROM person p
INNER JOIN loan l ON p.id = l.client_id
GROUP BY p.id;