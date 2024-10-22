-- IN

-- 1. Encontrar todos los clientes que tienen préstamos asociados.
SELECT first_name, last_name
FROM person
WHERE id IN (SELECT client_id FROM loan);

-- 2. Mostrar los cobradores que tienen alguna ruta asignada.
SELECT first_name, last_name
FROM person
WHERE id IN (SELECT collector_id FROM route);

-- 3. Mostrar los clientes cuyo préstamo ha sido aprobado.
SELECT first_name, last_name
FROM person
WHERE id IN (SELECT client_id FROM loan WHERE status_id IN (SELECT id FROM status WHERE status = 'Aprobado'));

-- 4. Encontrar las garantías relacionadas con préstamos cuyo cliente sea "María Gómez".
SELECT description, estimated_value
FROM guarantee
WHERE loan_id IN (SELECT id FROM loan WHERE client_id IN (SELECT id FROM person WHERE first_name = 'María' AND last_name = 'Gómez'));

-- 5. Listar las notificaciones enviadas a usuarios que son administradores.
SELECT message, type_id
FROM notification
WHERE user_id IN (SELECT id FROM user WHERE id IN (SELECT user_id FROM user_role WHERE role_id = (SELECT id FROM role WHERE role = 'Administrador')));

-- ANY

-- 6. Listar los clientes cuyo teléfono coincide con algún teléfono registrado en la base de datos.
SELECT first_name, last_name
FROM person
WHERE phone = ANY (SELECT phone FROM person);

-- 7. Encontrar los préstamos cuyo monto sea mayor que el monto de algún préstamo otorgado a Carlos López.
SELECT amount
FROM loan
WHERE amount > ANY (SELECT amount FROM loan WHERE client_id = (SELECT id FROM person WHERE first_name = 'Carlos' AND last_name = 'López'));

-- 8. Encontrar los préstamos que tienen una tasa de interés menor que cualquier préstamo de "Juan Pérez".
SELECT amount, interest
FROM loan
WHERE interest < ANY (SELECT interest FROM loan WHERE client_id = (SELECT id FROM person WHERE first_name = 'Juan' AND last_name = 'Pérez'));

-- 9. Mostrar todos los préstamos cuyo monto es mayor que cualquier garantía registrada.
SELECT amount
FROM loan
WHERE amount > ANY (SELECT estimated_value FROM guarantee);

-- 10. Encontrar los usuarios cuyo salario es menor que el de algún administrador.
SELECT first_name, last_name
FROM person
WHERE salary < ANY (SELECT salary FROM person WHERE id IN (SELECT person_id FROM user_role WHERE role_id = (SELECT id FROM role WHERE role = 'Administrador')));

-- ALL

-- 11. Listar los préstamos que tienen un monto mayor que todas las garantías registradas.
SELECT amount
FROM loan
WHERE amount > ALL (SELECT estimated_value FROM guarantee);

-- 12. Mostrar los préstamos que tienen una tasa de interés mayor que todos los préstamos de "María Gómez".
SELECT amount, interest
FROM loan
WHERE interest > ALL (SELECT interest FROM loan WHERE client_id = (SELECT id FROM person WHERE first_name = 'María' AND last_name = 'Gómez'));

-- 13. Encontrar todos los cobradores que ganan más que todos los administradores.
SELECT first_name, last_name
FROM person
WHERE salary > ALL (SELECT salary FROM person WHERE id IN (SELECT person_id FROM user_role WHERE role_id = (SELECT id FROM role WHERE role = 'Administrador')))
AND id IN (SELECT person_id FROM user_role WHERE role_id = (SELECT id FROM role WHERE role = 'Cobrador'));

-- 14. Encontrar los clientes cuyo teléfono es diferente de todos los teléfonos de los fiadores.
SELECT first_name, last_name
FROM person
WHERE phone <> ALL (SELECT phone FROM person WHERE id IN (SELECT person_id FROM user_role WHERE role_id = (SELECT id FROM role WHERE role = 'Fiador')));

-- 15. Mostrar los clientes cuyo préstamo es mayor que todos los préstamos de "Carlos López".
SELECT first_name, last_name
FROM person
WHERE id IN (SELECT client_id FROM loan WHERE amount > ALL (SELECT amount FROM loan WHERE client_id = (SELECT id FROM person WHERE first_name = 'Carlos' AND last_name = 'López')));


-- EXISTS

-- 16. Mostrar los clientes que tienen al menos un préstamo.
SELECT first_name, last_name
FROM person
WHERE EXISTS (SELECT 1 FROM loan WHERE client_id = person.id);

-- 17. Listar todos los cobradores que tienen rutas asignadas.
SELECT first_name, last_name
FROM person
WHERE EXISTS (SELECT 1 FROM route WHERE collector_id = person.id);

-- 18. Encontrar los administradores que validaron algún pago.
SELECT first_name, last_name
FROM person
WHERE EXISTS (SELECT 1 FROM payment_validation WHERE administrator_id = person.id);

-- 19. Mostrar todos los préstamos que tienen pagos asociados.
SELECT amount, start_date, end_date
FROM loan
WHERE EXISTS (SELECT 1 FROM payment WHERE loan_id = loan.id);

-- 20. Listar los clientes que han recibido notificaciones.
SELECT first_name, last_name
FROM person
WHERE EXISTS (SELECT 1 FROM notification WHERE user_id = (SELECT id FROM user WHERE person_id = person.id));
