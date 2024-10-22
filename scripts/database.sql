-- Eliminar la base de datos si existe y crear una nueva
DROP DATABASE IF EXISTS loan_manager;
CREATE DATABASE loan_manager;
USE loan_manager;

-- Tabla para almacenar direcciones
CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la dirección
    municipality VARCHAR(255) NOT NULL,         -- Municipio
    neighborhood VARCHAR(255) NOT NULL,         -- Barrio
    avenue VARCHAR(255),                         -- Avenida
    street VARCHAR(255),                         -- Calle
    description VARCHAR(255) NOT NULL            -- Descripción adicional de la dirección
);

-- Tabla para almacenar los roles de usuario
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del rol
    role VARCHAR(255) NOT NULL                   -- Nombre del rol (Cliente, Fiador, Cobrador, Administrador, Cobrador Afiliado)
);

-- Tabla para almacenar información personal
CREATE TABLE person (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la persona
    first_name VARCHAR(255) NOT NULL,           -- Nombre
    last_name VARCHAR(255) NOT NULL,            -- Apellido
    document VARCHAR(10) NOT NULL UNIQUE,               -- Documento de identificación
    gender ENUM('Male', 'Female', 'Other'),      -- Género
    phone VARCHAR(10) NOT NULL UNIQUE,                  -- Número de teléfono
    date_birth DATE NOT NULL,                    -- Fecha de nacimiento
    address_id INT NOT NULL,                     -- ID de la dirección (referencia a address)
    salary DECIMAL(10, 2) DEFAULT NULL,         -- Salario (opcional)
    commission_percentage DECIMAL(5, 2) DEFAULT NULL, -- Porcentaje de comisión (opcional)
    FOREIGN KEY (address_id) REFERENCES address(id)  -- Llave foránea para la dirección
);

-- Tabla para almacenar usuarios
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del usuario
    user_name VARCHAR(255) UNIQUE NOT NULL,     -- Nombre de usuario único
    mail VARCHAR(255) UNIQUE NOT NULL,           -- Correo electrónico único
    password VARCHAR(255) NOT NULL,              -- Contraseña
    person_id INT NOT NULL,                      -- ID de la persona (referencia a person)
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    update_at TIMESTAMP,                         -- Fecha de última actualización
    FOREIGN KEY (person_id) REFERENCES person(id)  -- Llave foránea para la persona
);

-- Tabla para asociar usuarios con roles
CREATE TABLE user_role (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la asociación
    user_id INT NOT NULL,                        -- ID del usuario (referencia a user)
    role_id INT NOT NULL,                        -- ID del rol (referencia a role)
    FOREIGN KEY (user_id) REFERENCES user(id),  -- Llave foránea para el usuario
    FOREIGN KEY (role_id) REFERENCES role(id)   -- Llave foránea para el rol
);

-- Tabla para almacenar los permisos
CREATE TABLE permission (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del permiso
    permission_name VARCHAR(255) NOT NULL        -- Nombre del permiso (e.g., "create_loan", "view_reports")
);

-- Tabla para asociar roles con permisos
CREATE TABLE role_permission (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la asociación
    role_id INT NOT NULL,                        -- ID del rol (referencia a role)
    permission_id INT NOT NULL,                  -- ID del permiso (referencia a permission)
    FOREIGN KEY (role_id) REFERENCES role(id),  -- Llave foránea para el rol
    FOREIGN KEY (permission_id) REFERENCES permission(id) -- Llave foránea para el permiso
);

-- Tabla para almacenar rutas de cobradores y clientes
CREATE TABLE route (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la ruta
    client_id INT NOT NULL,                      -- ID del cliente (referencia a user)
    collector_id INT NOT NULL,                   -- ID del cobrador (referencia a user)
    FOREIGN KEY (client_id) REFERENCES user(id),  -- Llave foránea para el cliente
    FOREIGN KEY (collector_id) REFERENCES user(id) -- Llave foránea para el cobrador
);

-- Tabla para almacenar un registro de auditoría
CREATE TABLE audit_log (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del registro
    user_id INT NOT NULL,                        -- ID del usuario que realizó la acción (referencia a user)
    action VARCHAR(255) NOT NULL,                -- Acción realizada
    tabla_name VARCHAR(255) NOT NULL,            -- Nombre de la tabla afectada
    record_id VARCHAR(255) NOT NULL,             -- ID del registro afectado
    old_value TEXT,                              -- Valor antiguo (antes de la acción)
    new_value TEXT,                              -- Nuevo valor (después de la acción)
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del registro
    FOREIGN KEY (user_id) REFERENCES user(id)   -- Llave foránea para el usuario
);

-- Tabla para almacenar estados legales
CREATE TABLE legal_status (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del estado legal
    legal_status VARCHAR(255) NOT NULL           -- Descripción del estado legal
);

