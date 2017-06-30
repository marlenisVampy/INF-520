--PracticaSql  Vistas Marlenis 

/*Crear una vista que permita visualizar todos los empleados con mas años de trabajo y los empleados con menos años trabajo. Use NorthWind*/

CREATE VIEW view_Emp_year_worked
AS
 select TOP (100) PERCENT EmployeeID 'Cod_emp', (FirstName + ','+LastName) 'Name',Title 'Cargo',
 HireDate 'fecha_ing',DATEDIFF(YEAR,HireDate,getDate()) 'Años Trabajados'
 from Employees
 Order by [Años Trabajados] DESC
 
 SELECT * FROM view_Emp_year_worked

 /*Crear una vista que permita visualizar los 2 empleados con mayor cantidad de facturas emitidas Select * from vw_FacturasEmpleados.Neptuno*/

 Create View view_topDos_maxFacturas_empleados
as
Select Top(2) Ped.IdEmpleado 'Cod_emp',(emp.Nombre + ','+emp.Apellidos) 'Name', COUNT(Ped.IdPedido)'#Facturas'
from Pedidos Ped 
Inner join  Empleados emp
On ped.IdEmpleado = emp.IdEmpleado
Group by ped.IdEmpleado,emp.Nombre,emp.Apellidos
Order by COUNT(Ped.IdPedido) Desc	

select * from view_topDos_maxFacturas_empleados

/*Crear un vista que permita visualizar todas las facturas de los empleados cuyo apellido materno inicie con la
letra A.*/

CREATE VIEW view_PEDIDOS_TOTALES_EMPLEADOS_A
AS
select Distinct  Ped.IdPedido 'Num_fact', Ped.IdEmpleado 'Cod_emp',
 Sum(PrecioUnidad * Cantidad) 'TOTAL'
 from Pedidos ped
 inner join [Detalles de pedidos] det
 on Ped.IdPedido = det.IdPedido
 
 Inner Join Empleados emp
 On emp.IdEmpleado = ped.IdEmpleado
 Where emp.Apellidos Like 'A%' 
 group by Ped.IdPedido,Ped.IdEmpleado
 
 Select * from view_PEDIDOS_TOTALES_EMPLEADOS_A

 /*Crear una vista que permita visualizar el producto con mayor y menor cantidad vendida de todas las facturas.
Select * from vw_ProductosVendidos*/

/*Cree una vista que permita visualizar el horario de trabajo del empleado 'E0001' y su codigo de hora '01'que es
= (08:00-18:00) Tablas(empleado,empl_hor,dias).*/



---------------------------------------------------------------

/*Crear una vista que permita visualizar los 2 empleados con mayor cantidad 
de Pedidos. (usar tablas Empleados y Pedidos)*/

/*Crear una vista que permita visualizar todos productos por Proveedor.(Usar tablas Proveedores
y Productos)*/ 
Create View  view_Productos_Proveedores
As
Select Prov.IdProveedor,Prov.Nombrecompañía,Prod.IdProducto,
Prod.NombreProducto,CASE Suspendido
 WHEN 0 Then 'No Suspendido'
 When 1 Then 'Suspendido'
 Else 'No se'
End As Suspendido
from Proveedores Prov 
Inner Join Productos Prod
On Prov.IdProveedor =Prod.IdProveedor

Select * from view_Productos_Proveedores


/*Crear una vista que permita visualizar los datos del empleado mas joven. (Usar tabla
Empleados)*/

Create View view_Empleado_masJoven
As
Select Top(1)Emp.IdEmpleado,(emp.Apellidos + ','+emp.Nombre) 'Nombre',
MIN(DATEDIFF(YEAR,FechaNacimiento,getDate())) As Edad
From Empleados Emp
Group by Emp.IdEmpleado,emp.Apellidos,emp.Nombre
Order by Edad Asc

Select * from view_Empleado_masJoven

/*Crear una vista que permita visualizar todos los empleados con mas años de trabajo y los
empleados con menor años trabajo. (Usar tabla Empleados) Usar subconsulta.*/

/*Crear una vista que permita visualizar los productos y su categoria, cuya unidad de precio sea
mayor al promedio de precios de unidad. ( Usar tablas Categorias y Productos) Usar
subconsulta.*/

-----------------------------------------------------------------


