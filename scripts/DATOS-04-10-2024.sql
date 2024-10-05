USE loan_manager;

-- Insertar datos en la tabla address
INSERT INTO address (neighborhood, avenue, street, description) VALUES
('Los Cedros', 'Av. 1', 'Calle 5', 'Barrio residencial con zonas verdes'),
('El Centro', 'Calle 2', 'Calle 10', 'Zona comercial con alta afluencia'),
('La Loma', 'Av. 3', 'Calle 12', 'Barrio tranquilo con vista a la montaña');

-- Insertar datos en la tabla people
INSERT INTO people (first_name, last_name, document, phone, email, address_id, user_name, password, role) VALUES
('Juan', 'Pérez', '123456789', '3216549870', 'juan.perez@email.com', 1, 'juanp', 'password123', 'Cliente'),
('María', 'Gómez', '987654321', '3101234567', 'maria.gomez@email.com', 2, 'mariag', 'password456', 'Cobrador'),
('Luis', 'Rodríguez', '456123789', '3009876543', 'luis.rodriguez@email.com', 3, 'luisr', 'password789', 'Administrador');

-- Insertar datos en la tabla business
INSERT INTO business (name, phone, description, owner_id, owner_name, address_id, legal_status) VALUES
('Panadería Mocoa', '3112345678', 'Panadería artesanal con variedad de productos', 1, 'Juan Pérez', 1, 'Formal'),
('Restaurante La Montaña', '3145678901', 'Restaurante típico con platos locales', 2, 'María Gómez', 2, 'Registered'),
('Ferretería El Progreso', '3156789012', 'Ferretería con todo tipo de herramientas', 3, 'Luis Rodríguez', 3, 'Informal');

-- Insertar datos en la tabla employment
INSERT INTO employment (description, employee_id, business_id) VALUES
('Panadero con experiencia de 5 años', 1, 1),
('Mesera con excelente atención al cliente', 2, 2),
('Vendedor de herramientas y asesor', 3, 3);

-- Insertar datos en la tabla loan
INSERT INTO loan (client_id, guarantor_id, amount, interest_rate, start_date, end_date, payment_amount, payment_frequency, balance, previous_loan_id, type, status) VALUES
(1, NULL, 5000000.00, 10.5, '2023-01-01', '2024-01-01', 500000.00, 'Monthly', 5000000.00, NULL, 0, 'Active'),
(2, 1, 3000000.00, 12.0, '2023-02-01', '2024-02-01', 300000.00, 'Biweekly', 3000000.00, NULL, 0, 'Active'),
(3, NULL, 10000000.00, 9.5, '2023-03-01', '2024-03-01', 1000000.00, 'Monthly', 10000000.00, NULL, 0, 'Active');

-- Insertar datos en la tabla payment
INSERT INTO payment (loan_id, amount, date) VALUES
(1, 500000.00, '2023-02-01'),
(2, 300000.00, '2023-03-15'),
(3, 1000000.00, '2023-04-01');

-- Insertar datos en la tabla guarantee
INSERT INTO guarantee (loan_id, type, value, description, registration_date) VALUES
(1, 'Prenda', 2000000.00, 'Vehículo de propiedad del prestatario', '2023-01-01'),
(2, 'Hipoteca', 1000000.00, 'Casa de propiedad del prestatario', '2023-02-01'),
(3, 'Fiador', 5000000.00, 'Fiador solidario', '2023-03-01');

-- Insertar datos en la tabla loan_collector
INSERT INTO loan_collector (collector_id, loan_id, collection_date) VALUES
(2, 1, '2023-02-05'),
(1, 2, '2023-03-20'),
(3, 3, '2023-04-15');