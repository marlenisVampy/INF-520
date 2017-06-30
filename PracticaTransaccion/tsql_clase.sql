-- Esto es un comentario de linea simple


/* 
Este es un comentario con varias líneas.
Conjunto de Lineas.
*/
declare @nombre varchar(50)-- declare declara una variable
                           -- @nombre es el identificador de la
                           -- variable de tipo varchar
set @nombre = 'Pedro Perez' -- El signo = es un operador
                                 --  es un literal
print @Nombre -- Imprime por pantalla el valor de @nombre. 
              -- No diferencia mayúsculas ni minúsculas
              DECLARE @nombre VARCHAR(100)

-- La consulta debe devolver un único registro

SET @nombrex =  (SELECT nombre 

		FROM CLIENTES

		WHERE ID = 1)

PRINT @nombre 

--Ejemplo de asignacion de valores usando SELECT

DECLARE @idCategoria int,
		@nombreCat VARCHAR(100),
	    @Descripción VARCHAR(100)

	SELECT  @idCategoria=IdCategoría,
			@nombreCat=NombreCategoría , 
			@Descripción=Descripción
	 from Categorias
--where IdCategoría = 1
PRINT @idCategoria
PRINT @nombreCat
PRINT @Descripción
--Ejemplo usando cursores

DECLARE @idCategoria int,
		@nombreCat VARCHAR(100),
	    @Descripción VARCHAR(100)

DECLARE CDATOS CURSOR 
    FOR
 SELECT IdCategoría,
	    NombreCategoría , 
	    Descripción
   from Categorias

 OPEN CDATOS
FETCH CDATOS INTO @idCategoria,@nombreCat,@Descripción

 WHILE (@@FETCH_STATUS = 0)
 BEGIN
	PRINT @idCategoria
	PRINT @nombreCat
	PRINT @Descripción

	FETCH CDATOS INTO @idCategoria,@nombreCat,@Descripción

END
CLOSE CDATOS
DEALLOCATE CDATOS 
 
-- Uso de if
 DECLARE @Web varchar(100),
         @diminutivo varchar(5)
    
    SET @diminutivo = 'UASD'
    
    IF  @diminutivo = 'UASD'
        BEGIN
            PRINT 'www.uasd.edu.do'
            PRINT 'Pagina web de la Universidad Autonoma De Santo Domingo'
        END
    ELSE
     	BEGIN
            PRINT 'Otra Web (De cualquier otra universidad!)'  
     	END 
     	
 -- Uso de if con subconsultas
DECLARE @idCategoria int,
		@descripcion VARCHAR(100)
set @idCategoria = 6
set @descripcion = 'Carnes preparadas'

IF EXISTS(SELECT * 
            from Categorias
            where IdCategoría = @idCategoria) 
  BEGIN
	UPDATE Categorias
	   SET Descripción = @descripcion
	 WHERE IdCategoría = @idCategoria
  END

ELSE
  BEGIN
	INSERT INTO Categorias(IdCategoría, Descripción) 
	     VALUES (@idCategoria, @descripcion)
  END
  
DECLARE @Web varchar(100),
        @diminutivo varchar(4)
        
    SET @diminutivo = 'UASD'
    SET @Web = (CASE @diminutivo
                    WHEN 'UASD' THEN 'www.uasd.edu.do'
                    WHEN 'ALM'  THEN 'www.aleamedia.com'
                    ELSE 'www.otraweb.com'
                END)
    PRINT @Web 
    
 DECLARE @Web varchar(100),
        @diminutivo varchar(4)
        
    SET @diminutivo = 'UASD'
    SET @Web = (CASE 
                    WHEN @diminutivo = 'UASD' THEN 'www.uasd.edu.do'
                    WHEN @diminutivo = 'ALM'  THEN 'www.aleamedia.com'
                    ELSE 'www.otraweb.com'
                END)
    PRINT @Web
     
    DECLARE @categoriaID int,
            @nombreCategoria varchar(20)
    SET  @categoriaID = 6
 
    SET @nombreCategoria = (CASE 
							WHEN @categoriaID = 1 THEN ( select NombreCategoría 
														   from Categorias
														   where IdCategoría = 1)
							WHEN @categoriaID = 3 THEN ( select NombreCategoría 
														   from Categorias
														   where IdCategoría = 3)
							WHEN @categoriaID = 6 THEN ( select NombreCategoría 
														   from Categorias
														   where IdCategoría = 6)							   
							ELSE 'otra categoria no registrada'
                END)
    PRINT @nombreCategoria
    
    
    
  select * 
    from Categorias
    
    DECLARE @contador int
    SET @contador = 0
    WHILE (@contador < 100)
    BEGIN
     	SET @contador = @contador + 1
		IF (@contador > 10 and @contador < 15)
       	   CONTINUE
    	PRINT 'Iteracion del bucle ' + cast(@contador AS varchar)
    	
    END
    
    
    
DECLARE @divisor int, 
            @dividendo int, 
            @resultado int
    SET @dividendo = 100
    SET @divisor = 0
    SET @resultado = @dividendo/@divisor            
    
    IF @@ERROR > 0 
        GOTO error
        
    PRINT 'No hay error'
    RETURN
error:
    PRINT 'Se ha producido una division por cero'
    
    
  BEGIN TRY
     DECLARE @divisor int , 
     	     @dividendo int, 
             @resultado int
     SET @dividendo = 100
     SET @divisor = 0
     -- Esta linea provoca un error de division por 0
     SET @resultado = @dividendo/@divisor
     PRINT 'No hay error'
 END TRY
 BEGIN CATCH
     PRINT 'Numero del error....: ' +convert(varchar(20),ERROR_NUMBER() )
     PRINT 'Severidad del error.: ' +convert(varchar(20),ERROR_SEVERITY())    
     PRINT 'Estado del error....: ' +convert(varchar(20),ERROR_STATE())  
     PRINT 'Procedure del error.: ' +convert(varchar(20),ERROR_PROCEDURE())   
     PRINT 'Linea del error.....: ' +convert(varchar(20),ERROR_LINE())
     PRINT 'Mensaje de. error...: ' +convert(varchar(20),ERROR_MESSAGE())  
 END CATCH 
 
 
 
o