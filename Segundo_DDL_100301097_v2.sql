/*1. Crear una base de datos de nombre */
CREATE DATABASE NEGOCIOS2016

USE NEGOCIOS2016
        GO
        -- CREAR LOS ESQUEMAS DE LA BASE DE DATOS
        CREATE SCHEMA VENTA AUTHORIZATION DBO
        GO
        CREATE SCHEMA COMPRA AUTHORIZATION DBO
        GO
        CREATE SCHEMA RRHH AUTHORIZATION DBO
        GO
USE NEGOCIOS2016
GO
SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT 
  SCHEMA_NAME(schema_id) As SchemaName ,
  name As TableName 
from sys.tables 
ORDER BY name

---------
/*1.Tabla Países
Contiene información o relación de países en donde viven los clientes o empleados.
La tabla Países se encuentra en el esquema Venta.*/

CREATE TABLE NEGOCIOS2016.VENTA.PAISES
(
IdPais char(3) NOT NULL CONSTRAINT pk_ID_PAIS PRIMARY KEY,
NombrePais VARCHAR(40) NOT NULL
);

/*2.Tabla Categorías
Contiene información o relación de categorías en donde se encuentran 
registrados los productos. La tabla Categorías se encuentra en el esquema Compra.
*/

CREATE TABLE NEGOCIOS2016.COMPRA.CATEGORIAS
(
IdCategoria int NOT NULL CONSTRAINT pk_ID_CATEGORIA PRIMARY KEY,
NombreCategoria VARCHAR(40) NOT NULL,
Descripcion TEXT 
);
/*3.Tabla Clientes
Contiene información o relación de clientes que se encuentran registrados en 
la base de datos. La tabla Clientes se encuentra en el esquema Venta.
*/

CREATE TABLE NEGOCIOS2016.VENTA.CLIENTES
(
IdCliente char(5) NOT NULL CONSTRAINT pk_ID_Cliente PRIMARY KEY,
NomCliente VARCHAR(40) NOT NULL,
DirCliente VARCHAR(80) NOT NULL,
IdPais char(3) NOT NULL,
fonoCliente VARCHAR(15)
);

--CLAVE EXTERNA IdPais en Clientes
ALTER TABLE NEGOCIOS2016.VENTA.CLIENTES
ADD FOREIGN KEY (IdPais) REFERENCES
 NEGOCIOS2016.VENTA.PAISES(IdPais);


/*4.Tabla Proveedores
Contiene información o relación de los proveedores que se encuentran registrados
 en la base de datos. La tabla Proveedores se encuentra en el esquema Compra.*/
 
 CREATE TABLE NEGOCIOS2016.COMPRA.PROVEEDORES
(
IdProveedor int NOT NULL CONSTRAINT pk_ID_Proveedor PRIMARY KEY,
NomProveedor VARCHAR(80) NOT NULL,
DirProveedor VARCHAR(100) NOT NULL,
NomContacto VARCHAR(80) NOT NULL,
CargoContacto VARCHAR(50) NOT NULL,
IdPais char(3) NOT NULL,
fonoProveedor VARCHAR(15)NOT NULL,
faxProveedor VARCHAR(15)NOT NULL
);

--CLAVE EXTERNA IdPais en Proveedores
ALTER TABLE NEGOCIOS2016.COMPRA.PROVEEDORES
ADD FOREIGN KEY (IdPais) REFERENCES
 NEGOCIOS2016.VENTA.PAISES(IdPais);

/*5.Tabla Productos
Contiene información o relación de los productos que ofrecen para la venta
 y que se encuentran registrados en la base de datos. La tabla Productos se encuentra 
 en el esquema Compra.
*/
CREATE TABLE NEGOCIOS2016.COMPRA.PRODUCTOS
(
IdProducto int NOT NULL CONSTRAINT pk_ID_Producto PRIMARY KEY,
NomProducto VARCHAR(80) NOT NULL,
IdProveedor int NOT NULL,
IdCategoria int NOT NULL,
cantxUnidad VARCHAR(50)NOT NULL,
PrecioUnidad DECIMAL(10,2) NOT NULL,
UniEnExistencia smallint not null,
UniEnPedido smallint not null

);

--CLAVE EXTERNA IdProveedor en Productos
ALTER TABLE NEGOCIOS2016.COMPRA.PRODUCTOS
ADD FOREIGN KEY (IdProveedor) REFERENCES
 NEGOCIOS2016.COMPRA.PROVEEDORES(IdProveedor);

--CLAVE EXTERNA IdCategoria en Productos

ALTER TABLE NEGOCIOS2016.COMPRA.PRODUCTOS
ADD FOREIGN KEY (IdCategoria) REFERENCES
NEGOCIOS2016.COMPRA.CATEGORIAS(IdCategoria);


