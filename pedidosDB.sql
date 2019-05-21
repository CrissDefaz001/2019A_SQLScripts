use Pedidos 
go

create schema catalogo 
go 

create schema movimientos 
go 

create table catalogo.CIUDAD ( 
   ID_CIUDAD            varchar(3)           not null, 
   NOMBRE_CIUDAD        varchar(40)          null, 
   constraint PK_CIUDAD primary key (ID_CIUDAD) 
) 

create table catalogo.CLIENTE ( 
   NUMERO_CLIENTE       varchar(3)           not null, 
   ID_CIUDAD            varchar(3)           not null, 
   GARANTE              varchar(3)           null, 
   DIRRECION_ENVIO      varchar(80)          null, 
   LIMITE_DE_CREDITO    decimal(7,2)         null, 
   DESCUENTO            decimal(5,2)         null, 
   constraint PK_CLIENTE primary key (NUMERO_CLIENTE) 
) 

create table movimientos.DETALLE_PEDIDO ( 
   NUMERO_LINEA         smallint             not null, 
   ID_PEDIDO            varchar(3)           not null, 
   ID_PRODUCTO          varchar(3)           not null, 
   PRECIO_UNITARIO      decimal(7,2)         null, 
   CANTIDAD             smallint             null, 
   constraint PK_DETALLE_PEDIDO primary key (ID_PEDIDO, NUMERO_LINEA) 
) 

create table catalogo.FABRICA ( 
   NUMERO_DE_LA_FABRICA varchar(3)           not null, 
   NOMBRE_FABRICA       varchar(40)          null, 
   constraint PK_FABRICA primary key (NUMERO_DE_LA_FABRICA) 
)

create table movimientos.INSUMOS ( 
   NUMERO_DE_LA_FABRICA varchar(3)           not null, 
   ID_PRODUCTO          varchar(3)           not null, 
   CANTIDAD             smallint             null, 
   constraint PK_INSUMOS primary key (NUMERO_DE_LA_FABRICA, ID_PRODUCTO) 
) 

create table movimientos.PEDIDO ( 
   ID_PEDIDO            varchar(3)           not null, 
   ID_CLIENTE           varchar(3)           not null, 
   FECHA_DE_PEDIDO      datetime             null, 
   TOTAL                decimal(10,2)        null, 
   constraint PK_PEDIDO primary key (ID_PEDIDO)
) 

create table catalogo.PRODUCTO ( 
   ID_PRODUCTO          varchar(3)           not null, 
   NOMBRE_DEL_PRODUCTO  varchar(40)          null, 
   PRECIO_PRODUCTO      decimal(7,2)         null, 
   STOCK_PRODUCTO       smallint             null, 
   constraint PK_PRODUCTO primary key (ID_PRODUCTO) 
) 

create table catalogo.TELEFONO ( 
   NUM_TELEFONO         varchar(10)          not null, 
   NUMERO_DE_LA_FABRICA varchar(3)           not null, 
   constraint PK_TELEFONO primary key (NUM_TELEFONO) 
) 
