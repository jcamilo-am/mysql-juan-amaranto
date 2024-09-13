-- Consulta 1: Clientes con Préstamos Activos
SELECT DISTINCT c.Nombre, c.Apellido, 'Con Préstamo Activo' AS Fuente
FROM Cliente c
JOIN Prestamo p ON c.ClienteID = p.ClienteID
WHERE p.Estado = 'Activo';

-- Consulta 2: Clientes con Garantías Registradas
SELECT DISTINCT c.Nombre, c.Apellido, 'Con Garantía Registrada' AS Fuente
FROM Cliente c
JOIN Garantia g ON c.ClienteID = g.PrestamoID;

-- Consulta 3: Negocios en Direcciones Específicas
SELECT Nombre, Telefono, DireccionID
FROM Negocio
WHERE DireccionID = 1

UNION

SELECT Nombre, Telefono, DireccionID
FROM Negocio
WHERE DireccionID = 2;

-- Consulta 4: Usuarios con Rol 'Cobrador' y 'Administrador'
SELECT Nombre, Apellido, Rol
FROM Usuario
WHERE Rol = 'Cobrador'

UNION

SELECT Nombre, Apellido, Rol
FROM Usuario
WHERE Rol = 'Administrador';

-- Consulta 5: Clientes con Préstamos y Clientes que han Realizado Pagos
SELECT DISTINCT c.Nombre, c.Apellido, 'Con Préstamo' AS Fuente
FROM Cliente c
JOIN Prestamo p ON c.ClienteID = p.ClienteID

UNION

SELECT DISTINCT c.Nombre, c.Apellido, 'Con Pago Realizado' AS Fuente
FROM Cliente c
JOIN Pago pa ON c.ClienteID = (SELECT ClienteID FROM Prestamo WHERE PrestamoID = pa.PrestamoID);

-- Consulta 6: Clientes con Préstamos Activos y Clientes que han sido Fiadores
SELECT DISTINCT c.Nombre, c.Apellido, 'Con Préstamo Activo' AS Fuente
FROM Cliente c
JOIN Prestamo p ON c.ClienteID = p.ClienteID
WHERE p.Estado = 'Activo'

UNION

SELECT DISTINCT c.Nombre, c.Apellido, 'Fiador en Préstamo' AS Fuente
FROM Cliente c
JOIN Prestamo p ON c.ClienteID = p.FiadorID;

-- Consulta 7: Trabajos con Descripción que Contiene 'Ventas'
SELECT Descripcion AS Detalle, 'Trabajo' AS Tipo
FROM Trabajo
WHERE Descripcion LIKE '%Ventas%';

-- Consulta 8: Negocios con Descripción que Contiene 'Café'
SELECT Descripcion AS Detalle, 'Negocio' AS Tipo
FROM Negocio
WHERE Descripcion LIKE '%Café%';



