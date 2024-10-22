USE loan_manager;

-- Insertar datos en la tabla address
INSERT INTO address (municipality, neighborhood, avenue, street, description) 
VALUES 
('Bogotá', 'Chapinero', 'Avenida Caracas', 'Calle 72', 'Oficina principal'),
('Medellín', 'El Poblado', NULL, 'Calle 10', 'Sucursal en zona comercial'),
('Cali', 'San Fernando', 'Avenida Roosevelt', NULL, 'Oficina central'),
('Barranquilla', 'Alto Prado', NULL, 'Calle 76', 'Sucursal norte');

-- Insertar datos en la tabla role
INSERT INTO role (role) 
VALUES 
('Cliente'),
('Fiador'),
('Cobrador'),
('Administrador'),
('Cobrador Afiliado');

-- Insertar datos en la tabla person
INSERT INTO person (first_name, last_name, document, gender, phone, date_birth, address_id, salary, commission_percentage) 
VALUES 
('Juan', 'Pérez', '1234567890', 'Male', '3001234567', '1985-05-10', 1, 3000.00, 10.00),
('María', 'Gómez', '0987654321', 'Female', '3009876543', '1990-07-15', 2, 3500.00, NULL),
('Carlos', 'López', '5678901234', 'Male', '3112345678', '1980-03-12', 3, NULL, 15.00),
('Ana', 'Ramírez', '4321098765', 'Female', '3012345678', '1995-11-20', 4, 2500.00, NULL);

-- Insertar datos en la tabla user
INSERT INTO user (user_name, mail, password, person_id) 
VALUES 
('juanp', 'juan.perez@example.com', 'password123', 1),
('mariag', 'maria.gomez@example.com', 'password456', 2),
('carlosl', 'carlos.lopez@example.com', 'password789', 3),
('anar', 'ana.ramirez@example.com', 'password012', 4);

-- Insertar datos en la tabla user_role
INSERT INTO user_role (user_id, role_id) 
VALUES 
(1, 1),  -- Juan Pérez es Cliente
(2, 1),  -- María Gómez es Cliente
(3, 3),  -- Carlos López es Cobrador
(4, 4);  -- Ana Ramírez es Administradora

-- Insertar datos en la tabla permission
INSERT INTO permission (permission_name) 
VALUES 
('create_loan'),
('view_reports'),
('validate_payment'),
('manage_users');

-- Insertar datos en la tabla role_permission
INSERT INTO role_permission (role_id, permission_id) 
VALUES 
(4, 1), -- Administrador puede crear préstamos
(4, 2), -- Administrador puede ver reportes
(4, 3), -- Administrador puede validar pagos
(4, 4); -- Administrador puede gestionar usuarios

-- Insertar datos en la tabla route
INSERT INTO route (client_id, collector_id) 
VALUES 
(1, 3), -- Juan Pérez es cliente de Carlos López
(2, 3); -- María Gómez es cliente de Carlos López

-- Insertar datos en la tabla audit_log
INSERT INTO audit_log (user_id, action, tabla_name, record_id, old_value, new_value) 
VALUES 
(4, 'update', 'user', '1', 'juan.perez@example.com', 'juanperez@newmail.com');

-- Insertar datos en la tabla legal_status
INSERT INTO legal_status (legal_status) 
VALUES 
('Activo'),
('Inactivo'),
('En proceso judicial');

-- Insertar datos en la tabla business
INSERT INTO business (name, description, phone, address_id, legal_status_id, nit) 
VALUES 
('Finanzas Ltda.', 'Empresa de préstamos', '3021234567', 1, 1, '9001234567'),
('Creditos Rápidos', 'Empresa de microcréditos', '3107654321', 2, 2, '9007654321');

-- Insertar datos en la tabla status
INSERT INTO status (status) 
VALUES 
('Aprobado'),
('Rechazado'),
('Pendiente');

-- Insertar datos en la tabla payment_frequency
INSERT INTO payment_frequency (frequency) 
VALUES 
('Mensual'),
('Quincenal'),
('Semanal');

-- Insertar datos en la tabla loan
INSERT INTO loan (client_id, guarantor_id, amount, interest, start_date, end_date, payment_frequency_id, status_id, type) 
VALUES 
(1, 2, 5000.00, 5.00, '2024-01-01', '2024-12-31', 1, 1, 'Original'),
(2, NULL, 3000.00, 3.00, '2024-02-01', '2024-10-31', 2, 1, 'Original');

-- Insertar datos en la tabla overdue_report
INSERT INTO overdue_report (loan_id, overdue_days, overdue_amount, report_date) 
VALUES 
(1, 15, 250.00, '2024-10-01');

-- Insertar datos en la tabla collection_schedule_status
INSERT INTO collection_schedule_status (status) 
VALUES 
('Programado'),
('Completado'),
('Cancelado');

-- Insertar datos en la tabla collection_schedule
INSERT INTO collection_schedule (collector_id, loan_id, schedule_date, status_id) 
VALUES 
(3, 1, '2024-10-15', 1);

-- Insertar datos en la tabla notification_type
INSERT INTO notification_type (type) 
VALUES 
('Recordatorio de pago'),
('Actualización de préstamo'),
('Alerta de vencimiento');

-- Insertar datos en la tabla notification
INSERT INTO notification (user_id, message, type_id) 
VALUES 
(1, 'Su pago está próximo a vencer', 3),
(2, 'Su préstamo ha sido aprobado', 2);

-- Insertar datos en la tabla guarantee_type
INSERT INTO guarantee_type (type) 
VALUES 
('Vehículo'),
('Propiedad'),
('Electrodoméstico');

-- Insertar datos en la tabla guarantee
INSERT INTO guarantee (loan_id, type_id, description, estimated_value) 
VALUES 
(1, 1, 'Carro Ford Fiesta', 8000.00),
(2, 2, 'Apartamento en Cali', 50000.00);

-- Insertar datos en la tabla payment_status
INSERT INTO payment_status (type) 
VALUES 
('Pendiente'),
('Pagado'),
('Atrasado');

-- Insertar datos en la tabla payment
INSERT INTO payment (amount, date, status_id, loan_id) 
VALUES 
(500.00, '2024-03-01', 2, 1),
(200.00, '2024-03-15', 1, 2);

-- Insertar datos en la tabla payment_validation
INSERT INTO payment_validation (payment_id, administrator_id, date_validation, comment) 
VALUES 
(1, 4, '2024-03-05', 'Pago validado correctamente');

-- Insertar datos en la tabla payment_collector
INSERT INTO payment_collector (payment_id, collector_id) 
VALUES 
(1, 3);

-- Insertar datos en la tabla payment_history
INSERT INTO payment_history (loan_id, payment_id, payment_date, amount) 
VALUES 
(1, 1, '2024-03-01', 500.00);

-- Insertar datos en la tabla debt_summary
INSERT INTO debt_summary (client_id, total_debt, last_payment_date) 
VALUES 
(1, 4500.00, '2024-03-01');

-- Insertar datos en la tabla financial_report
INSERT INTO financial_report (total_loans, total_payments, report_date) 
VALUES 
(8000.00, 700.00, '2024-10-01');