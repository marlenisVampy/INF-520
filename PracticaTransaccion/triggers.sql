DROP TABLE TRANSACCIONES;
DROP TABLE CATALOGO_CUENTAS;

CREATE TABLE CATALOGO_CUENTAS (
    NOMBRE VARCHAR(30) PRIMARY KEY,
    TIPO VARCHAR(20),
    ORIGEN VARCHAR(20),
    BALANCE NUMERIC );

CREATE TABLE TRANSACCIONES (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE_CUENTA VARCHAR(30),
    DESCRIPCION VARCHAR(100),
    TIPO VARCHAR(20), -- Puede ser deudor o acreedor
    MONTO NUMERIC,

    FOREIGN KEY(NOMBRE_CUENTA) REFERENCES CATALOGO_CUENTAS(NOMBRE) );

-- Tabla para logs
drop table logger;
create table logger (
	id int primary key auto_increment,
    detalle varchar(50),
    numero numeric );
    --      credito | debito
-- Activo :    -    |   +
-- Pasivo :    +    |   -
-- Capital:    +    |   -

-- Triggers de TRANSACCIONES
DROP TRIGGER IF EXISTS INSERT_TRANSACCIONES;
DELIMITER //
CREATE TRIGGER INSERT_TRANSACCIONES BEFORE INSERT ON TRANSACCIONES
FOR EACH ROW
BEGIN
	DECLARE origen_cuenta varchar(20);
    DECLARE balance_cuenta numeric;
    DECLARE monto_total numeric;

    set origen_cuenta = (SELECT ORIGEN FROM CATALOGO_CUENTAS WHERE NOMBRE = NEW.NOMBRE_CUENTA);
    set balance_cuenta = (SELECT BALANCE FROM CATALOGO_CUENTAS WHERE NOMBRE = NEW.NOMBRE_CUENTA);


    IF origen_cuenta = "deudor" THEN
		IF NEW.TIPO = "debito" THEN
			set monto_total = balance_cuenta + NEW.MONTO;
		ELSE
			set monto_total = balance_cuenta - NEW.MONTO;
		END IF;
	ELSE
		IF NEW.TIPO = "debito" THEN
			set monto_total = balance_cuenta - NEW.MONTO;
		ELSE
			set monto_total = balance_cuenta + NEW.MONTO;
		END IF;
	END IF;

    UPDATE CATALOGO_CUENTAS SET BALANCE = monto_total
									WHERE NOMBRE = NEW.NOMBRE_CUENTA;

END; //
DELIMITER ;

-- Trigger para preevenir updates
DROP TRIGGER IF EXISTS UPDATE_TRANSACCIONES;
DELIMITER //
CREATE TRIGGER UPDATE_TRANSACCIONES BEFORE UPDATE ON TRANSACCIONES
FOR EACH ROW
BEGIN

	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se esta permitido updatear esta tabla.';

END; //
DELIMITER ;

-- Trigger para preevenir deletes
DROP TRIGGER IF EXISTS DELETE_TRANSACCIONES;
DELIMITER //
CREATE TRIGGER DELETE_TRANSACCIONES BEFORE DELETE ON TRANSACCIONES
FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT='No se esta permitido borrar registros de esta tabla.';
END; //
DELIMITER ;

-- Fin de los triggers

INSERT INTO TRANSACCIONES (NOMBRE_CUENTA, DESCRIPCION, TIPO, MONTO)
		VALUES ("Efectivo en caja", "Se metio dinero de nuevo", "debito", 12000);

INSERT INTO TRANSACCIONES (NOMBRE_CUENTA, DESCRIPCION, TIPO, MONTO)
		VALUES ("Efectivo en caja", "Se metio dinero de nuevo", "credito", 12000);

        INSERT INTO TRANSACCIONES (NOMBRE_CUENTA, DESCRIPCION, TIPO, MONTO)
			VALUES ("Cuentas por cobrar", "Se metio dinero de nuevo", "credito", 1500);

delete from transacciones where id = 9;
update transacciones set monto = 38000 where id = 9;

DELETE FROM TRANSACCIONES WHERE MONTO = 12000;

UPDATE TRANSACCIONES SET MONTO = 3 WHERE MONTO = 12000;

select * from catalogo_cuentas order by tipo;
select * from transacciones;
select * from logger;

update catalogo_cuentas set balance = 0 where nombre = "Efectivo en caja";
-- Nombre de las cuentas
-- Activos
insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values ("Efectivo en caja", "activo", "deudor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values ("Cuentas por cobrar", "activo","deudor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values ("Inventario de mercancias", "activo", "deudor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values ("Equipos de oficina", "activo", "deudor", 0);

-- Pasivos
insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Documentos por pagar", "pasivo", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Intereses por pagar", "pasivo", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Deposito de los clientes", "pasivo", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Impuestos por pagar", "pasivo", "acreedor", 0);


-- Capital
insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Capital Social", "capital", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Donaciones", "capital", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Reservas estatuarias", "capital", "acreedor", 0);

insert into catalogo_cuentas(nombre, tipo, origen, balance)
			values("Utilidades", "capital", "acreedor", 0);


            
