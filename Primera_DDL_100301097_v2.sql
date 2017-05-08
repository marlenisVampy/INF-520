/*1. Crear una base de datos de nombre Jurassic_Park sin especificar los valores de la base*/

CREATE DATABASE JURASSIC_PARK

/*2. Crear la tabla Escuela y definir su clave principal en la misma instrucción
 de creación. Continuar con tablas Guia, Reserva y Tipo_Visita. */
 
CREATE TABLE JURASSIC_PARK.DBO.ESCUELA
(CODIGO_ESCUELA INT NOT NULL CONSTRAINT pk_cod_escuela PRIMARY KEY,
NOMBRE_ESCUELA VARCHAR(70) NOT NULL,
DOMICILIO_ESCUELA VARCHAR(70)
);

CREATE TABLE JURASSIC_PARK.DBO.GUIA
(CODIGO_GUIA INT NOT NULL CONSTRAINT pk_cod_guia PRIMARY KEY,
NOMBRE_GUIA VARCHAR(70) ,
APELLIDO_GUIA VARCHAR(70)
);
--DROP TABLE JURASSIC_PARK.DBO.GUIA

CREATE TABLE JURASSIC_PARK.DBO.RESERVA
(NUMERO_RESERVA INT NOT NULL CONSTRAINT pk_cod_res PRIMARY KEY,
FECHA_VISITA_RESERVADA VARCHAR(70) NOT NULL,
HORA_VISITA_RESERVADA VARCHAR(70) NOT NULL,
CODIGO_ESCUELA INT NOT NULL,
CONSTRAINT fk_res_codEsc FOREIGN KEY ( CODIGO_ESCUELA ) REFERENCES ESCUELA ( CODIGO_ESCUELA )
);

/*arreglar tipo de dato a fecha y hora visita reservada*/
ALTER TABLE JURASSIC_PARK.DBO.RESERVA
ALTER COLUMN FECHA_VISITA_RESERVADA DATE;

ALTER TABLE JURASSIC_PARK.DBO.RESERVA
ALTER COLUMN HORA_VISITA_RESERVADA TIME;

CREATE TABLE JURASSIC_PARK.DBO.TIPO_VISITA
(CODIGO_TIPO_VISITA INT NOT NULL CONSTRAINT pk_cod_tipVis PRIMARY KEY,
DESCRIPCION_TIPO_VISITA VARCHAR(80) NOT NULL,
ARANCEL_POR_ALUMNO DECIMAL(10,2) NOT NULL

);

/*3. Crear la tabla Telefono_Escuela con su clave principal.
 (hacer restricción en caso de ser una CP compuesta). */
 
CREATE TABLE JURASSIC_PARK.DBO.TELEFONO_ESCUELA
(CODIGO_ESCUELA INT NOT NULL,
TELEFONO_ESCUELA VARCHAR(15) NOT NULL,
CONSTRAINT fk_tel_codEsc FOREIGN KEY ( CODIGO_ESCUELA ) REFERENCES ESCUELA ( CODIGO_ESCUELA ),
PRIMARY KEY(CODIGO_ESCUELA,TELEFONO_ESCUELA)
);

--DROP TABLE JURASSIC_PARK.DBO.TELEFONO_ESCUELA;
--CONSTRAINT fk_tel_codEsc FOREIGN KEY ( CODIGO_ESCUELA ) REFERENCES ESCUELA ( CODIGO_ESCUELA )

/*4. Crear la tabla Reserva_Por_Grado con su clave principal.
 Hacer las correspondientes restricciones. */
 
 CREATE TABLE JURASSIC_PARK.DBO.RESERVA_POR_GRADO
(
 NUMERO_RESERVA INT, 
 CODIGO_TIPO_VISITA INT,
 GRADO INT,
CONSTRAINT fk_regrado_codRes FOREIGN KEY (NUMERO_RESERVA ) 
REFERENCES JURASSIC_PARK.DBO.RESERVA( NUMERO_RESERVA ),

CONSTRAINT fk_tipvgrado_codtipv FOREIGN KEY (CODIGO_TIPO_VISITA) 
REFERENCES JURASSIC_PARK.DBO.TIPO_VISITA( CODIGO_TIPO_VISITA ),
PRIMARY KEY(NUMERO_RESERVA,CODIGO_TIPO_VISITA,GRADO)
);
/*5. Crear la tabla Reserva_Tipo_Visita con
 sus campos propios y los referenciados. Sin generar claves*/
 
  CREATE TABLE JURASSIC_PARK.DBO.RESERVA_TIPO_VISITA