-- Tabla para almacenar información de negocios
CREATE TABLE business (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del negocio
    name VARCHAR(255) NOT NULL,                  -- Nombre del negocio
    description VARCHAR(255) NOT NULL,           -- Descripción del negocio
    phone VARCHAR(10) NOT NULL,                  -- Número de teléfono del negocio
    address_id INT NOT NULL,                     -- ID de la dirección (referencia a address)
    legal_status_id INT NOT NULL,                -- ID del estado legal (referencia a legal_status)
    nit VARCHAR(10),                             -- Número de identificación tributaria
    FOREIGN KEY (address_id) REFERENCES address(id),  -- Llave foránea para la dirección
    FOREIGN KEY (legal_status_id) REFERENCES legal_status(id) -- Llave foránea para el estado legal
);

-- Tabla para almacenar estados
CREATE TABLE status (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del estado
    status VARCHAR(255) NOT NULL                 -- Descripción del estado
);

-- Tabla para almacenar frecuencias de pago
CREATE TABLE payment_frequency (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la frecuencia
    frequency VARCHAR(255)                       -- Descripción de la frecuencia de pago
);

-- Tabla para almacenar información de préstamos
CREATE TABLE loan (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del préstamo
    client_id INT NOT NULL,                      -- ID del cliente (referencia a person)
    guarantor_id INT DEFAULT NULL,               -- ID del fiador (referencia a person)
    amount DECIMAL(10, 2) CHECK(amount > 0) NOT NULL, -- Monto del préstamo
    interest DECIMAL(5,2) CHECK(interest BETWEEN 0 AND 20) NOT NULL, -- Tasa de interés
    total_value DECIMAL(10, 2) AS (amount + (amount * interest / 100)) STORED NOT NULL, -- Valor total del préstamo
    start_date DATE NOT NULL,                    -- Fecha de inicio del préstamo
    end_date DATE NOT NULL,                      -- Fecha de finalización del préstamo
    payment_frequency_id INT NOT NULL,          -- ID de la frecuencia de pago (referencia a payment_frequency)
    origin_id INT DEFAULT NULL,                  -- ID del préstamo original (referencia a loan)
    status_id INT NOT NULL,                      -- ID del estado (referencia a status)
    type ENUM('Original', 'Refinanced') NOT NULL, -- Tipo de préstamo
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    update_at TIMESTAMP,                         -- Fecha de última actualización
    FOREIGN KEY (client_id) REFERENCES person(id), -- Llave foránea para el cliente
    FOREIGN KEY (guarantor_id) REFERENCES person(id), -- Llave foránea para el fiador
    FOREIGN KEY (origin_id) REFERENCES loan(id), -- Llave foránea para el préstamo original
    FOREIGN KEY (payment_frequency_id) REFERENCES payment_frequency(id), -- Llave foránea para la frecuencia de pago
    FOREIGN KEY (status_id) REFERENCES status(id) -- Llave foránea para el estado
);

-- Tabla para reportes de préstamos vencidos
CREATE TABLE overdue_report (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del reporte
    loan_id INT NOT NULL,                        -- ID del préstamo (referencia a loan)
    overdue_days INT NOT NULL,                   -- Días de atraso
    overdue_amount DECIMAL(10, 2) NOT NULL,     -- Monto en atraso
    report_date DATE NOT NULL,                   -- Fecha del reporte
    FOREIGN KEY (loan_id) REFERENCES loan(id)   -- Llave foránea para el préstamo
);

-- Tabla para almacenar estados de programación de cobro
CREATE TABLE collection_schedule_status (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del estado de programación
    status VARCHAR(255) NOT NULL                 -- Descripción del estado de programación
);

-- Tabla para almacenar programaciones de cobro
CREATE TABLE collection_schedule (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la programación
    collector_id INT NOT NULL,                   -- ID del cobrador (referencia a user)
    loan_id INT NOT NULL,                        -- ID del préstamo (referencia a loan)
    schedule_date DATE NOT NULL,                 -- Fecha de la programación
    status_id INT NOT NULL,                      -- ID del estado de programación (referencia a collection_schedule_status)
    FOREIGN KEY (collector_id) REFERENCES user(id), -- Llave foránea para el cobrador
    FOREIGN KEY (loan_id) REFERENCES loan(id),   -- Llave foránea para el préstamo
    FOREIGN KEY (status_id) REFERENCES collection_schedule_status(id) -- Llave foránea para el estado de programación
);

-- Tabla para almacenar tipos de notificación
CREATE TABLE notification_type (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del tipo de notificación
    type VARCHAR(255) NOT NULL                   -- Descripción del tipo de notificación
);

