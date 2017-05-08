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

/*5.Tabla Productos
Contiene información o relación de los productos que ofrecen para la venta
 y que se encuentran registrados en la base de datos. La tabla Productos se encuentra 
 en el esquema Compra.
*/



/*
6.Tabla Cargos
Contiene información o relación de los cargos que se le asigna a cada empleado 
que se encuentran registrados en la base de datos. La tabla Cargos se encuentra en 
el esquema RRHH.
*/

/*
7.Tabla Distritos
Contiene información o relación de los distritos que se le asigna a cada empleado
que se encuentran registrados en la base de datos. La tabla Distritos se
 encuentra en el esquema RRHH.
*/


/* 8.Tabla Empleados
Contiene información o relación de los empleados que se encuentran registrados en la base de datos. 
La tabla Empleados se encuentra en el esquema RRHH.
*/


/*9.Tabla PedidosCabe
Contiene información o relación de la cabecera de los pedidos que se 
registran en el proceso de la venta y que se encuentran registrados en la base de datos. 
La tabla PedidosCabe se encuentra en el esquema Venta.
*/

/*10.Tabla PedidosDeta
Contiene información o relación del detalle de los productos 
solicitados en los pedidos de venta y que se encuentran registrados en la base 
de datos. La tabla PedidosDeta se encuentra en el esquema Compra.
*/