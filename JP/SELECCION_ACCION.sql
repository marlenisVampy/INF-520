USE JURASSIC_PARK;


--EJERCICIOS CLASE 3 
--EJERCICIOS: INSERT 

--1. Inserte una nueva escuela. 
	
	--CORRESPONDE A UN DISTRITO ESCOLAR
	--SELECT * FROM JPESCDESM;
	
	INSERT INTO JPESCDESM VALUES (1, '10-01');
	
	INSERT INTO JPESCESCM(ESCESC_CODIGO, ESCESC_NOMBRE, ESCDES_CODIGO, ESCESC_CALLE, ESCESC_ALTURA) 
	VALUES(1, 'RAMON M. MELLA', 1, 'SANCHEZ', '20');
	
--2. Agregue un nuevo guía a la base. 
	SELECT * FROM JPRESGUIM;
	
	INSERT INTO JPRESGUIM VALUES (1, 'ALBERTO', 'ARREDONDO', 20000, 'VILLA MELLA');

--3. Inserte los datos de una escuela existente (nombre y domicilio) pero con un nuevo código. 
	
	--AQUI DA ERROR PORQUE NOMBRE ES UNIQUE
	INSERT INTO JPESCESCM VALUES(2, 'RAMON M. MELLA', 1, 'SANCHEZ', '20');

--4. Borre todos los teléfonos que se encuentren en la tabla telefono_Escuela e inserte para todas las escuelas cargadas el teléfono 1111-1111. 
	TRUNCATE TABLE JPESCTESD;
	
	--INSERT INTO JPESCTESD SELECT A.ESCESC_CODIGO, B.ESTO
	--	FROM JPESCESCM A, (VALUES('1111-1111') ESTO) B;
	
	SELECT * FROM JPESCESCM;
	INSERT INTO JPESCTESD VALUES (1, 11111111);
	
--Nota: los valores pueden tener '1111-1111' o 11111111, dependiendo el tipo de dato definido. En este caso, Telefono_Escuela puede ser CHAR o INTERGER. 

--EJERCICIOS: UPDATE 
--5. Actualice el teléfono de una de las escuelas por el número 5445-3223. 
	UPDATE JPESCTESD SET ESCTES_TELEFONO = 54453223 WHERE ESCESC_CODIGO = 1;
	
--6. Actualice la fecha de una reserva que usted seleccione por 23/12/2004 
	SELECT * FROM JPRESRESM;
	INSERT INTO JPRESRESM VALUES(1, '12/12/1999', '10:35', 1 );
	
	UPDATE JPRESRESM SET RESRES_FECHA_VIS_RES = '23/12/2004' WHERE RESRES_NUMERO = 1;

--7. Debe realizarse un descuento en el arancel por alumno de $2 para todas las 
--   reservas de más de 10 alumnos. 
	
	UPDATE A SET RESTVI_ARANCEL_POR_ALUMNO = RESTVI_ARANCEL_POR_ALUMNO * 0.98
	FROM JPRESTVIM A
	INNER JOIN JPRESRTVD B
		ON A.RESTVI_CODIGO = B.RESTVI_CODIGO
	WHERE B.RESRTV_CANT_ALUM_REAL > 10;


--8. Actualice el código de guía de las reservas que tengan asignado al guía 1 por el guía 2. 
	INSERT INTO JPRESGUIM VALUES (2, 'TOMAS', 'FERNANDEZ', 20000, 'VILLA MELLA');
	
	UPDATE JPRESRTVD SET RESGUI_CODIGO = 2 WHERE RESGUI_CODIGO = 1;

--EJERCICIOS: DELETE 
--9. Borre todas las reservas con menos de 10 Alumnos. 
	DELETE A FROM JPRESRESM A
		INNER JOIN JPRESRTVD B
			ON A.RESRES_NUMERO = B.RESRES_NUMERO
	WHERE B.RESRES_NUMERO < 10;


--10. Elimine a todos los guías que no tengan cargado su nombre. 

	DELETE FROM JPRESGUIM WHERE RESGUI_NOMBRES = '';

--EJERCICIOS: SELECT 
--11. Obtenga un listado de todos los guías de nombre Bernardo. 

	SELECT * FROM JPRESGUIM 
	WHERE UPPER(RESGUI_NOMBRES) LIKE '%ERT%';
	
	SELECT * FROM JPRESGUIM 
	WHERE UPPER(RESGUI_NOMBRES) LIKE '%BERNARDO%';

--12. Se desea obtener la cantidad de reservas con fecha mayor a 03/01/2004. 

	SELECT * FROM JPRESRESM WHERE RESRES_FECHA_VIS_RES > '03/01/2004';

--13. Se necesita conocer la cantidad total de alumnos reservados para cada reserva (agrupadas por reservas). 
	SELECT A.RESRES_NUMERO, SUM(B.RESRTV_CANT_ALUM_REAL) 'CANTIDAD' FROM JPRESRESM A
	INNER JOIN JPRESRTVD B
		ON A.RESRES_NUMERO = B.RESRES_NUMERO
	GROUP BY A.RESRES_NUMERO;

