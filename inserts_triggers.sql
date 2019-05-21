-- Inserciones y Triggers
USE Pedidos;
SELECT * FROM catalogo.CIUDAD;

-- Inserciones:
-- CIUDAD
insert into catalogo.ciudad values ('CI1','Quito')
insert into catalogo.ciudad values ('CI2','Guayaquil')
insert into catalogo.ciudad values ('CI3','Cuenca')
insert into catalogo.ciudad values ('CI4','Loja')
select * from catalogo.ciudad

-- CLIENTE
insert into catalogo.cliente 
values ('C01','CI1','C01','NNUU y 10 de Agosto',1500.00,10)
insert into catalogo.cliente 
values ('C02','CI1','C01','Riofrio y Bolivia',1200.00,10)
insert into catalogo.cliente 
values ('C03','CI2','C02','Malecon 1050',1000.00,5)
insert into catalogo.cliente 
values ('C04','CI2','C02','Libertadores y Ayacucho',500.00,3)
insert into catalogo.cliente 
values ('C05','CI3','C04','Julio Moreno 231',900.00,4)
insert into catalogo.cliente 
values ('C06','CI3','C04','La 15 y Marin',1800.00,15)
insert into catalogo.cliente 
values ('C07','CI4','C05','Direnvio1 y Estadio',1000.00,10)
select * from catalogo.cliente

-- PRODUCCTO
insert into catalogo.producto values ('P01','Producto1',10.20,100)
insert into catalogo.producto values ('P02','Producto2',3.00,50)
insert into catalogo.producto values ('P03','Producto3',5.00,70)
insert into catalogo.producto values ('P04','Producto4',1.00,200)
insert into catalogo.producto values ('P05','Producto5',150.00,10)
insert into catalogo.producto values ('P06','Producto6',550.00,60)
select * from catalogo.PRODUCTO;

-- FABRICA / PROVEEDOR
insert into catalogo.FABRICA values ('PR1','Proveedor1')
insert into catalogo.FABRICA values ('PR2','Proveedor2')
insert into catalogo.FABRICA values ('PR3','Proveedor3')
insert into catalogo.FABRICA values ('PR4','Proveedor4')
select * from catalogo.FABRICA;

-- TELEFONO
insert into catalogo.TELEFONO values ('099321453','PR1')
insert into catalogo.TELEFONO values ('023245678','PR1')
insert into catalogo.TELEFONO values ('098001001','PR2')
insert into catalogo.TELEFONO values ('086584733','PR2')
insert into catalogo.TELEFONO values ('069847636','PR3')
insert into catalogo.TELEFONO values ('043223455','PR4')
insert into catalogo.TELEFONO values ('043456777','PR4')
select * from catalogo.TELEFONO;

-- INSUMOS
insert into movimientos.INSUMOS values ('PR1','P01',1000)
insert into movimientos.INSUMOS values ('PR1','P02',500)
insert into movimientos.INSUMOS values ('PR2','P03',100)
insert into movimientos.INSUMOS values ('PR3','P04',200)
insert into movimientos.INSUMOS values ('PR4','P04',10)
insert into movimientos.INSUMOS values ('PR4','P03',50)
insert into movimientos.INSUMOS values ('PR2','P02',100)
insert into movimientos.INSUMOS values ('PR3','P02',30)

-- 



-- Crear tabla unificada pedido_detallePedido
/*
create table movimientos.PEDIDO_DETALLEPEDIDO ( 
   ID_PEDIDO            varchar(3)           not null,
   FECHA_DE_PEDIDO      datetime             null, 
   TOTAL                decimal(10,2)        null, 
   ID_CLIENTE           varchar(3)           not null,
   NUMERO_LINEA         smallint             identity, 
   PRECIO_UNITARIO      decimal(7,2)         null,
   CANTIDAD             smallint             null,
   ID_PRODUCTO          varchar(3)           not null,
)
*/
-- Tablas de prueba
create table movimientos.PEDIDO ( 
   ID_PEDIDO            varchar(3)           not null, 
   FECHA_DE_PEDIDO      Datetime	         null, 
   TOTAL                decimal(10,2)        null, 
   ID_CLIENTE           varchar(3)           not null, 
   constraint PK_PEDIDO primary key (ID_PEDIDO)
)
create table movimientos.DETALLE_PEDIDO ( 
   NUMERO_LINEA         smallint             not null, 
   PRECIO_UNITARIO      decimal(7,2)         null, 
   CANTIDAD             smallint             null, 
   ID_PEDIDO            varchar(3)           not null, 
   ID_PRODUCTO          varchar(3)           not null, 
   constraint PK_DETALLE_PEDIDO_P primary key (NUMERO_LINEA, ID_PEDIDO) 
)

