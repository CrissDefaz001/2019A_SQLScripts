
CREATE DATABASE [Pedidos] 
	ON  PRIMARY  
	( NAME = 'pedidos1', FILENAME = N'C:\Data\pedidos1.mdf' ,  
	SIZE = 5 , MAXSIZE = 10 , FILEGROWTH = 10%),  

	FILEGROUP [Secundario]  
	( NAME = 'pedidos2', FILENAME = N'C:\Data\pedidos2.ndf' ,  
	SIZE = 5 , MAXSIZE = 10 , FILEGROWTH = 10%) 
	
	LOG ON  
	( NAME = N'pedidos1_log', FILENAME = N'E:\Log\pedidos1log.ldf' ,  
	SIZE = 2 , MAXSIZE = 8 , FILEGROWTH = 1 ) 
	GO 