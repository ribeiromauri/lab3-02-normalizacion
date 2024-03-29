CREATE DATABASE TP1A
GO
USE TP1A 
GO 

CREATE TABLE PROVINCIAS(
	ID_PROVINCIAS SMALLINT NOT NULL PRIMARY KEY,
	NOMBRE VARCHAR(50) NOT NULL
)
GO

CREATE TABLE LOCALIDADES(
	CODIGO_POSTAL SMALLINT NOT NULL PRIMARY KEY,
	ID_PROVINCIAS SMALLINT NOT NULL FOREIGN KEY REFERENCES PROVINCIAS(ID_PROVINCIAS),
	NOMBRE VARCHAR(50) NOT NULL
)
GO

CREATE TABLE CLIENTES(
	DNI INT NOT NULL PRIMARY KEY,
	NOMBRE VARCHAR(50) NOT NULL,
	APELLIDO VARCHAR(50) NOT NULL,
	SEXO CHAR(1) NOT NULL CHECK (SEXO = 'F' OR SEXO = 'M'),
	TELEFONO VARCHAR(50) NOT NULL, 
	FECHA_ALTA DATE NOT NULL,
	FECHA_NAC DATE NOT NULL,
	DIRECCION VARCHAR(50) NOT NULL,
	CODIGO_POSTAL SMALLINT NOT NULL FOREIGN KEY REFERENCES LOCALIDADES(CODIGO_POSTAL)
)
GO

CREATE TABLE VENDEDORES(
	DNI INT NOT NULL UNIQUE,
	LEGAJO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOMBRE VARCHAR(50) NOT NULL,
	APELLIDO VARCHAR(50) NOT NULL,
	SEXO CHAR(1) NOT NULL CHECK (SEXO = 'F' OR SEXO ='M'),
	FECHA_ING DATE NOT NULL,
	FECHA_NAC DATE NOT NULL,
	SUELDO MONEY NOT NULL,
	DIRECCION VARCHAR(50) NOT NULL,
	CODIGO_POSTAL SMALLINT NOT NULL FOREIGN KEY REFERENCES LOCALIDADES(CODIGO_POSTAL)
)
GO

CREATE TABLE TIPO_ARTICULOS(
	ID_ARTICULO INT NOT NULL PRIMARY KEY,
	DESCRIPCION VARCHAR(50) NOT NULL
)
GO

CREATE TABLE MARCA_ARTICULOS(
	ID_MARCA INT NOT NULL PRIMARY KEY, 
	MARCA VARCHAR(50) NOT NULL
)
GO

CREATE TABLE ARTICULOS(
	ID_ARTICULO INT NOT NULL PRIMARY KEY, 
	DESCRIPCION VARCHAR(50) NOT NULL, 
	ID_MARCA INT NOT NULL FOREIGN KEY REFERENCES MARCA_ARTICULOS(ID_MARCA),
	ID_TIPO_ARTICULO INT NOT NULL FOREIGN KEY REFERENCES TIPO_ARTICULOS(ID_ARTICULO),
	PRECIO_COMPRA SMALLINT NOT NULL CHECK(PRECIO_COMPRA >= 0),
	PRECIO_VENTA SMALLINT NOT NULL CHECK(PRECIO_VENTA >= 0),
	STOCK INT NOT NULL,
	STOCK_MIN INT NOT NULL,
	ESTADO BIT NOT NULL,
)
GO

CREATE TABLE VENTAS(
	ID_VENTA INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	FECHA DATE NOT NULL,
	CLIENTE INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(DNI),
	VENDEDOR INT NOT NULL FOREIGN KEY REFERENCES VENDEDORES(LEGAJO),
	FORMA_PAGO CHAR NOT NULL CHECK (FORMA_PAGO = 'E' OR FORMA_PAGO = 'T'),
	IMPORTE MONEY NOT NULL
)
GO

CREATE TABLE DETALLE_VENTA(
	NRO_VENTA INT NOT NULL FOREIGN KEY REFERENCES VENTAS(ID_VENTA),
	ARTICULO INT NOT NULL FOREIGN KEY REFERENCES ARTICULOS(ID_ARTICULO),
	CANTIDAD SMALLINT NOT NULL,
	PRECIO MONEY NOT NULL
	PRIMARY KEY(NRO_VENTA, ARTICULO)
)

