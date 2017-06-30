BEGIN TRAN 

	UPDATE CUENTAS 
       SET saldo = 1700
     where NUMCUENTA = '200700000001' 

	UPDATE CUENTAS 
       SET saldo = 2700
     where NUMCUENTA = '200700000001' 

SAVE TRANSACTION P1 -- Guardamos la transaccion (Savepoint)

	UPDATE CUENTAS 
       SET saldo = 0
     where NUMCUENTA = '200700000001' 

-- Este ROLLBACK afecta solo a las instrucciones posteriores al savepoint P1.

ROLLBACK TRANSACTION P1

-- Confirmamos la transaccion

COMMIT