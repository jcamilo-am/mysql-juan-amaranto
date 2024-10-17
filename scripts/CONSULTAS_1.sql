USE loan_manager;

-- Consulta simple
-- SELECT * FROM Cliente WHERE Cliente.ClienteID = 1;

-- Consulta avanzada
-- SELECT * FROM Prestamo WHERE Prestamo.PrestamoID <> 0
-- AND Prestamo.Monto > 1000 AND Prestamo.Estado = "Activo";

-- Uso de LIKE
-- SELECT * FROM Cliente
-- WHERE LOWER(Cliente.Nombre) LIKE '_o%';

-- Uso de BETWEEN
-- SELECT * FROM Prestamo WHERE Prestamo.PrestamoID IS NOT NULL
-- AND Prestamo.Saldo BETWEEN 1000 AND 3000;