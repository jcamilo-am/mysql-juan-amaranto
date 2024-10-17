USE loan_manager;

-- Insertar direcciones
INSERT INTO address (municipality, neighborhood, avenue, street, description) VALUES
('Bogotá', 'Chapinero', 'Carrera 13', 'Calle 57', 'Cerca del parque de la 93'),
('Medellín', 'El Poblado', 'Avenida El Poblado', 'Calle 10', 'Zona comercial'),
('Cali', 'Granada', 'Carrera 5', 'Calle 15', 'Zona residencial'),
('Barranquilla', 'El Prado', 'Carrera 50', 'Calle 70', 'Zona histórica');

-- Insertar roles
INSERT INTO `role` (`role`) VALUES
('User'),
('Client'),
('Guarantor'),
('Collector'),
('Administrator');

-- Insertar personas
INSERT INTO person (first_name, last_name, document, gender, phone, mail, date_birth, role_id, address_id, user_name, password, salary, date_hiring) VALUES
('Juan', 'Pérez', '1234567890', 'Male','3001234567', 'juan.perez@example.com', '1985-06-15', 2, 1, 'juanp', 'pass123', 1500.00, '2020-01-10'),
('María', 'Gómez', '0987654321', 'Female', '3109876543', 'maria.gomez@example.com', '1990-08-20', 1, 2, 'mariag', 'pass456', NULL, NULL),
('Carlos', 'López', '1231231234', 'Male', '3205551212', 'carlos.lopez@example.com', '1980-04-10', 3, 3, 'carlosl', 'pass789', NULL, NULL),
('Ana', 'Martínez', '3213213210', 'Female', '3304445656', 'ana.martinez@example.com', '1975-11-30', 4, 4, 'anam', 'pass321', NULL, NULL),
('Javier', 'Sánchez', '4564564567', 'Male', '3403337878', 'javier.sanchez@example.com', '1995-03-15', 5, 1, 'javiers', 'pass654', NULL, '2022-02-15');

-- Insertar negocios
INSERT INTO business (name, description, phone, address_id, legal_status, nit) VALUES
('Negocio A', 'Venta de productos electrónicos', '3101234567', 1, 'Formal', '900123456'),
('Negocio B', 'Servicios de limpieza', '3119876543', 2, 'Informal', NULL),
('Negocio C', 'Comida rápida', '3123456789', 3, 'Formal', '900654321');

-- Insertar préstamos
INSERT INTO loan (client_id, guarantor_id, amount, interest, start_date, end_date, payment_frequency, status, type) VALUES
(1, 3, 500000, 12.50, '2024-01-01', '2024-12-31', 'Monthly', 'Completed', 'Original'),
(2, NULL, 250000, 10.00, '2024-02-01', '2024-11-01', 'Weekly', 'Asset', 'Original'),
(1, 2, 150000, 15.00, '2024-03-01', '2025-03-01', 'Biweekly', 'Overdue', 'Refinanced');

-- Insertar garantías
INSERT INTO guarantee (loan_id, type, description, estimated_value) VALUES
(1, 'Property', 'Casa en Chapinero', 300000),
(3, 'Vehicle', 'Automóvil Toyota', 20000);

-- Insertar pagos
INSERT INTO payment (amount, date, status, loan_id) VALUES
(50000, '2024-02-01', 'Completed', 1),
(25000, '2024-04-01', 'Pending', 2),
(75000, '2024-03-15', 'Failed', 3);

-- Insertar validaciones de pago
INSERT INTO payment_validation (payment_id, administrator_id, date_validation, comment) VALUES
(1, 5, '2024-02-05', 'Pago verificado'),
(2, 5, '2024-04-05', 'Pago pendiente por revisión');

-- Insertar cobradores de pago
INSERT INTO payment_collector (payment_id, collector_id) VALUES
(1, 4),
(2, 4);
