--pRODUCTOS CAROS
use Neptuno
SELECT PROD.NombreProducto PRODUCTO,
Prov.NOMBRECOMPAÑÍA PROVEEDOR,
PROD.PrecioUnidad PRECIO
FROM PRODUCTOS PROD
INNER JOIN Proveedores Prov
	On PROD.IdProveedor = Prov.IdProveedor
WHERE PROD.PrecioUnidad > 50;
--- PRODUCTOS ESCASOS

USE Neptuno
SELECT PROD.NombreProducto PRODUCTO,
PROD.IdProveedor PRODUCTO,
PROD.UNIDADESENEXISTENCIA PRODUCTO
FROM Productos PROD
WHERE PROD.IdCategoría = 1 AND PROD.UnidadesEnExistencia < 25;

--COMPAÑIAS VARIAS
/*Compañias varias: nombre de las compañías clientes cuyo contacto sea el propietario o
su país sea España y su contacto sea un agente de ventas.*/

USE Neptuno
SELECT CLI.NOMBRECOMPAÑÍA,CLI.NombreContacto,CLI.CargoContacto,CLI.PAÍS
FROM Clientes CLI 
WHERE CLI.CargoContacto = 'Propietario' OR CLI.País ='España' and CLI.CargoContacto='Agente de ventas';

USE Neptuno
SELECT * FROM Clientes;
/*Pedidos recientes: cliente, fecha de entrega y ciudad de los pedidos enviados a Suecia
con fecha de pedido posterior al 1 de enero de 1998.*/


USE Neptuno
SELECT PED.IDCLIENTE,PED.FECHAENTREGA,PED.CiudadDestinatario
FROM Pedidos PED
WHERE PED.FechaPedido > '1998-01-01 00:00:00.000' AND PED.PaísDestinatario = 'Suecia';


USE Neptuno
SELECT * FROM PEDIDOS
where IdPedido = 10561;

/*
Proveedores estadounidenses: nombre de la compañía, dirección, ciudad, región, código
postal y teléfono de todos los proveedores de EE.UU. El nombre de la compañía debe
aparecer ordenado alfabéticamente
*/


USE Neptuno
SELECT PROV.NOMBRECOMPAÑÍA, PROV.DIRECCIÓN,PROV.Ciudad,PROV.Región,PROV.CódPostal,PROV.Teléfono
FROM Proveedores PROV
WHERE PROV.País = 'Estados Unidos'
ORDER BY PROV.NombreCompañía ASC;


USE Neptuno
SELECT * FROM Proveedores;

/*
Productos suspendidos: nombre de aquellos productos que están “suspendidos”. Pista:
el campo Suspendido es de tipo Si/No, que es lo mismo que Verdadero/Falso, que en
inglés se traduce como …
*/

USE Neptuno
SELECT NombreProducto,Suspendido
from Productos
where Suspendido = 0;

--2. Extrae la siguiente información de la base de datos Neptuno:

/* Para cada categoría de productos, el promedio de unidades en existencia, el precio
mínimo y el precio máximo.*/

USE Neptuno
SELECT DISTINCT PROD.IDCATEGORÍA, AVG(UnidadesEnExistencia) AS PROM_Unit_Exist, 
MIN(PrecioUnidad) AS preciMin,MAX(PrecioUnidad) As PreciMax
From Productos PROD
GROUP BY Prod.IdCategoría;

/*Total de empleados nacidos antes del 1 de enero de 1960. Crea primero una consulta
que obtenga las fechas de nacimiento de los empleados anteriores a 1960 (el criterio
será < 01/01/1960, sin comillas). Las consultas también se pueden tomar como origen
de otras consultas, así que crea una segunda consulta que cuente los registros de la
anterio r.*/

USE Neptuno
SELECT Count(Emp.IdEmpleado) AS Total_emp_FN60
FROM Empleados EMP
WHERE EMP.FechaNacimiento < 01/01/1960

USE Neptuno
SELECT Count(Emp.IdEmpleado) AS Total_emp_FN60
FROM Empleados EMP
WHERE EMP.FechaNacimiento < '1960-01-01 00:00:00.000'

USE Neptuno
SELECT * FROM Empleados;

/*Para cada producto en Detalles de pedidos, el total de ventas. Crea primero una consulta
que calcule para cada pedido el producto del precio y el nº de unidades (en lugar de
elegir un cmapo en la vista Diseño, escribe =PrecioUnidad*Cantidad). Crea una
segunda consulta que tenga como origen la anterior y que sume las cantidades de cada
producto.*/

USE Neptuno
SELECT SUM(PrecioUnidad * Cantidad) AS tVenta23
--SELECT IdProducto,PrecioUnidad,Cantidad,SUM(PrecioUnidad * Cantidad) AS tVenta23
FROM [Detalles de pedidos]
WHERE IdProducto = 23;

USE Neptuno
SELECT DISTINCT DetPd.IDPedido, PrecioUnidad * Cantidad
from [Detalles de pedidos] DetPd
order by DetPd.IdPedido;

USE Neptuno
SELECT DISTINCT IdProducto, PrecioUnidad * Cantidad
from [Detalles de pedidos] 
Order by IdProducto

USE Neptuno
SELECT DISTINCT DetPd.IdPedido, (PrecioUnidad * Cantidad) As CantTotal, SUM(Cantidad) As CantProducto
from [Detalles de pedidos] DetPd
order by DetPd.IDPedido;
-------------------Arriba prueba para luego hacerla por parte-------------------

--Para cada producto en Detalles de pedidos, el total de ventas.
USE Neptuno
SELECT DISTINCT DetPe.IdProducto,Sum (PrecioUnidad * Cantidad) As TotalVentas
from [Detalles de pedidos] DetPe
--Order by DetPe.IdProducto
GROUP BY DetPe.IdProducto

/*Crea primero una consulta
que calcule para cada pedido el producto del precio y el nº de unidades (en lugar de
elegir un cmapo en la vista Diseño, escribe =PrecioUnidad*Cantidad)*/

USE Neptuno
SELECT DISTINCT DetPd.IdPedido, (PrecioUnidad * Cantidad) As PriceCant
from [Detalles de pedidos] DetPd
order by DetPd.IDPedido;

use Neptuno
select distinct idPedido,(PrecioUnidad * Cantidad) As PriceCant
from [Detalles de pedidos]
where IdPedido = 10248

--select * from [Detalles de pedidos]

/* Crea una
segunda consulta que tenga como origen la anterior y que sume las cantidades de cada
producto.*/
USE Neptuno
SELECT DISTINCT DetPd.IdProducto, SUM(Cantidad) As CantProducto
from [Detalles de pedidos] DetPd
GROUP by DetPd.IdProducto;
--QUE ME SELECCIONE LOS PEDIDOS CON IDproducto = ? sumar cantidad total pedida

USE Neptuno
SELECT DISTINCT detpd.idProducto,SUM(Cantidad) As CantProducto
from [Detalles de pedidos] DetPd
where IdProducto = 69
GROUP by DetPd.IdProducto;

/*El total de ventas. A partir de la consulta anterior.*/
USE Neptuno
--me devuelve el total de venta por cada idPedido
SELECT DISTINCT DetPd.IdPedido, sum (PrecioUnidad * Cantidad) As TotalVenta
from [Detalles de pedidos] DetPd
Group By DetPd.IDPedido;

USE Neptuno
SELECT sum (PrecioUnidad * Cantidad) As TotalVenta
from [Detalles de pedidos] 



