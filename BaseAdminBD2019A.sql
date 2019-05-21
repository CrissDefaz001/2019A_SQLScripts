/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     5/15/2019 7:35:43 PM                         */
/*==============================================================*/


/*if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CLIENTE') and o.name = 'FK_CLIENTE_RELATIONS_CIUDAD')
alter table CLIENTE
   drop constraint FK_CLIENTE_RELATIONS_CIUDAD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CLIENTE') and o.name = 'FK_CLIENTE_RELATIONS_CLIENTE')
alter table CLIENTE
   drop constraint FK_CLIENTE_RELATIONS_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLE_PEDIDO') and o.name = 'FK_DETALLE__RELATIONS_PEDIDO')
alter table DETALLE_PEDIDO
   drop constraint FK_DETALLE__RELATIONS_PEDIDO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLE_PEDIDO') and o.name = 'FK_DETALLE__RELATIONS_PRODUCTO')
alter table DETALLE_PEDIDO
   drop constraint FK_DETALLE__RELATIONS_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('INSUMOS') and o.name = 'FK_INSUMOS_RELATIONS_FABRICA')
alter table INSUMOS
   drop constraint FK_INSUMOS_RELATIONS_FABRICA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('INSUMOS') and o.name = 'FK_INSUMOS_RELATIONS_PRODUCTO')
alter table INSUMOS
   drop constraint FK_INSUMOS_RELATIONS_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PEDIDO') and o.name = 'FK_PEDIDO_RELATIONS_CLIENTE')
alter table PEDIDO
   drop constraint FK_PEDIDO_RELATIONS_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TELEFONO') and o.name = 'FK_TELEFONO_RELATIONS_FABRICA')
alter table TELEFONO
   drop constraint FK_TELEFONO_RELATIONS_FABRICA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CIUDAD')
            and   type = 'U')
   drop table CIUDAD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CLIENTE')
            and   name  = 'RELATIONSHIP_7_FK'
            and   indid > 0
            and   indid < 255)
   drop index CLIENTE.RELATIONSHIP_7_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CLIENTE')
            and   name  = 'RELATIONSHIP_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index CLIENTE.RELATIONSHIP_6_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTE')
            and   type = 'U')
   drop table CLIENTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLE_PEDIDO')
            and   name  = 'RELATIONSHIP_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLE_PEDIDO.RELATIONSHIP_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLE_PEDIDO')
            and   name  = 'RELATIONSHIP_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLE_PEDIDO.RELATIONSHIP_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DETALLE_PEDIDO')
            and   type = 'U')
   drop table DETALLE_PEDIDO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FABRICA')
            and   type = 'U')
   drop table FABRICA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INSUMOS')
            and   name  = 'RELATIONSHIP_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index INSUMOS.RELATIONSHIP_4_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INSUMOS')
            and   name  = 'RELATIONSHIP_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index INSUMOS.RELATIONSHIP_5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INSUMOS')
            and   type = 'U')
   drop table INSUMOS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PEDIDO')
            and   name  = 'RELATIONSHIP_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index PEDIDO.RELATIONSHIP_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PEDIDO')
            and   type = 'U')
   drop table PEDIDO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCTO')
            and   type = 'U')
   drop table PRODUCTO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TELEFONO')
            and   name  = 'RELATIONSHIP_8_FK'
            and   indid > 0
            and   indid < 255)
   drop index TELEFONO.RELATIONSHIP_8_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TELEFONO')
            and   type = 'U')
   drop table TELEFONO
go*/
use Pedidos
go
create schema catalogo
go
create schema movimientos
go

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table catalogo.CIUDAD (
   ID_CIUDAD            varchar(3)           not null,
   NOMBRE_CIUDAD        varchar(40)          null,
   constraint PK_CIUDAD primary key (ID_CIUDAD)
)
go

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table catalogo.CLIENTE (
   NUMERO_CLIENTE       varchar(3)           not null,
   ID_CIUDAD            varchar(3)           not null,
   GARANTE              varchar(3)           null,
   DIRRECION_ENVIO      varchar(80)          null,
   LIMITE_DE_CREDITO    decimal(7,2)         null,
   DESCUENTO            decimal(5,2)         null,
   constraint PK_CLIENTE primary key (NUMERO_CLIENTE)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_6_FK on CLIENTE (ID_CIUDAD ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_7_FK on CLIENTE (GARANTE ASC)

/*==============================================================*/
/* Table: DETALLE_PEDIDO                                        */
/*==============================================================*/
create table movimientos.DETALLE_PEDIDO (
   NUMERO_LINEA         smallint             identity,
   ID_PEDIDO            varchar(3)           not null,
   ID_PRODUCTO          varchar(3)           not null,
   PRECIO_UNITARIO      decimal(7,2)         null,
   CANTIDAD             smallint             null,
   constraint PK_DETALLE_PEDIDO primary key (ID_PEDIDO, NUMERO_LINEA)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_2_FK on DETALLE_PEDIDO (ID_PEDIDO ASC)


/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_3_FK on DETALLE_PEDIDO (ID_PRODUCTO ASC)


/*==============================================================*/
/* Table: FABRICA                                               */
/*==============================================================*/
create table catalogo.FABRICA (
   NUMERO_DE_LA_FABRICA varchar(3)           not null,
   NOMBRE_FABRICA       varchar(40)          null,
   constraint PK_FABRICA primary key (NUMERO_DE_LA_FABRICA)
)
go

/*==============================================================*/
/* Table: INSUMOS                                               */
/*==============================================================*/
create table movimientos.INSUMOS (
   NUMERO_DE_LA_FABRICA varchar(3)           not null,
   ID_PRODUCTO          varchar(3)           not null,
   CANTIDAD             smallint             null,
   constraint PK_INSUMOS primary key (NUMERO_DE_LA_FABRICA, ID_PRODUCTO)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_5_FK on INSUMOS (ID_PRODUCTO ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_4_FK on INSUMOS (NUMERO_DE_LA_FABRICA ASC)
go

/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
create table movimientos.PEDIDO (
   ID_PEDIDO            varchar(3)           not null,
   ID_CLIENTE           varchar(3)           not null,
   FECHA_DE_PEDIDO      datetime             null,
   TOTAL                decimal(10,2)        null,
   constraint PK_PEDIDO primary key (ID_PEDIDO)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_1_FK on PEDIDO (ID_CLIENTE ASC)
go

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table catalogo.PRODUCTO (
   ID_PRODUCTO          varchar(3)           not null,
   NOMBRE_DEL_PRODUCTO  varchar(40)          null,
   PRECIO_PRODUCTO      decimal(7,2)         null,
   STOCK_PRODUCTO       smallint             null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
)
go

/*==============================================================*/
/* Table: TELEFONO                                              */
/*==============================================================*/
create table catalogo.TELEFONO (
   NUM_TELEFONO         varchar(10)          not null,
   NUMERO_DE_LA_FABRICA varchar(3)           not null,
   constraint PK_TELEFONO primary key (NUM_TELEFONO)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/




--create nonclustered index RELATIONSHIP_8_FK on TELEFONO (NUMERO_DE_LA_FABRICA ASC)
go

/*
alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_CIUDAD foreign key (ID_CIUDAD)
      references CIUDAD (ID_CIUDAD)
go

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_CLIENTE foreign key (GARANTE)
      references CLIENTE (NUMERO_CLIENTE)
go

alter table DETALLE_PEDIDO
   add constraint FK_DETALLE__RELATIONS_PEDIDO foreign key (ID_PEDIDO)
      references PEDIDO (ID_PEDIDO)
go

alter table DETALLE_PEDIDO
   add constraint FK_DETALLE__RELATIONS_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
go

alter table INSUMOS
   add constraint FK_INSUMOS_RELATIONS_FABRICA foreign key (NUMERO_DE_LA_FABRICA)
      references FABRICA (NUMERO_DE_LA_FABRICA)
go

alter table INSUMOS
   add constraint FK_INSUMOS_RELATIONS_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
go

alter table PEDIDO
   add constraint FK_PEDIDO_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (NUMERO_CLIENTE)
go

alter table TELEFONO
   add constraint FK_TELEFONO_RELATIONS_FABRICA foreign key (NUMERO_DE_LA_FABRICA)
      references FABRICA (NUMERO_DE_LA_FABRICA)
go

*/