DECLARE @importe DECIMAL(18,2),
	    @CuentaOrigen VARCHAR(12),
	    @CuentaDestino VARCHAR(12)
/* Asignamos el importe de la transferencia
* y las cuentas de origen y destino */

SET @importe = 50 
SET @CuentaOrigen  = '200700000001'
SET @CuentaDestino = '200700000002'

/* Descontamos el importe de la cuenta origen */
UPDATE CUENTAS 
SET SALDO = SALDO - @importe
WHERE NUMCUENTA = @CuentaOrigen
  
/* Registramos el movimiento */

INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR, IMPORTE, FXMOVIMIENTO)
SELECT IDCUENTA, SALDO + @importe, SALDO, @importe, getdate()
  FROM CUENTAS
 WHERE NUMCUENTA = '200700000001'
 
/* Incrementamos el importe de la cuenta destino */
UPDATE CUENTAS  SET SALDO = SALDO + @importe
 WHERE NUMCUENTA = @CuentaDestino
 
/* Registramos el movimiento */

INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR, IMPORTE, FXMOVIMIENTO)
     SELECT IDCUENTA, SALDO - @importe, SALDO, @importe, getdate()
       FROM CUENTAS
      WHERE NUMCUENTA = @CuentaDestino
      
/*
Esta forma de actuar seria erronea, ya que cada instrucción se ejecutaria y confirmaría 
de forma independiente, por lo que un error dejaría los datos erroneos en la base de datos 
( ¡y ese es el peor error que nos podemos encontrar! )  
*/