sp_helpdb pedidos
sp_help 'catalogo.ciudad'

insert into catalogo.ciudad values ('CI1','Quito')
insert into catalogo.ciudad values ('CI2','Guayaquil')
insert into catalogo.ciudad values ('CI3','Cuenca')
insert into catalogo.ciudad values ('CI4','Loja')
select * from catalogo.ciudad


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

insert into catalogo.producto values ('P01','Producto1',10.20,100)
insert into catalogo.producto values ('P02','Producto2',3.00,50)
insert into catalogo.producto values ('P03','Producto3',5.00,70)
insert into catalogo.producto values ('P04','Producto4',1.00,200)
insert into catalogo.producto values ('P05','Producto5',150.00,10)
insert into catalogo.producto values ('P06','Producto6',550.00,60)

insert into movimiento.provee values ('PR1','P01',1000)
insert into movimiento.provee values ('PR1','P02',500)
insert into movimiento.provee values ('PR2','P03',100)
insert into movimiento.provee values ('PR3','P04',200)
insert into movimiento.provee values ('PR4','P04',10)
insert into movimiento.provee values ('PR4','P03',50)
insert into movimiento.provee values ('PR2','P02',100)
insert into movimiento.provee values ('PR3','P02',30)

insert into catalogo.proveedor values ('PR1','Proveedor1')
insert into catalogo.proveedor values ('PR2','Proveedor2')
insert into catalogo.proveedor values ('PR3','Proveedor3')
insert into catalogo.proveedor values ('PR4','Proveedor4')

insert into catalogo.telprov values ('099321453','PR1')
insert into catalogo.telprov values ('023245678','PR1')
insert into catalogo.telprov values ('098001001','PR2')
insert into catalogo.telprov values ('086584733','PR2')
insert into catalogo.telprov values ('069847636','PR3')
insert into catalogo.telprov values ('043223455','PR4')
insert into catalogo.telprov values ('043456777','PR4')
select * from catalogo.telprov

insert into movimiento.cabezerap values
('R01','20/01/2018',null,'C01')
insert into movimiento.cabezerap values
('R02','15/02/2018',null,'C02')
insert into movimiento.cabezerap values
('R03','10/03/2018',null,'C03')
insert into movimiento.cabezerap values
('R04','08/03/2018',null,'C04')
select * from movimiento.cabezerap

delete from movimiento.cabezerap

set dateformat mdy

insert into movimiento.detallep values
(1,2.00,2,'R01','P01')
insert into movimiento.detallep values
(2,5.50,10,'R01','P02')
insert into movimiento.detallep values
(1,30.00,5,'R02','P06')
insert into movimiento.detallep values
(1,20.60,4,'R03','P05')
insert into movimiento.detallep values
(1,10.00,6,'R04','P01')
insert into movimiento.detallep values
(2,150.00,3,'R04','P03')
select * from movimiento.detallep