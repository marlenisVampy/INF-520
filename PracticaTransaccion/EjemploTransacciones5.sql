
/*Iniciamos la transaccion  */
BEGIN TRAN

UPDATE CUENTAS 
   SET saldo = 2700
 where NUMCUENTA = '200700000001' 
/*Iniciamos la transaccion interna*/
	BEGIN TRAN

	 UPDATE CUENTAS 
   SET saldo = 0
 where NUMCUENTA = '200700000001' 
-- Este COMMIT solo afecta a la segunda transaccion.
	COMMIT 

-- Este ROLLBACK afecta a las dos transacciones.
ROLLBACK 