(
 NUMERO_RESERVA INT NOT NULL, 
 CODIGO_TIPO_VISITA INT NOT NULL,
 CANTIDAD_ALUMNOS_RESERVADOS INT,
 CANTIDAD_ALUMNOS_REALES INT,
 CODIGO_GUIA INT, 
CONSTRAINT fk_reTV_NUMR FOREIGN KEY (NUMERO_RESERVA ) 
REFERENCES JURASSIC_PARK.DBO.RESERVA( NUMERO_RESERVA ),
CONSTRAINT fk_REtipv_codtipv FOREIGN KEY (CODIGO_TIPO_VISITA) 
REFERENCES JURASSIC_PARK.DBO.TIPO_VISITA( CODIGO_TIPO_VISITA ),
CONSTRAINT fk_REtipv_codGUIA FOREIGN KEY (CODIGO_GUIA) 
REFERENCES JURASSIC_PARK.DBO.GUIA(CODIGO_GUIA ),
--PRIMARY KEY(NUMERO_RESERVA,CODIGO_TIPO_VISITA)
);

DROP TABLE JURASSIC_PARK.DBO.RESERVA_TIPO_VISITA;

/*6. Completar el ejercicio anterior, con la creación de las claves correspondientes. */
ALTER TABLE JURASSIC_PARK.DBO.RESERVA_TIPO_VISITA
ADD CONSTRAINT pk_RESTIPVIS PRIMARY KEY (NUMERO_RESERVA, CODIGO_TIPO_VISITA)

/*7. Añadir a la tabla de Guía la columna sueldo_hora. 
Nota: En SQL Server no es necesario agregar COLUMN. */

ALTER TABLE JURASSIC_PARK.DBO.GUIA
ADD SUELDO_HORA DECIMAL(5,2);

/*8. Hacer que no puedan haber dos escuelas con el mismo nombre. */

ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
ADD UNIQUE (NOMBRE_ESCUELA);

/*1. Crear la tabla Distrito_Escolar con su correspondiente CP. */

CREATE TABLE JURASSIC_PARK.DBO.DISTRITO_ESCOLAR
(CODIGO_DISTRITO_ESCOLAR INT NOT NULL CONSTRAINT pk_cod_DISt_esc PRIMARY KEY,
NOMBRE_DISTRITO_ESCOLAR VARCHAR(70) NOT NULL,
);

/*2. Agregar clave foránea codigo_distrito_escolar a la tabla Escuela */
ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
ADD CODIGO_DISTRITO_ESCOLAR INT;

ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
ADD FOREIGN KEY (CODIGO_DISTRITO_ESCOLAR) REFERENCES
 JURASSIC_PARK.DBO.DISTRITO_ESCOLAR(CODIGO_DISTRITO_ESCOLAR);

/*3. Eliminar la columna de domicilios de la tabla Escuela. */
ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
DROP COLUMN DOMICILIO_ESCUELA


/*4. Agregar columnas calle_escuela y altura_escuela a la tabla Escuela. */

ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
ADD CALLE_ESCUELA VARCHAR(15);

ALTER TABLE JURASSIC_PARK.DBO.ESCUELA
ADD ALTURA_ESCUELA INT;

/*5. Agregar domicilio_guia en tabla Guia. */
ALTER TABLE JURASSIC_PARK.DBO.GUIA
ADD DOMICILIO_GUIA VARCHAR(50);

/*6. Eliminar tabla Telefono_Escuela */
	DROP TABLE JURASSIC_PARK.DBO.TELEFONO_ESCUELA;
/*
7. Agregar tabla Email_Escuela (sin Clave primaria) */

CREATE TABLE JURASSIC_PARK.DBO.EMAIL_ESCUELA
(
DESCRIPCION_EMAIL_ESCUELA VARCHAR(70) NOT NULL
);
DROP TABLE JURASSIC_PARK.DBO.EMAIL_ESCUELA

/*8. Establecer clave primaria para Email_Escuela */

ALTER TABLE JURASSIC_PARK.DBO.EMAIL_ESCUELA
ADD CODIGO_EMAIL_ESCUELA INT not null

/*ALTER TABLE JURASSIC_PARK.DBO.EMAIL_ESCUELA
DROP COLUMN CODIGO_EMAIL_ESCUELA*/

ALTER TABLE JURASSIC_PARK.DBO.EMAIL_ESCUELA
ADD CONSTRAINT PK_CODEmailEsc PRIMARY KEY (CODIGO_EMAIL_ESCUELA)

/*9. Establecer que los nombres y apellidos de los guias no tengan valores nulos. nulos. */


ALTER TABLE [Table] ALTER COLUMN [Column] INTEGER NOT NULL;

ALTER TABLE JURASSIC_PARK.DBO.GUIA ALTER COLUMN NOMBRE_GUIA VARCHAR(70) NOT NULL;
ALTER TABLE JURASSIC_PARK.DBO.GUIA ALTER COLUMN APELLIDO_GUIA VARCHAR(70) NOT NULL;

/*10. Establecer que no se repita la calle y la altura de las escuelas. */
ALTER TABLE JURASSIC_PARK.DBO.ESCUELA

ADD CONSTRAINT UC_ESCUELA UNIQUE (CALLE_ESCUELA,ALTURA_ESCUELA);