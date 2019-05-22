
--- Laboratorio 3
USE Pedidos;
-- 1. Añadir columna a la tabla movmientos.PEDIDO
ALTER TABLE movimientos.PEDIDO 
ADD TipoPed varchar(10) null;
SELECT * FROM movimientos.PEDIDO;

-- TipoPed: crédito / efectivo
-- 2.
-- Problemas que pueden ocurrir:
/*
Productos ligados a fabricas que no existen
Porque la tablas no cuentan con claves foráneas


*/

-- 3- Añadiendo claves foráneas
alter table catalogo.CLIENTE
   add constraint FK_CLIENTE_RELATIONS_CIUDAD foreign key (ID_CIUDAD)
      references catalogo.CIUDAD (ID_CIUDAD)
go

alter table catalogo.CLIENTE
   add constraint FK_CLIENTE_RELATIONS_CLIENTE foreign key (GARANTE)
      references catalogo.CLIENTE (NUMERO_CLIENTE)
go

alter table movimientos.DETALLE_PEDIDO
   add constraint FK_DETALLE__RELATIONS_PEDIDO foreign key (ID_PEDIDO)
      references movimientos.PEDIDO (ID_PEDIDO)
go

alter table movimientos.DETALLE_PEDIDO
   add constraint FK_DETALLE__RELATIONS_PRODUCTO foreign key (ID_PRODUCTO)
      references catalogo.PRODUCTO (ID_PRODUCTO)
go


alter table movimientos.INSUMOS
   add constraint FK_INSUMOS_RELATIONS_FABRICA foreign key (NUMERO_DE_LA_FABRICA)
      references catalogo.FABRICA (NUMERO_DE_LA_FABRICA)
go

alter table movimientos.INSUMOS
   add constraint FK_INSUMOS_RELATIONS_PRODUCTO foreign key (ID_PRODUCTO)
      references catalogo.PRODUCTO (ID_PRODUCTO)
go

alter table movimientos.PEDIDO
   add constraint FK_PEDIDO_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references catalogo.CLIENTE (NUMERO_CLIENTE)
go

alter table catalogo.TELEFONO
   add constraint FK_TELEFONO_RELATIONS_FABRICA foreign key (NUMERO_DE_LA_FABRICA)
      references catalogo.FABRICA (NUMERO_DE_LA_FABRICA)
go


-- 4. Check para validar crédito o contado
ALTER TABLE movimientos.PEDIDO
ADD CONSTRAINT CHK_TipoPed CHECK (TipoPed='Credito' OR TipoPed='Contado');

SELECT * FROM movimientos.PEDIDO_DETALLEPEDIDO;

-- 5. Trigger para actualizar total en movimientos.Pedido
/*
-- Tablas de prueba:
create table movimientos.PEDIDO2 ( 
   ID_PEDIDO            varchar(3)           not null, 
   FECHA_DE_PEDIDO      Datetime	         null, 
   TOTAL                decimal(10,2)        null, 
   ID_CLIENTE           varchar(3)           not null, 
)
create table movimientos.DETALLE_PEDIDO2 ( 
   NUMERO_LINEA         smallint             not null, 
   PRECIO_UNITARIO      decimal(7,2)         null, 
   CANTIDAD             smallint             null, 
   ID_PEDIDO            varchar(3)           not null, 
   ID_PRODUCTO          varchar(3)           not null, 
)

ALTER TABLE movimientos.PEDIDO2 
ADD TipoPed varchar(10) null;

DELETE FROM movimientos.PEDIDO2
INSERT INTO movimientos.PEDIDO2 
SELECT * FROM movimientos.PEDIDO;
SELECT * FROM movimientos.PEDIDO2
INSERT INTO movimientos.DETALLE_PEDIDO2
SELECT * FROM movimientos.DETALLE_PEDIDO;
SELECT * FROM movimientos.DETALLE_PEDIDO2;
*/

-- Trigger, AFTER INSERT 
USE Pedidos
SELECT  
name,object_id,
is_instead_of_trigger
FROM 
sys.triggers;

