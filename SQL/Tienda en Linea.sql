CREATE DATABASE TiendaTecnologica;
GO

USE TiendaTecnologica;
GO

/*******************
		TABLAS
**********************/
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(100)NOT NULL,
	apellido NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    contrasena NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria NVARCHAR(50) NOT NULL,
    descripcion NVARCHAR(255)
);
GO

CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX),
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT NOT NULL,
    fecha_agregado DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria) ON DELETE CASCADE
);
GO

CREATE TABLE Pedidos (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME DEFAULT GETDATE(),
    estado NVARCHAR(20) DEFAULT 'pendiente', -- Tipos de estado que usaremos: pendiente, enviado, completado, cancelado)
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);
GO

CREATE TABLE Inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) ON DELETE CASCADE
);
GO

CREATE TABLE DetallePedidos (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) ON DELETE CASCADE
);
GO




CREATE TABLE Proveedores (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    contacto NVARCHAR(100),
    telefono NVARCHAR(20),
    email NVARCHAR(100) UNIQUE
);
GO

CREATE TABLE ProductosProveedores (
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    precio_compra DECIMAL(10, 2),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor) ON DELETE CASCADE,
    PRIMARY KEY (id_producto, id_proveedor)
);

CREATE TRIGGER tr_ActualizarInventario
ON DetallePedidos
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Inventario inv
        INNER JOIN inserted i ON inv.id_producto = i.id_producto
        WHERE inv.stock_actual < i.cantidad
    )
    BEGIN
        RAISERROR ('No hay suficiente stock para el producto', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        UPDATE Inventario
        SET stock_actual = stock_actual - i.cantidad
        FROM Inventario inv
        INNER JOIN inserted i ON inv.id_producto = i.id_producto;
    END
END;

SELECT * 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS;

-- Usuario de prueba
EXEC sp_CrearUsuario 'Juan', 'Pérez', 'juan.perez@email.com', 'password123';

-- Categoría de prueba
EXEC sp_CrearCategoria 'Electrónica', 'Dispositivos electrónicos y accesorios';

-- Producto de prueba
EXEC sp_CrearProducto 'Laptop', 'Laptop gaming de alta gama', 1200.00, 1;

-- Pedido de prueba
EXEC sp_CrearPedido 1, 1200.00;

/**********************
			PROCESOS DE ALMACENADO
************************/


--Procesos de Almacenado Usuarios.
ALTER PROCEDURE sp_CrearUsuario
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @correo NVARCHAR(100),
    @contrasena NVARCHAR(100) -- Actualizado
AS
BEGIN
    INSERT INTO Usuarios (nombre, apellido, email, contrasena) -- Actualizado
    VALUES (@nombre, @apellido, @correo, @contrasena);
END;
GO

ALTER PROCEDURE sp_ObtenerUsuarios
AS
BEGIN
    SELECT id_usuario, nombre, apellido, email
    FROM Usuarios;
END;
GO

ALTER PROCEDURE sp_ActualizarUsuario
    @id_usuario INT,
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @correo NVARCHAR(100),
    @contrasena NVARCHAR(100) -- Actualizado
AS
BEGIN
    UPDATE Usuarios
    SET nombre = @nombre,
        apellido = @apellido,
        email = @correo,
        contrasena = @contrasena -- Actualizado
    WHERE id_usuario = @id_usuario;
END;
GO

ALTER PROCEDURE sp_EliminarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM Usuarios WHERE id_usuario = @id_usuario;
END;
GO

ALTER PROCEDURE sp_ObtenerUsuarioPorID
    @id_usuario INT
AS
BEGIN
    SELECT id_usuario, nombre, apellido, email
    FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO

-- Categorias
CREATE PROCEDURE sp_CrearCategoria
    @nombre_categoria NVARCHAR(50),
    @descripcion NVARCHAR(255)
AS
BEGIN
    INSERT INTO Categorias (nombre_categoria, descripcion)
    VALUES (@nombre_categoria, @descripcion);
END;
GO

CREATE PROCEDURE sp_ObtenerCategorias
AS
BEGIN
    SELECT id_categoria, nombre_categoria, descripcion
    FROM Categorias;
END;
GO

CREATE PROCEDURE sp_ActualizarCategoria
    @id_categoria INT,
    @nombre_categoria NVARCHAR(50),
    @descripcion NVARCHAR(255)
AS
BEGIN
    UPDATE Categorias
    SET nombre_categoria = @nombre_categoria,
        descripcion = @descripcion
    WHERE id_categoria = @id_categoria;
END;
GO

CREATE PROCEDURE sp_EliminarCategoria
    @id_categoria INT
AS
BEGIN
    DELETE FROM Categorias WHERE id_categoria = @id_categoria;
END;
GO

CREATE PROCEDURE sp_ObtenerCategoriaPorID
    @id_categoria INT
AS
BEGIN
    SELECT id_categoria, nombre_categoria, descripcion
    FROM Categorias
    WHERE id_categoria = @id_categoria;
END;
GO


--Tablade Productos:
CREATE PROCEDURE sp_CrearProducto
    @nombre_producto NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @precio DECIMAL(10, 2),
    @id_categoria INT
AS
BEGIN
    INSERT INTO Productos (nombre_producto, descripcion, precio, id_categoria)
    VALUES (@nombre_producto, @descripcion, @precio, @id_categoria);
END;
GO

CREATE PROCEDURE sp_ObtenerProductos
AS
BEGIN
    SELECT p.id_producto, p.nombre_producto, p.descripcion, p.precio, 
           c.nombre_categoria, p.fecha_agregado
    FROM Productos p
    INNER JOIN Categorias c ON p.id_categoria = c.id_categoria;
END;
GO

CREATE PROCEDURE sp_ActualizarProducto
    @id_producto INT,
    @nombre_producto NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @precio DECIMAL(10, 2),
    @id_categoria INT
AS
BEGIN
    UPDATE Productos
    SET nombre_producto = @nombre_producto,
        descripcion = @descripcion,
        precio = @precio,
        id_categoria = @id_categoria
    WHERE id_producto = @id_producto;
END;
GO
CREATE PROCEDURE sp_EliminarProducto
    @id_producto INT
AS
BEGIN
    DELETE FROM Productos WHERE id_producto = @id_producto;
END;
GO

CREATE PROCEDURE sp_ObtenerProductoPorID
    @id_producto INT
AS
BEGIN
    SELECT p.id_producto, p.nombre_producto, p.descripcion, p.precio, 
           c.nombre_categoria, p.fecha_agregado
    FROM Productos p
    INNER JOIN Categorias c ON p.id_categoria = c.id_categoria
    WHERE p.id_producto = @id_producto;
END;
GO


--Tabla de Pedidos: 
 CREATE PROCEDURE sp_CrearPedido
    @id_usuario INT,
    @total DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Pedidos (id_usuario, total)
    VALUES (@id_usuario, @total);
END;
GO


CREATE PROCEDURE sp_ObtenerPedidos
AS
BEGIN
    SELECT p.id_pedido, u.nombre + ' ' + u.apellido AS cliente, 
           p.fecha_pedido, p.estado, p.total
    FROM Pedidos p
    INNER JOIN Usuarios u ON p.id_usuario = u.id_usuario;
END;
GO


CREATE PROCEDURE sp_ActualizarPedido
    @id_pedido INT,
    @estado NVARCHAR(20),
    @total DECIMAL(10, 2)
AS
BEGIN
    UPDATE Pedidos
    SET estado = @estado,
        total = @total
    WHERE id_pedido = @id_pedido;
END;
GO

CREATE PROCEDURE sp_EliminarPedido
    @id_pedido INT
AS
BEGIN
    DELETE FROM Pedidos WHERE id_pedido = @id_pedido;
END;
GO

CREATE PROCEDURE sp_ObtenerPedidoPorID
    @id_pedido INT
AS
BEGIN
    SELECT p.id_pedido, u.nombre + ' ' + u.apellido AS cliente, 
           p.fecha_pedido, p.estado, p.total
    FROM Pedidos p
    INNER JOIN Usuarios u ON p.id_usuario = u.id_usuario
    WHERE p.id_pedido = @id_pedido;
END;
GO


--Tabla de inventario

CREATE PROCEDURE sp_CrearInventario
    @id_producto INT,
    @stock_actual INT,
    @stock_minimo INT
AS
BEGIN
    INSERT INTO Inventario (id_producto, stock_actual, stock_minimo)
    VALUES (@id_producto, @stock_actual, @stock_minimo);
END;
GO

CREATE PROCEDURE sp_ObtenerInventario
AS
BEGIN
    SELECT i.id_inventario, p.nombre_producto, i.stock_actual, 
           i.stock_minimo, i.fecha_actualizacion
    FROM Inventario i
    INNER JOIN Productos p ON i.id_producto = p.id_producto;
END;
GO

CREATE PROCEDURE sp_ActualizarInventario
    @id_inventario INT,
    @stock_actual INT,
    @stock_minimo INT
AS
BEGIN
    UPDATE Inventario
    SET stock_actual = @stock_actual,
        stock_minimo = @stock_minimo,
        fecha_actualizacion = GETDATE()
    WHERE id_inventario = @id_inventario;
END;
GO

CREATE PROCEDURE sp_EliminarInventario
    @id_inventario INT
AS
BEGIN
    DELETE FROM Inventario WHERE id_inventario = @id_inventario;
END;
GO

CREATE PROCEDURE sp_ObtenerInventarioPorID
    @id_inventario INT
AS
BEGIN
    SELECT i.id_inventario, p.nombre_producto, i.stock_actual, 
           i.stock_minimo, i.fecha_actualizacion
    FROM Inventario i
    INNER JOIN Productos p ON i.id_producto = p.id_producto
    WHERE i.id_inventario = @id_inventario;
END;
GO


CREATE PROCEDURE sp_InsertarDetallePedido
    @id_pedido INT,
    @id_producto INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO DetallePedidos (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (@id_pedido, @id_producto, @cantidad, @precio_unitario);
END;
GO

CREATE PROCEDURE sp_ObtenerDetallesPedido
    @id_pedido INT
AS
BEGIN
    SELECT dp.id_detalle, dp.id_producto, p.nombre_producto, dp.cantidad, dp.precio_unitario,
           (dp.cantidad * dp.precio_unitario) AS subtotal
    FROM DetallePedidos dp
    INNER JOIN Productos p ON dp.id_producto = p.id_producto
    WHERE dp.id_pedido = @id_pedido;
END;
GO


CREATE PROCEDURE sp_ActualizarDetallePedido
    @id_detalle INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10, 2)
AS
BEGIN
    UPDATE DetallePedidos
    SET cantidad = @cantidad,
        precio_unitario = @precio_unitario
    WHERE id_detalle = @id_detalle;
END;
GO

CREATE PROCEDURE sp_EliminarDetallePedido
    @id_detalle INT
AS
BEGIN
    DELETE FROM DetallePedidos
    WHERE id_detalle = @id_detalle;
END;
GO

CREATE PROCEDURE sp_CalcularTotalPedido
    @id_pedido INT
AS
BEGIN
    DECLARE @total DECIMAL(10, 2);

    SELECT @total = SUM(dp.cantidad * dp.precio_unitario)
    FROM DetallePedidos dp
    WHERE dp.id_pedido = @id_pedido;

    UPDATE Pedidos
    SET total = @total
    WHERE id_pedido = @id_pedido;
END;
GO