-- Tabla para almacenar notificaciones
CREATE TABLE notification (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la notificación
    user_id INT NOT NULL,                        -- ID del usuario (referencia a user)
    message VARCHAR(255) NOT NULL,               -- Mensaje de la notificación
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    viewed BOOLEAN DEFAULT FALSE,                 -- Indicador de si fue vista o no
    type_id INT NOT NULL,                        -- ID del tipo de notificación (referencia a notification_type)
    FOREIGN KEY (user_id) REFERENCES user(id),   -- Llave foránea para el usuario
    FOREIGN KEY (type_id) REFERENCES notification_type(id) -- Llave foránea para el tipo de notificación
);

-- Tabla para almacenar tipos de garantía
CREATE TABLE guarantee_type (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del tipo de garantía
    type VARCHAR(255) NOT NULL                   -- Descripción del tipo de garantía
);

-- Tabla para almacenar garantías
CREATE TABLE guarantee (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la garantía
    loan_id INT NOT NULL,                        -- ID del préstamo (referencia a loan)
    type_id INT NOT NULL,                        -- ID del tipo de garantía (referencia a guarantee_type)
    description VARCHAR(255),                    -- Descripción de la garantía
    estimated_value DECIMAL(10,2),              -- Valor estimado de la garantía
    FOREIGN KEY (loan_id) REFERENCES loan(id),   -- Llave foránea para el préstamo
    FOREIGN KEY (type_id) REFERENCES guarantee_type(id) -- Llave foránea para el tipo de garantía
);

-- Tabla para almacenar estados de pago
CREATE TABLE payment_status (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del estado de pago
    type VARCHAR(255) NOT NULL                   -- Descripción del estado de pago
);

-- Tabla para almacenar información de pagos
CREATE TABLE payment (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del pago
    amount DECIMAL(10, 2) CHECK(amount > 0) NOT NULL, -- Monto del pago
    date DATE NOT NULL,                          -- Fecha del pago
    status_id INT NOT NULL,                      -- ID del estado del pago (referencia a payment_status)
    loan_id INT NOT NULL,                        -- ID del préstamo (referencia a loan)
    FOREIGN KEY (loan_id) REFERENCES loan(id),   -- Llave foránea para el préstamo
    FOREIGN KEY (status_id) REFERENCES payment_status(id) -- Llave foránea para el estado del pago
);

-- Tabla para validar pagos
CREATE TABLE payment_validation (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único de la validación de pago
    payment_id INT NOT NULL,                     -- ID del pago (referencia a payment)
    administrator_id INT NOT NULL,               -- ID del administrador que valida el pago (referencia a person)
    date_validation DATE NOT NULL,               -- Fecha de validación
    comment VARCHAR(256),                        -- Comentario adicional
    FOREIGN KEY (payment_id) REFERENCES payment(id), -- Llave foránea para el pago
    FOREIGN KEY (administrator_id) REFERENCES person(id) -- Llave foránea para el administrador
);

-- Tabla para almacenar información de pagos de cobradores
CREATE TABLE payment_collector (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del registro
    payment_id INT NOT NULL,                     -- ID del pago (referencia a payment)
    collector_id INT NOT NULL,                   -- ID del cobrador (referencia a person)
    FOREIGN KEY (payment_id) REFERENCES payment(id), -- Llave foránea para el pago
    FOREIGN KEY (collector_id) REFERENCES person(id) -- Llave foránea para el cobrador
);

-- Tabla para almacenar el historial de pagos
CREATE TABLE payment_history (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del historial
    loan_id INT NOT NULL,                        -- ID del préstamo (referencia a loan)
    payment_id INT NOT NULL,                     -- ID del pago (referencia a payment)
    payment_date DATE NOT NULL,                  -- Fecha del pago
    amount DECIMAL(10, 2) NOT NULL,              -- Monto del pago
    FOREIGN KEY (loan_id) REFERENCES loan(id),   -- Llave foránea para el préstamo
    FOREIGN KEY (payment_id) REFERENCES payment(id) -- Llave foránea para el pago
);

-- Tabla para resumir la deuda de los clientes
CREATE TABLE debt_summary (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del resumen de deuda
    client_id INT NOT NULL,                      -- ID del cliente (referencia a user)
    total_debt DECIMAL(10, 2) NOT NULL,         -- Total de la deuda
    last_payment_date DATE,                      -- Fecha del último pago
    FOREIGN KEY (client_id) REFERENCES user(id)  -- Llave foránea para el cliente
);

-- Tabla para almacenar reportes financieros
CREATE TABLE financial_report (
    id INT PRIMARY KEY AUTO_INCREMENT,           -- ID único del reporte financiero
    total_loans DECIMAL(15, 2) NOT NULL,        -- Total de préstamos otorgados
    total_payments DECIMAL(15, 2) NOT NULL,     -- Total de pagos recibidos
    net_income DECIMAL(15, 2) AS (total_payments - total_loans) STORED, -- Ingreso neto calculado
    report_date DATE NOT NULL                     -- Fecha del reporte
);