GO
CREATE TRIGGER TR_UPDATE_TOTAL_INS
ON movimientos.[DETALLE_PEDIDO2]
AFTER INSERT
AS
DECLARE @DEUDA decimal(10,2)
DECLARE @ID_DEUDOR varchar(3)
	BEGIN	 
		-- Actualiza el total
		SET @DEUDA =(
			SELECT SUM(d.PRECIO_UNITARIO)
			FROM movimientos.DETALLE_PEDIDO2 d, inserted I
			WHERE d.ID_PEDIDO = I.ID_PEDIDO);
		UPDATE	movimientos.PEDIDO2
		SET TOTAL =	 @DEUDA
		/*	(SELECT SUM(d.PRECIO_UNITARIO)
			FROM movimientos.DETALLE_PEDIDO2 as d
			WHERE d.ID_PEDIDO = I.ID_PEDIDO)  */
		FROM movimientos.DETALLE_PEDIDO2 AS dp
		INNER JOIN inserted AS I
		ON dp.ID_PEDIDO = I.ID_PEDIDO
		WHERE movimientos.PEDIDO2.ID_PEDIDO = I.ID_PEDIDO;
		-- Actualiza deuda
		/*
		SET @DEUDA = (SELECT p.TOTAL 
					FROM movimientos.PEDIDO2 P, movimientos.DETALLE_PEDIDO2 d 
					WHERE p.ID_PEDIDO = d.ID_PEDIDO)
		*/
		SET @ID_DEUDOR = (SELECT p.ID_CLIENTE FROM movimientos.PEDIDO2 p, inserted I 
							WHERE p.ID_PEDIDO = I.ID_PEDIDO)
		UPDATE movimientos.DEUDOR2
		SET SALDO_DEUDOR = @DEUDA
		WHERE COD_CLI = @ID_DEUDOR;
	END
GO

-- Insertando un nuevo pedido
INSERT INTO movimientos.PEDIDO2 VALUES ('R05','20/02/2018',null,'C01','Credito');
SELECT * FROM movimientos.PEDIDO2
-- Insertando líneas de detalle
INSERT INTO movimientos.DETALLE_PEDIDO2 VALUES (1,2.00,2,'R05','P01');
INSERT INTO movimientos.DETALLE_PEDIDO2 VALUES (2,5.50,10,'R05','P02');
--DELETE FROM movimientos.DETALLE_PEDIDO2 where ID_PEDIDO = 'R05';
SELECT * FROM movimientos.PEDIDO2
SELECT * FROM movimientos.DETALLE_PEDIDO2;

-- Ejercicio 6:
-- Crear tabla DEUDOR
/*
CREATE TABLE movimientos.DEUDOR2 ( 
COD_CLI			     varchar(3)           not null, 
CODIGO_GARANTE	     varchar(3)	          null, 
LIMITE_CREDITO       decimal(10,2)        null, 
SALDO_DEUDOR         decimal(10,2)        null, 
)
  */
USE Pedidos;
--Trigger para agregar un cliente con deuda (tipo de pago: credito)
GO
CREATE TRIGGER TR_INSERTAR_DEUDOR
ON movimientos.PEDIDO2
AFTER INSERT
AS
DECLARE @TIPO varchar(10)
	BEGIN
	SET @TIPO = (SELECT I.TipoPed FROM inserted AS I)
	IF @TIPO LIKE '%Credito%'
		BEGIN
		INSERT INTO movimientos.DEUDOR2 (COD_CLI,LIMITE_CREDITO)
		SELECT I.ID_CLIENTE, 1000 
		FROM inserted as I;
		END
	ELSE
		PRINT('No es credito');
	END
GO

GO
CREATE TRIGGER TR_GARANTE
ON movimientos.DEUDOR2
FOR UPDATE
AS
DECLARE @GARANTE varchar(3)
	BEGIN
		SET @GARANTE = (SELECT CODIGO_GARANTE FROM inserted)
		-- Verifica si el garante no consta en la tabla deudor 
		IF EXISTS (SELECT 1 FROM movimientos.DEUDOR2 WHERE COD_CLI = @GARANTE)
			PRINT('Garante a registrar tiene deudas');
	END
GO

-- Probando triggers
SELECT * FROM movimientos.PEDIDO2;
SELECT * FROM movimientos.DEUDOR2;
SELECT * FROM movimientos.DETALLE_PEDIDO2;
DELETE FROM movimientos.PEDIDO2	where ID_PEDIDO = 'R06';
DELETE FROM movimientos.DEUDOR2
DELETE FROM movimientos.DETALLE_PEDIDO2 WHERE ID_PEDIDO = 'R06';

INSERT INTO movimientos.PEDIDO2 VALUES ('R06','10/03/2018',null,'C02','Credito');

INSERT INTO movimientos.DETALLE_PEDIDO2 VALUES (1,1.30,2,'R06','P03');
INSERT INTO movimientos.DETALLE_PEDIDO2 VALUES (2,2.50,1,'R06','P04');

-- INSERTNDO GARANTE PARA UN DEUDOR
UPDATE movimientos.DEUDOR2 (CODIGO_GARANTE, COD_CLI) 
SET CODIGO_GARANTE ='C01'
