--create DataBase Jurassic_Park

Create table Escuelas
(Codigo_Escuela char (10) primary key,
 Nombre_Escuela varchar (30) not null ,
 Domicilio_Escuela varchar (50) not null);

Create table Telefono_Escuelas
(Telefono_Escuela varchar (10) not null,
Codigo_Escuela char (10), foreign key (Codigo_Escuela) references Escuelas (Codigo_Escuela));
 
Create table Reservas
(Numero_Reserva char (6) primary key,
Fecha_Visita_Reservada date,
Hora_Visita_Reservada time,
Codigo_Escuela char(10) foreign key (Codigo_Escuela) references Escuelas (Codigo_Escuela));
 
Create table Tipo_Visitas (
Codigo_Tipo_Visita char (10) primary key,
Descripcion_Tipo_Visita varchar (50) not null,
Arancel_Por_Alumno float(8) not null);

Create Table Reserva_Tipo_Visitas
(Cantidad_Alumnos_Reservados integer not null,
Cantidad_Alumnos_Reales integer not null, 
Codigo_Guia char (10),
Codigo_Tipo_Visita char (10),
Numero_Reserva char (6),  
foreign key (Codigo_Guia) references Guias (Codigo_Guia),
foreign key (Codigo_Tipo_Visita) references Tipo_Visitas (Codigo_Tipo_Visita),
foreign key (Numero_Reserva) references Reservas (Numero_Reserva));

Create Table Guias
(Codigo_Guia char (10) primary key,
Nombre_Guia varchar (20) not null,
Apellido_Guia varchar (30) not null);


Create Table Reserva_Por_Grado
(Grado varchar (5),
Numero_Reserva char (6),
Codigo_Tipo_Visita char (10),
foreign key (Numero_Reserva) references Reservas (Numero_Reserva),
foreign key (Codigo_Tipo_Visita) references Tipo_Visitas (Codigo_Tipo_Visita));

--select * from Reservas
--alter table Guias Drop column Sueldo_Hora;

alter table Guias add Sueldo_Hora float (10) not null;

--select * from Guias

ALTER TABLE Escuelas ADD CONSTRAINT const_Not_Duplicate UNIQUE (Nombre_Escuela);

Create Table Distrito_Escolar
(ID_Distrito_Escuela varchar (10) primary key,
Nombre_Distrito varchar (20) not null);

Alter table Escuelas add ID_Distrito_Escuela varchar (10) unique;
Alter table Escuelas add constraint Codigo_Distrito_Escolar_FK  foreign key (ID_Distrito_Escuela) references Distrito_Escolar(ID_Distrito_Escuela);
Alter table Escuelas Drop column Domicilio_Escuela;
Alter table Escuelas add Calle_Escuela varchar (20) not null;
Alter table Escuelas add Altura_Escuela varchar(10) not null; 
Alter table Guias add Domicilio_Guia varchar (20) not null;
drop table Telefono_Escuelas;

Create Table Email_Escuelas
(Nombre_Email varchar (30) not null,
Codigo_Escuela char (10) not null,
 foreign key (Codigo_Escuela) references Escuelas (Codigo_Escuela));

 Alter table Email_Escuelas add constraint Nombre_Email_Escuela_PK primary key (Nombre_Email);

 ALTER TABLE Escuelas ADD CONSTRAINT const_Not_Duplicate_Escuela_CE_AE UNIQUE (Calle_Escuela, Altura_Escuela);
 /*Practica Numero 3*/
 Create Unique Index IN_Reserva_Codigo_Escuela
 on Reservas (codigo_escuela);

 Drop Index Reservas.IN_Reserva_Codigo_Escuela;
 Select * from Reservas
 Set Statistics IO Off

 Create CLUSTERED Index IN_Reserva_Visita
 on Reserva_Tipo_Visitas (Cantidad_Alumnos_Reservados);

 Create Clustered Index IN_Guia_Nom_Ape
 on Guias(Nombre_Guia, Apellido_Guia);



 CREATE LOGIN jPerez  
    WITH PASSWORD = '123456';  
GO  
CREATE USER jPerez FOR LOGIN jPerez;  
GO  

CREATE LOGIN aFernandez
    WITH PASSWORD = '123456';  
GO  
CREATE USER aFernandez FOR LOGIN aFernandez;  
GO  
 
 Grant insert on Telefono_Escuelas to jPerez, aFernandez;
 Grant Update on Telefono_Escuelas to jPerez, aFernandez;

 Revoke update on Telefono_Escuelas to jPerez, aFernandez;

 Grant Create Table to jPerez;
  Revoke Select on Escuelas to jPerez;

  Drop Index Guias.IN_Guia_Nom_Ape;

  CREATE LOGIN CORDOBA
    WITH PASSWORD = '123456';  
GO  
CREATE USER CORDOBA FOR LOGIN CORDOBA;  
GO  

  Grant Select on Reserva_Tipo_Visitas to CORDOBA;

