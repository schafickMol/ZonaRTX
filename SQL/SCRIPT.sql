USE [master]
GO
/****** Object:  Database [TiendaTecnologica]    Script Date: 2/12/2024 23:03:34 ******/
CREATE DATABASE [TiendaTecnologica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TiendaTecnologica', FILENAME = N'D:\SQLData\TiendaTecnologica.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TiendaTecnologica_log', FILENAME = N'D:\SQLData\TiendaTecnologica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TiendaTecnologica] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TiendaTecnologica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TiendaTecnologica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET ARITHABORT OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TiendaTecnologica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TiendaTecnologica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TiendaTecnologica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TiendaTecnologica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TiendaTecnologica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TiendaTecnologica] SET  MULTI_USER 
GO
ALTER DATABASE [TiendaTecnologica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TiendaTecnologica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TiendaTecnologica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TiendaTecnologica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TiendaTecnologica] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TiendaTecnologica] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TiendaTecnologica] SET QUERY_STORE = ON
GO
ALTER DATABASE [TiendaTecnologica] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TiendaTecnologica]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre_categoria] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallePedidos]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePedidos](
	[id_detalle] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[id_inventario] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[stock_actual] [int] NOT NULL,
	[stock_minimo] [int] NOT NULL,
	[fecha_actualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_inventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[fecha_pedido] [datetime] NULL,
	[estado] [nvarchar](20) NULL,
	[total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[nombre_producto] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](max) NULL,
	[precio] [decimal](10, 2) NOT NULL,
	[id_categoria] [int] NOT NULL,
	[fecha_agregado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosProveedores]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosProveedores](
	[id_producto] [int] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[precio_compra] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC,
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[id_proveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[contacto] [nvarchar](100) NULL,
	[telefono] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[apellido] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[contrasena] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (1, N'Electrónica', N'Dispositivos electrónicos y accesorios')
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (3, N'Laptops', N'Dispositivo informático portátil que tiene las mismas funciones que una computadora de escritorio, pero en un tamaño más pequeño y fácil de transportar')
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (4, N'Smartphones', N'Teléfono móvil que combina las funciones de un teléfono celular con las de una computadora de bolsillo o tablet táctil')
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (5, N'Auriculares', N'Pa los oidos
')
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (6, N'Monitores', NULL)
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (7, N'Teclados', NULL)
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (8, N'Smartwatches', NULL)
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (9, N'Cámaras', NULL)
INSERT [dbo].[Categorias] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (10, N'Discos Duros', NULL)
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallePedidos] ON 

INSERT [dbo].[DetallePedidos] ([id_detalle], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (1, 1, 1, 2, CAST(320.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedidos] ([id_detalle], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (2, 1, 10, 2, CAST(750.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedidos] ([id_detalle], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (3, 1, 11, 2, CAST(799.99 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallePedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([id_pedido], [id_usuario], [fecha_pedido], [estado], [total]) VALUES (1, 1, CAST(N'2024-11-23T16:38:32.713' AS DateTime), N'pendiente', CAST(1200.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (1, N'Laptop', N'Laptop gaming de alta gama', CAST(320.00 AS Decimal(10, 2)), 1, CAST(N'2024-11-23T16:38:27.317' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (10, N'Laptop Dell Inspiron 15', N'Laptop Dell Inspiron 15, pantalla 15.6", procesador Intel i5, 8GB RAM, 512GB SSD.', CAST(750.00 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (11, N'Smartphone Samsung Galaxy S22', N'Smartphone Samsung Galaxy S22, 6.1" pantalla AMOLED, cámara 50 MP, 128GB almacenamiento.', CAST(799.99 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (12, N'Auriculares Sony WH-1000XM5', N'Auriculares Sony WH-1000XM5 con cancelación de ruido activa, batería de hasta 30 horas.', CAST(350.00 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (13, N'Monitor LG UltraWide 34"', N'Monitor LG UltraWide de 34", resolución 2560x1080, ideal para productividad y entretenimiento.', CAST(399.99 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (14, N'Teclado Mecánico Logitech G Pro', N'Teclado mecánico Logitech G Pro, switches táctiles, retroiluminación RGB.', CAST(129.99 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (15, N'Smartwatch Apple Watch Series 8', N'Smartwatch Apple Watch Series 8, pantalla siempre activa, seguimiento de salud, compatible con iPhone.', CAST(399.00 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (16, N'Cámara Canon EOS 90D', N'Cámara DSLR Canon EOS 90D, 32.5 MP, grabación 4K, lente 18-55mm incluido.', CAST(1200.00 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (17, N'Disco Duro Externo Seagate 2TB', N'Disco duro externo Seagate de 2TB, USB 3.0, para almacenamiento de archivos grandes.', CAST(89.99 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
INSERT [dbo].[Productos] ([id_producto], [nombre_producto], [descripcion], [precio], [id_categoria], [fecha_agregado]) VALUES (18, N'Tablet Samsung Galaxy Tab S8', N'Tablet Samsung Galaxy Tab S8, pantalla 11", 8GB RAM, 128GB almacenamiento, procesador Snapdragon.', CAST(499.99 AS Decimal(10, 2)), 1, CAST(N'2024-11-30T19:38:31.710' AS DateTime))
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
INSERT [dbo].[ProductosProveedores] ([id_producto], [id_proveedor], [precio_compra]) VALUES (1, 2, CAST(155.00 AS Decimal(10, 2)))
INSERT [dbo].[ProductosProveedores] ([id_producto], [id_proveedor], [precio_compra]) VALUES (10, 5, CAST(300.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([id_proveedor], [nombre], [contacto], [telefono], [email]) VALUES (2, N'Xiaomi', N'Ana Martínez', N'+503 6543-5678', N'ventas@electrodomesticos.com')
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre], [contacto], [telefono], [email]) VALUES (5, N'Asus', N'Juan Pérez', N'+503 7890-1234', N'contacto@maderaslaunion.com')
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [contrasena]) VALUES (1, N'Juan', N'Pérez', N'juan.perez@email.com', N'password123')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Proveedo__AB6E616478B9016B]    Script Date: 2/12/2024 23:03:34 ******/
ALTER TABLE [dbo].[Proveedores] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__AB6E6164759DB773]    Script Date: 2/12/2024 23:03:34 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inventario] ADD  DEFAULT (getdate()) FOR [fecha_actualizacion]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT (getdate()) FOR [fecha_pedido]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ('pendiente') FOR [estado]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT (getdate()) FOR [fecha_agregado]
GO
ALTER TABLE [dbo].[DetallePedidos]  WITH CHECK ADD FOREIGN KEY([id_pedido])
REFERENCES [dbo].[Pedidos] ([id_pedido])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DetallePedidos]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([id_categoria])
REFERENCES [dbo].[Categorias] ([id_categoria])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductosProveedores]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductosProveedores]  WITH CHECK ADD FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[Proveedores] ([id_proveedor])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarCategoria]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarCategoria]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarDetallePedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarDetallePedido]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarInventario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarInventario]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarPedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ActualizarPedido]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarProducto]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarProducto]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarUsuario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarUsuario]
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
/****** Object:  StoredProcedure [dbo].[sp_CalcularTotalPedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CalcularTotalPedido]
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
/****** Object:  StoredProcedure [dbo].[sp_CrearCategoria]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Categorias
CREATE PROCEDURE [dbo].[sp_CrearCategoria]
    @nombre_categoria NVARCHAR(50),
    @descripcion NVARCHAR(255)
AS
BEGIN
    INSERT INTO Categorias (nombre_categoria, descripcion)
    VALUES (@nombre_categoria, @descripcion);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearInventario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tabla de inventario

CREATE PROCEDURE [dbo].[sp_CrearInventario]
    @id_producto INT,
    @stock_actual INT,
    @stock_minimo INT
AS
BEGIN
    INSERT INTO Inventario (id_producto, stock_actual, stock_minimo)
    VALUES (@id_producto, @stock_actual, @stock_minimo);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearPedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tabla de Pedidos: 
 CREATE PROCEDURE [dbo].[sp_CrearPedido]
    @id_usuario INT,
    @total DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Pedidos (id_usuario, total)
    VALUES (@id_usuario, @total);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearProducto]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tablade Productos:
CREATE PROCEDURE [dbo].[sp_CrearProducto]
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
/****** Object:  StoredProcedure [dbo].[sp_CrearUsuario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CrearUsuario]
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
/****** Object:  StoredProcedure [dbo].[sp_EliminarCategoria]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarCategoria]
    @id_categoria INT
AS
BEGIN
    DELETE FROM Categorias WHERE id_categoria = @id_categoria;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarDetallePedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EliminarDetallePedido]
    @id_detalle INT
AS
BEGIN
    DELETE FROM DetallePedidos
    WHERE id_detalle = @id_detalle;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarInventario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarInventario]
    @id_inventario INT
AS
BEGIN
    DELETE FROM Inventario WHERE id_inventario = @id_inventario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarPedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarPedido]
    @id_pedido INT
AS
BEGIN
    DELETE FROM Pedidos WHERE id_pedido = @id_pedido;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarProducto]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EliminarProducto]
    @id_producto INT
AS
BEGIN
    DELETE FROM Productos WHERE id_producto = @id_producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarUsuario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EliminarUsuario]
    @id_usuario INT
AS
BEGIN
    DELETE FROM Usuarios WHERE id_usuario = @id_usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarDetallePedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarDetallePedido]
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerCategoriaPorID]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerCategoriaPorID]
    @id_categoria INT
AS
BEGIN
    SELECT id_categoria, nombre_categoria, descripcion
    FROM Categorias
    WHERE id_categoria = @id_categoria;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerCategorias]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerCategorias]
AS
BEGIN
    SELECT id_categoria, nombre_categoria, descripcion
    FROM Categorias;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerDetallesPedido]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerDetallesPedido]
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerInventario]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerInventario]
AS
BEGIN
    SELECT i.id_inventario, p.nombre_producto, i.stock_actual, 
           i.stock_minimo, i.fecha_actualizacion
    FROM Inventario i
    INNER JOIN Productos p ON i.id_producto = p.id_producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerInventarioPorID]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerInventarioPorID]
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidoPorID]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerPedidoPorID]
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidos]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ObtenerPedidos]
AS
BEGIN
    SELECT p.id_pedido, u.nombre + ' ' + u.apellido AS cliente, 
           p.fecha_pedido, p.estado, p.total
    FROM Pedidos p
    INNER JOIN Usuarios u ON p.id_usuario = u.id_usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerProductoPorID]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerProductoPorID]
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerProductos]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerProductos]
AS
BEGIN
    SELECT p.id_producto, p.nombre_producto, p.descripcion, p.precio, 
           c.nombre_categoria, p.fecha_agregado
    FROM Productos p
    INNER JOIN Categorias c ON p.id_categoria = c.id_categoria;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerUsuarioPorID]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerUsuarioPorID]
    @id_usuario INT
AS
BEGIN
    SELECT id_usuario, nombre, apellido, email
    FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerUsuarios]    Script Date: 2/12/2024 23:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerUsuarios]
AS
BEGIN
    SELECT id_usuario, nombre, apellido, email
    FROM Usuarios;
END;
GO
USE [master]
GO
ALTER DATABASE [TiendaTecnologica] SET  READ_WRITE 
GO
