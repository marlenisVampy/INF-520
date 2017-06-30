--4. Crea las siguientes consultas en la base de datos Neptuno

/*Nombre y apellidos de cada empleado y el total de lo que ha vendido. 
Con la base de datos inicial tienes que obtener este resultado:*/
-------------------------------------------
USE Neptuno
SELECT distinct Ped.IdEmpleado,SUM(detPed.PrecioUnidad *detPed.Cantidad) as TotalVenta
FROM Pedidos Ped 
INNER JOIN [Detalles de pedidos] detPed
ON Ped.IdPedido = detPed.idPedido 
group by Ped.IdEmpleado

-----------------------------------------------------------------

USE Neptuno
SELECT emp.Nombre,emp.Apellidos,SUM(detPed.PrecioUnidad *detPed.Cantidad) as TotalVenta
FROM Pedidos Ped 
INNER JOIN [Detalles de pedidos] detPed
ON Ped.IdPedido = detPed.idPedido 
INNER JOIN Empleados Emp
on Ped.IdEmpleado = Emp.IdEmpleado
group by Nombre,Apellidos

-----------------------------------------------

use Neptuno
select * from Empleados;

use Neptuno
select * from [Totales de ventas por cantidad];

use Neptuno
select * from Pedidos;

use Neptuno
select * from Facturas;

use Neptuno
select * from CLIENTES;

use Neptuno
select * from [Detalles de pedidos];
------------------------------------------------------
/*Informaci�n detallada de cada art�culo de cada pedido: nombre del cliente, fecha,
nombre del producto, precio, unidades, coste (precio por unidades), IVA (16% del
coste) y total (coste m�s IVA). Ordenado por clientes (y agrupado) por fecha).*/

USE Neptuno
Select CLI.NombreCompa��a,P.FechaPedido,
PROD.NombreProducto,PROD.PrecioUnidad,
DETPD.CANTIDAD,(PROD.PrecioUnidad * DETPD.Cantidad) AS COSTE,
(0.16 * (PROD.PrecioUnidad * DETPD.Cantidad)) AS IVA,
((PROD.PrecioUnidad * DETPD.Cantidad) + (0.16 * (PROD.PrecioUnidad * DETPD.Cantidad))) AS TOTAL
from [Detalles de pedidos] DETPD

INNER JOIN Productos PROD ON DETPD.IdProducto = PROD.IdProducto
INNER JOIN PEDIDOS P ON  DETPD.IdPedido = P.IdPedido 
INNER JOIN Clientes CLI ON CLI.IdCliente = P.IdCliente 

GROUP BY PROD.NombreProducto,CLI.NombreCompa��a,FECHAPEDIDO,PROD.PrecioUnidad,
DETPD.CANTIDAD
ORDER BY CLI.NombreCompa��a

/*Modifica la consulta anterior para que se muestren los costes totales de
 las compras de cada d�a:*/
USE Neptuno
Select DISTINCT P.FechaPedido,CLI.NombreCompa��a,
SUM(PROD.PrecioUnidad * DETPD.Cantidad) AS TotalCOSTE,
sum(0.16 * (PROD.PrecioUnidad * DETPD.Cantidad)) AS TotalIVA,
SUM((PROD.PrecioUnidad * DETPD.Cantidad) + (0.16 * (PROD.PrecioUnidad * DETPD.Cantidad))) AS TOTAL
from [Detalles de pedidos] DETPD

INNER JOIN Productos PROD ON DETPD.IdProducto = PROD.IdProducto
INNER JOIN PEDIDOS P ON  DETPD.IdPedido = P.IdPedido 
INNER JOIN Clientes CLI ON CLI.IdCliente = P.IdCliente 
--where Cli.NombreCompa��a = 'Alfreds Futterkiste'
GROUP BY P.FechaPedido,CLI.NombreCompa��a
ORDER BY P.FechaPedido asc,Cli.NombreCompa��a asc 