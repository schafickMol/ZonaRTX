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
    contraseña NVARCHAR(100) NOT NULL,
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

/**********************
			PROCESOS DE ALMACENADO
************************/


--Procesos de Almacenado Usuarios.
CREATE PROCEDURE sp_CrearUsuario
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @correo NVARCHAR(100),
    @contraseña NVARCHAR(100)
AS
BEGIN
    INSERT INTO Usuarios (nombre, apellido, email, contraseña)
    VALUES (@nombre, @apellido, @correo, @contraseña);
END;
GO

CREATE PROCEDURE sp_ObtenerUsuarios
AS
BEGIN
    SELECT id_usuario, nombre, apellido, email
    FROM Usuarios;
END;
GO

CREATE PROCEDURE sp_ActualizarUsuario
    @id_usuario INT,
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @correo NVARCHAR(100),
    @contraseña NVARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET nombre = @nombre,
        apellido = @apellido,
        email = @correo,
        contraseña = @contraseña
    WHERE id_usuario = @id_usuario;
END;
GO
CREATE PROCEDURE sp_EliminarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM Usuarios WHERE id_usuario = @id_usuario;
END;
GO

CREATE PROCEDURE sp_ObtenerUsuarioPorID
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