/*
6.Tabla Cargos
Contiene información o relación de los cargos que se le asigna a cada empleado 
que se encuentran registrados en la base de datos. La tabla Cargos se encuentra en 
el esquema RRHH.
*/
CREATE TABLE NEGOCIOS2016.RRHH.CARGOS
(
IdCargo int NOT NULL CONSTRAINT pk_ID_Cargo PRIMARY KEY,
desCargo VARCHAR(30) NOT NULL
);

/*
7.Tabla Distritos
Contiene información o relación de los distritos que se le asigna a cada empleado
que se encuentran registrados en la base de datos. La tabla Distritos se
 encuentra en el esquema RRHH.
*/
CREATE TABLE NEGOCIOS2016.RRHH.DISTRITOS
(
IdDistrito int NOT NULL CONSTRAINT pk_ID_Distrito PRIMARY KEY,
nomDistrito VARCHAR(50) NOT NULL
);


/* 8.Tabla Empleados
Contiene información o relación de los empleados que se encuentran registrados en la base de datos. 
La tabla Empleados se encuentra en el esquema RRHH.
*/
CREATE TABLE NEGOCIOS2016.RRHH.EMPLEADOS
(
IdEmpleado INT NOT NULL CONSTRAINT pk_ID_EMPL PRIMARY KEY,
NomEmpleado VARCHAR(50) NOT NULL,
ApeEmpleado VARCHAR(50) NOT NULL,
fecnac DATETIME NOT NULL,
dirEmpleado VARCHAR(100) NOT NULL,
IdDistrito int NOT NULL,
fonoEmpleado VARCHAR(15),
IdCargo int NOT NULL,
fechaContrata DATETIME NOT NULL,
fotoEmpleado Image 
);

--CLAVE EXTERNA IdDistrito en Empleado

ALTER TABLE NEGOCIOS2016.RRHH.EMPLEADOS
ADD FOREIGN KEY (IdDistrito) REFERENCES NEGOCIOS2016.RRHH.DISTRITOS(IdDistrito);
--CLAVE EXTERNA IdCargo en Empleado

ALTER TABLE NEGOCIOS2016.RRHH.EMPLEADOS
ADD FOREIGN KEY (IdCargo) REFERENCES
NEGOCIOS2016.RRHH.CARGOS(IdCargo);



/*9.Tabla PedidosCabe
Contiene información o relación de la cabecera de los pedidos que se 
registran en el proceso de la venta y que se encuentran registrados en la base de datos. 
La tabla PedidosCabe se encuentra en el esquema Venta.
*/
CREATE TABLE NEGOCIOS2016.VENTA.PEDIDOSCABE
(

    IdPedido int not null constraint pk_idPedCabe PRIMARY KEY,
    IdCliente char(5) NOT NULL, --CAMBIAR TIPO DE DATO HAY UN ERROR
    IdEmpleado int NOT NULL,
    fechaPedido DATETIME NOT NULL,
    fechaEntrega DATETIME NOT NULL,
    fechaEnvio DATETIME NOT NULL,
    envioPedido char(1) not null,
    destinario varchar(60) NOT NULL,
    dirDestinatario VARCHAR(100) NOT NULL
    
);
DROP TABLE NEGOCIOS2016.VENTA.PEDIDOSCABE;
--CLAVE EXTERNA IdCliente en PEDIDOSCABE

ALTER TABLE NEGOCIOS2016.VENTA.PEDIDOSCABE
ADD FOREIGN KEY (IdCliente) REFERENCES
NEGOCIOS2016.VENTA.CLIENTES(IdCliente);

--CLAVE EXTERNA IdEmpleado en PEDIDOSCABE

ALTER TABLE NEGOCIOS2016.VENTA.PEDIDOSCABE
ADD FOREIGN KEY (IdEmpleado) REFERENCES
NEGOCIOS2016.RRHH.EMPLEADOS(IdEmpleado);

/*10.Tabla PedidosDeta
Contiene información o relación del detalle de los productos 
solicitados en los pedidos de venta y que se encuentran registrados en la base 
de datos. La tabla PedidosDeta se encuentra en el esquema Compra.
*/

CREATE TABLE NEGOCIOS2016.COMPRA.PEDIDOSDETA
(
    IdPedido  int not null,
    IdProducto int not null,
    precioUnidad Decimal(10,2) not null,
    Cantidad smallint not null,
    Descuento Decimal(10,2) NOT NULL

);

--CLAVE EXTERNA IdPedido en PEDIDOSDeta

ALTER TABLE NEGOCIOS2016.COMPRA.PEDIDOSDETA
ADD FOREIGN KEY (IdPedido) REFERENCES
NEGOCIOS2016.VENTA.PEDIDOSCABE(IdPedido);

--CLAVE EXTERNA IdProducto en PEDIDOSDeta

ALTER TABLE NEGOCIOS2016.COMPRA.PEDIDOSDETA
ADD FOREIGN KEY (IdProducto) REFERENCES
NEGOCIOS2016.COMPRA.PRODUCTOS(IdProducto);


