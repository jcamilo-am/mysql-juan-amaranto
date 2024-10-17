USE loan_manager;

-- Consultas con LEFT JOIN

-- 1. Obtener todos los clientes y sus préstamos (incluyendo clientes sin préstamos)
SELECT p.first_name, p.last_name, l.amount
FROM person p
LEFT JOIN loan l ON p.id = l.client_id;

-- 2. Obtener todos los pagos y la información de los préstamos (incluyendo pagos sin préstamo asociado)
SELECT pay.amount, l.amount AS loan_amount
FROM payment pay
LEFT JOIN loan l ON pay.loan_id = l.id;

-- 3. Obtener todos los negocios y sus direcciones (incluyendo negocios sin dirección)
SELECT b.name, a.description
FROM business b
LEFT JOIN address a ON b.address_id = a.id;

-- 4. Obtener todos los validadores de pagos y sus comentarios (incluyendo validadores sin comentarios)
SELECT p.first_name, p.last_name, pv.comment
FROM person p
LEFT JOIN payment_validation pv ON p.id = pv.administrator_id;

-- 5. Obtener todos los cobradores y los pagos que han manejado (incluyendo cobradores sin pagos)
SELECT p.first_name, p.last_name, pay.amount
FROM payment_collector pc
LEFT JOIN payment pay ON pc.payment_id = pay.id
LEFT JOIN person p ON pc.collector_id = p.id;

-- Consultas con RIGHT JOIN

-- 6. Obtener todos los préstamos y sus garantes (incluyendo préstamos sin garantes)
SELECT l.amount, p.first_name AS client_name, pg.first_name AS guarantor_name
FROM loan l
RIGHT JOIN person pg ON l.guarantor_id = pg.id
LEFT JOIN person p ON l.client_id = p.id;

-- 7. Obtener todas las garantías y la información de los préstamos (incluyendo garantías sin préstamos)
SELECT g.type, g.description, l.amount
FROM guarantee g
RIGHT JOIN loan l ON g.loan_id = l.id;

-- 8. Obtener todos los pagos y sus validaciones (incluyendo validaciones sin pagos)
SELECT pay.amount, pv.comment
FROM payment pay
RIGHT JOIN payment_validation pv ON pay.id = pv.payment_id;

-- Consulta con CROSS JOIN

-- 9. Obtener todas las combinaciones de personas y negocios
SELECT p.first_name, b.name
FROM person p
CROSS JOIN business b;

-- 10. Obtener todas las combinaciones de préstamos y garantías
SELECT l.amount AS loan_amount, g.type
FROM loan l
CROSS JOIN guarantee g;