create table movimientos.PEDIDO_DETALLEPEDIDO ( 
   ID_PEDIDO            varchar(3)           null,
   FECHA_DE_PEDIDO      Datetime             null, 
   TOTAL                decimal(10,2)        null, 
   ID_CLIENTE           varchar(3)           null,
   NUMERO_LINEA         smallint             null, 
   PRECIO_UNITARIO      decimal(7,2)         null,
   CANTIDAD             smallint             null,
   ID_PRODUCTO          varchar(3)           null,
);

DROP TABLE movimientos.PEDIDO;
DROP TABLE movimientos.DETALLE_PEDIDO;

DROP TABLE PEDIDO_DETALLEPEDIDO_P;
DROP TABLE DETALLE_PEDIDO_P;
DROP TABLE PEDIDO_P;





SELECT * FROM dbo.PEDIDO_DETALLEPEDIDO_P;

-- Trigger:
-- Desde la tabla detalle_pedido
GO
CREATE TRIGGER TR_INS_DETALLE
ON dbo.DETALLE_PEDIDO_P
AFTER INSERT
AS
	BEGIN
		INSERT INTO dbo.PEDIDO_DETALLEPEDIDO_P
		(NUMERO_LINEA, PRECIO_UNITARIO, CANTIDAD, ID_PRODUCTO)
		SELECT I.NUMERO_LINEA, I.PRECIO_UNITARIO,I.CANTIDAD,I.ID_PRODUCTO
		FROM inserted I
	END
GO
-- Desde la tabla pedidos
select * from PEDIDO_DETALLEPEDIDO_P;

GO
CREATE TRIGGER TR_INS_PEDIDO
ON dbo.PEDIDO_P
AFTER INSERT
AS
	BEGIN
		UPDATE dbo.PEDIDO_DETALLEPEDIDO_P  
		SET PRECIO_UNITARIO = I.PRECIO_UNITARIO,
		CANTIDAD = I.CANTIDAD,
		ID_PRODUCTO = I.ID_PRODUCTO
		FROM dbo.PEDIDO_DETALLEPEDIDO_P AS dp
		INNER JOIN inserted as I
		ON dp.ID_PEDIDO = I.ID_PEDIDO
	END
GO

DROP TRIGGER TR_INS_DETALLE;
DROP TRIGGER TR_INS_PEDIDO;


-- Probando inserciones
USE Pedidos;
-- Pedido
INSERT INTO movimientos.PEDIDO VALUES ('R01','20/01/2018',null,'C01');
INSERT INTO movimientos.PEDIDO VALUES ('R02','15/02/2018',null,'C02');
INSERT INTO movimientos.PEDIDO VALUES ('R03','10/03/2018',null,'C03');
INSERT INTO movimientos.PEDIDO VALUES ('R04','08/03/2018',null,'C04');

-- Detalle
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (1,2.00,2,'R01','P01');
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (2,5.50,10,'R01','P02');
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (1,30.00,5,'R02','P06');
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (1,20.60,4,'R03','P05');
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (1,10.00,6,'R04','P01');
INSERT INTO movimientos.DETALLE_PEDIDO VALUES (2,150.00,3,'R04','P03');

-- consulta tabla pedido_detallePedido
SELECT * FROM dbo.PEDIDO_P;
SELECT * FROM dbo.DETALLE_PEDIDO_P;
SELECT * FROM dbo.PEDIDO_DETALLEPEDIDO_P;

-- forzado
SELECT * FROM movimientos.PEDIDO_DETALLEPEDIDO;

INSERT INTO movimientos.PEDIDO_DETALLEPEDIDO
VALUES ('R01','20/01/2018',null,'C01',1,2.00,2,'P01'),
('R01','20/01/2018',null,'C01',2,5.50,10,'P02'),
('R02','15/02/2018',null,'C02',1,30.00,5,'P06'),
('R03','10/03/2018',null,'C03',1,20.60,4,'P05'),
('R04','08/03/2018',null,'C04',1,10.00,6,'P01'),
('R04','08/03/2018',null,'C04',2,150.00,3,'P03');

SELECT * FROM movimientos.DETALLE_PEDIDO;
SELECT * FROM movimientos.PEDIDO;
SELECT * FROM movimientos.PEDIDO_DETALLEPEDIDO;

SELECT * FROM dbo.PEDIDO_P;
SELECT * FROM dbo.DETALLE_PEDIDO_P;