--14. Liste todas las reservas que posee una cantidad total de alumnos reservados mayor a 20. 
SELECT A.RESRES_NUMERO, B.RESRTV_CANT_ALUM_REAL 'CANTIDAD' FROM JPRESRESM A
	INNER JOIN JPRESRTVD B
		ON A.RESRES_NUMERO = B.RESRES_NUMERO AND B.RESRTV_CANT_ALUM_REAL > 20;
		
--15. Muestre las reservas realizadas en las cuales la inasistencia a las visitas sea mayor a 5. 

SELECT A.RESRES_NUMERO, B.RESRTV_CANT_ALUM_REAL 'CANTIDAD' FROM JPRESRESM A
	INNER JOIN JPRESRTVD B
		ON A.RESRES_NUMERO = B.RESRES_NUMERO 
		AND (B. RESRTV_CANT_ALUM_RES - B.RESRTV_CANT_ALUM_REAL > 5);


--16. Obtenga la cantidad de escuelas que visitarán el parque después del '3/6/2004'. 

SELECT COUNT(A.ESCESC_CODIGO) FROM JPESCESCM A
	INNER JOIN JPRESRESM B
		ON A.ESCESC_CODIGO = B.ESCESC_CODIGO AND B.RESRES_FECHA_VIS_RES > '3/6/2004';

--CLASE 3 - Adicionales 
--1. Insertar un nuevo guía con el número inmediato consecutivo al máximo existente. 

	INSERT INTO JPRESGUIM 
	VALUES (((SELECT COUNT(RESGUI_CODIGO) FROM JPRESGUIM) + 1), 'FATIMA', 'ALEGRE', 23000, 'ALMA ROSA' );
	
	
	SELECT * FROM JPRESGUIM;
--2. Insertar un nuevo tipo de visita con el número inmediato consecutivo al máximo existente sin utilizar subconsultas. 
	SELECT * FROM JPRESTVIM;
	INSERT INTO JPRESTVIM VALUES(1, 'ESTA ES LA PRIMERA', 100);
	
--3. Insertar los datos de la tabla escuela en una nueva tabla, borre los datos de la tabla escuela. 
--En la nueva tabla realice una actualización de los códigos de escuela incrementándolos en uno. 
--Posteriormente reinsértelos en la tabla escuela y vuelva a la normalidad los códigos. 

	SELECT * INTO ESCUELA_TEMPORAL FROM JPESCESCM;
	TRUNCATE TABLE JPESCESCM; -- ERROR DE FK
	UPDATE ESCUELA_TEMPORAL SET ESCESC_CODIGO = ESCESC_CODIGO + 1;
	INSERT INTO JPESCESCM SELECT * FROM ESCUELA_TEMPORAL; -- ERROR DE NOMBRE UNICO
	
--4. Las compañías telefónicas han decidido (por falta de números telefónicos!!), 
--que todas las líneas deben agregar un 9 como primer número. 
--Realice la actualización correspondiente en los teléfonos de las escuelas. 

	UPDATE JPESCTESD SET ESCTES_TELEFONO = 	'9' + ESCTES_TELEFONO;

--5. Debido a un feriado inesperado, las fechas de las visitas deben posponerse por un día. 
	UPDATE JPRESRESM SET RESRES_FECHA_VIS_RES = DATEADD(DAY, 1, RESRES_FECHA_VIS_RES);
	
--6. Obtener los datos de la última reserva existente. 
	SELECT RESRES_NUMERO, MAX(RESRES_FECHA_VIS_RES) A, RESRES_HORA_VIS_RES, ESCESC_CODIGO 
	FROM JPRESRESM 
	GROUP BY RESRES_NUMERO, RESRES_HORA_VIS_RES, ESCESC_CODIGO ;
	
--7. Obtener los apellidos de los guias que se encuentren repetidos. 
	SELECT RESGUI_APELLIDOS 'APELLIDOS REPETIDOS', COUNT(*)
	FROM JPRESGUIM 
	GROUP BY RESGUI_APELLIDOS HAVING COUNT(*) > 1;
	
--8. Obtener un listado con la cantidad de reservas por fecha. 
	SELECT COUNT(*) 'CANTIDAD', RESRES_FECHA_VIS_RES 'FECHA' 
	FROM JPRESRESM
		GROUP BY RESRES_FECHA_VIS_RES;

--9. Obtener el promedio de alumnos asistentes, reservados y la diferencia entre estos promedios. 

	SELECT AVG(RESRTV_CANT_ALUM_REAL) 'ASISTENTES', 
		   AVG(RESRTV_CANT_ALUM_RES) 'RESERVADOS',
		   AVG(RESRTV_CANT_ALUM_RES - RESRTV_CANT_ALUM_REAL) 'DIFERENCIA'
		 FROM JPRESRTVD;
		 
	SELECT * FROM JPRESRTVD;

--10. Obtener los guias que tengan más de 3 visitas 
	SELECT A.RESGUI_NOMBRES, A.RESGUI_APELLIDOS, COUNT(B.RESGUI_CODIGO) FROM JPRESGUIM A
	INNER JOIN JPRESRTVD B
		ON A.RESGUI_CODIGO = B.RESGUI_CODIGO
	GROUP BY A.RESGUI_NOMBRES, A.RESGUI_APELLIDOS
	HAVING COUNT(B.RESGUI_CODIGO) > 3;
