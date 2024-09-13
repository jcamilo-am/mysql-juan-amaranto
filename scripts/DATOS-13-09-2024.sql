USE loan_manager;

-- Insertar datos en la tabla Direccion
INSERT INTO Direccion (Barrio, Carrera, Calle, Descripcion) VALUES
('Centro', 'Carrera 10', 'Calle 20', 'Oficina principal'),
('Suburbio', 'Carrera 12', 'Calle 30', 'Sucursal secundaria'),
('Zona Rural', 'Carrera 15', 'Calle 40', 'Oficina en la zona rural');

-- Insertar datos en la tabla Negocio
INSERT INTO Negocio (Nombre, Telefono, Descripcion, Propietario, DireccionID, EstadoLegal) VALUES
('Librería El Saber', '1234567890', 'Venta de libros y material educativo', 'Ana Pérez', 1, 'Formal'),
('Café del Parque', '0987654321', 'Café con ambiente familiar', 'Luis Gómez', 2, 'Registrado'),
('Ferretería El Clavo', '1122334455', 'Suministros de ferretería', 'Carlos Ruiz', 3, 'Informal');

-- Insertar datos en la tabla Trabajo
INSERT INTO Trabajo (Descripcion, NegocioID) VALUES
('Encargada de ventas', 1),
('Barista', 2),
('Asistente de ventas', 3);

-- Insertar datos en la tabla Usuario
INSERT INTO Usuario (Nombre, Apellido, Documento, Telefono, Correo, Clave, Rol) VALUES
('Juan', 'Sánchez', '1234567890', '3001234567', 'juan.sanchez@example.com', 'password123', 'Administrador'),
('María', 'López', '0987654321', '3007654321', 'maria.lopez@example.com', 'password123', 'Cobrador'),
('Pedro', 'García', '1122334455', '3001122334', 'pedro.garcia@example.com', 'password123', 'Usuario');

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, Documento, Telefono, DireccionID, NegocioID, TrabajoID) VALUES
('Jorge', 'Martínez', '2233445566', '3002233445', 1, 1, 1),
('Laura', 'Ríos', '3344556677', '3003344556', 2, 2, 2),
('Ana', 'Vásquez', '4455667788', '3004455667', 3, 3, 3);

-- Insertar datos en la tabla Prestamo
INSERT INTO Prestamo (ClienteID, FiadorID, Monto, TasaInteres, FechaInicio, FechaFin, MontoPago, FrecuenciaPago, Saldo, Tipo, Estado) VALUES
(1, 2, 5000.00, 5.00, '2024-01-01', '2024-12-31', 500.00, 'Mensual', 4500.00, TRUE, 'Activo'),
(2, 3, 3000.00, 4.50, '2024-02-01', '2024-08-01', 500.00, 'Quincenal', 2500.00, FALSE, 'Activo'),
(3, 1, 1500.00, 6.00, '2024-03-01', '2024-09-01', 300.00, 'Mensual', 1200.00, TRUE, 'Finalizado');

-- Insertar datos en la tabla Pago
INSERT INTO Pago (PrestamoID, Monto, Fecha) VALUES
(1, 500.00, '2024-01-31'),
(1, 500.00, '2024-02-28'),
(2, 500.00, '2024-02-15'),
(2, 500.00, '2024-03-01'),
(3, 300.00, '2024-03-31');

-- Insertar datos en la tabla Garantia
INSERT INTO Garantia (PrestamoID, Tipo, Valor, Descripcion, FechaRegistro) VALUES
(1, 'Vehículo', 6000.00, 'Automóvil marca X', '2024-01-02'),
(2, 'Inmueble', 3500.00, 'Apartamento en el centro', '2024-02-02'),
(3, 'Joyas', 2000.00, 'Conjunto de joyas antiguas', '2024-03-02');

-- Insertar datos en la tabla CobradorPrestamo
INSERT INTO CobradorPrestamo (CobradorID, PrestamoID, FechaCobro) VALUES
(2, 1, '2024-01-31'),
(2, 2, '2024-02-15'),
(3, 3, '2024-03-31');
