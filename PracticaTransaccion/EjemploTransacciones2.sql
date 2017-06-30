DECLARE @importe DECIMAL(18,2),
	    @CuentaOrigen VARCHAR(12),
 	    @CuentaDestino VARCHAR(12),
 	    @varibleError DECIMAL(18,2)

/* Asignamos el importe de la transferencia
   y las cuentas de origen y destino
*/
SET @importe = 50 
SET @CuentaOrigen = '200700000002'
SET @CuentaDestino = '200700000001'

BEGIN TRANSACTION -- O solo BEGIN TRAN 
/* Iniciamos un bloque try de manera tal que si ocurre un error, la transaccion sea reversada*/
BEGIN TRY
/* Descontamos el importe de la cuenta origen */

	UPDATE CUENTAS 
	   SET SALDO = SALDO - @importe
	 WHERE NUMCUENTA = @CuentaOrigen
	/* Registramos el movimiento  tomando los valores de la tabla cuenta actualizada enteriormente*/
	INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR,IMPORTE, FXMOVIMIENTO)
					 SELECT  IDCUENTA, SALDO + @importe, SALDO, @importe, getdate()
					   FROM CUENTAS
					  WHERE NUMCUENTA = @CuentaOrigen
/*Esta linea se escribe para generar un error  */					  
--SET @varibleError = @importe/0

/* Incrementamos el importe de la cuenta destino */
	UPDATE CUENTAS 
	   SET SALDO = SALDO + @importe
	 WHERE NUMCUENTA = @CuentaDestino
	/* Registramos el movimiento */
	INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR,IMPORTE, FXMOVIMIENTO)
					 SELECT  IDCUENTA, SALDO - @importe, SALDO, @importe, getdate()
					   FROM CUENTAS
					  WHERE NUMCUENTA = @CuentaDestino
	/* Confirmamos la transaccion*/ 
	COMMIT TRANSACTION -- O solo COMMIT
END TRY
BEGIN CATCH
/* Hay un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION -- O solo ROLLBACK
	PRINT 'Se ha producido un error!'
END CATCH