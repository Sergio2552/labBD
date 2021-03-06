USE [master]
GO
/****** Object:  Database [Cine]    Script Date: 11/11/2017 4:26:54 ******/
/*  
Aneth Michel Mares Pérez		1738276
Diana Elizabeth Díaz Rodríguez 	1732645
Marco Antonio Almaguer Cavazos	1745800
Sergio Yahir Martinez Palma 	1742010
*/
CREATE DATABASE [Cine]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cine', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cine.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cine_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cine_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Cine] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cine].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cine] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cine] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cine] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cine] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cine] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cine] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Cine] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Cine] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cine] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cine] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cine] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cine] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cine] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cine] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cine] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cine] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Cine] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cine] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cine] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cine] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cine] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cine] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cine] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cine] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cine] SET  MULTI_USER 
GO
ALTER DATABASE [Cine] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cine] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cine] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cine] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Cine]
GO
/****** Object:  StoredProcedure [dbo].[AsientoDaniado]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AsientoDaniado]
(@sucursal varchar(100))
as 
begin
	select *
	from AsientoDañado AD
	join Sala Sa on Sa.id_sala=AD.id_sala
	join Sucursal Su on Su.id_sucursal=SA.id_sucursal
	where nombre = @sucursal
end

GO
/****** Object:  StoredProcedure [dbo].[insertarPeliculas]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[insertarPeliculas]
(@nombre varchar(100), @sinopsis varchar(700), @duracion time(7), @genero uniqueidentifier, @clasificacion varchar(50))
as 
begin
	insert into Pelicula
	select NEWID(), @nombre ,@sinopsis, @duracion, @genero, @clasificacion
	
end

GO
/****** Object:  StoredProcedure [dbo].[insertarPosicion]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[insertarPosicion]
(@posicion varchar(100))
as 
begin
	insert into Posicion
	select NEWID(),@posicion
	
end

GO
/****** Object:  StoredProcedure [dbo].[insertarSala]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[insertarSala]
(@asientos int, @precio money, @tipo varchar(50), @idsucu uniqueidentifier)
as 
begin
	insert into sala
	select NEWID(), @asientos ,@precio, @tipo, @idsucu
	
end

GO
/****** Object:  StoredProcedure [dbo].[insertarTrabajador]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[insertarTrabajador] 
(@nombre varchar(100), @apellido varchar(100), @edad int, @idsuc uniqueidentifier, @idpos uniqueidentifier)
as 
begin
	insert into Trabajador
	select NEWID(), @nombre, @apellido, @edad, @idsuc, @idpos
	
end

GO
/****** Object:  UserDefinedFunction [dbo].[CalcularCambio]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[CalcularCambio]
(@total money, @pago money)
returns money
begin
declare @final money 
	set @final= @pago -@total
return @final 
end;

GO
/****** Object:  Table [dbo].[AsientoDañado]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AsientoDañado](
	[id_asiento_dañado] [uniqueidentifier] NOT NULL,
	[num_asiento_dañado] [int] NOT NULL,
	[id_sala] [uniqueidentifier] NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
 CONSTRAINT [PK_AsientoDañado] PRIMARY KEY CLUSTERED 
(
	[id_asiento_dañado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cartelera]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cartelera](
	[id_cartelera] [uniqueidentifier] NOT NULL,
	[id_sala] [uniqueidentifier] NOT NULL,
	[id_pelicula] [uniqueidentifier] NOT NULL,
	[fecha] [date] NOT NULL,
	[hora_inicio] [time](7) NOT NULL,
 CONSTRAINT [PK_Cartelera] PRIMARY KEY CLUSTERED 
(
	[id_cartelera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genero]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Genero](
	[id_genero] [uniqueidentifier] NOT NULL,
	[genero] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Genero] PRIMARY KEY CLUSTERED 
(
	[id_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pelicula]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pelicula](
	[id_pelicula] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[sinopsis] [varchar](700) NOT NULL,
	[duracion] [time](7) NOT NULL,
	[id_genero] [uniqueidentifier] NOT NULL,
	[clasificacion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Pelicula] PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Posicion]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posicion](
	[id_posicion] [uniqueidentifier] NOT NULL,
	[posicion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Posicion] PRIMARY KEY CLUSTERED 
(
	[id_posicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[id_producto] [uniqueidentifier] NOT NULL,
	[producto] [varchar](100) NOT NULL,
	[precio] [money] NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sala]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sala](
	[id_sala] [uniqueidentifier] NOT NULL,
	[num_asientos] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[tipo_sala] [varchar](50) NOT NULL,
	[id_sucursal] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_sala] PRIMARY KEY CLUSTERED 
(
	[id_sala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sucursal]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursal](
	[id_sucursal] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[direccion] [varchar](200) NOT NULL,
	[telefono] [varchar](700) NOT NULL,
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[id_ticket] [uniqueidentifier] NOT NULL,
	[fecha] [date] NOT NULL,
	[id_cartelera] [uniqueidentifier] NOT NULL,
	[id_trabajador] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ticket_Boleto]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket_Boleto](
	[id_ticket_boleto] [uniqueidentifier] NOT NULL,
	[id_ticket] [uniqueidentifier] NOT NULL,
	[num_asiento] [int] NOT NULL,
 CONSTRAINT [PK_Ticket_Boleto] PRIMARY KEY CLUSTERED 
(
	[id_ticket_boleto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketDulceria]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketDulceria](
	[id_ticketdulceria] [uniqueidentifier] NOT NULL,
	[id_trabajador] [uniqueidentifier] NOT NULL,
	[fecha] [date] NOT NULL,
 CONSTRAINT [PK_Dulceria] PRIMARY KEY CLUSTERED 
(
	[id_ticketdulceria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trabajador]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trabajador](
	[id_trabajador] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[edad] [int] NOT NULL,
	[id_sucursal] [uniqueidentifier] NOT NULL,
	[id_posicion] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Trabajador] PRIMARY KEY CLUSTERED 
(
	[id_trabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ventas_Dulceria]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas_Dulceria](
	[id_venta_dulceria] [uniqueidentifier] NOT NULL,
	[id_ticketdulceria] [uniqueidentifier] NOT NULL,
	[id_producto] [uniqueidentifier] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Ventas_Dulceria] PRIMARY KEY CLUSTERED 
(
	[id_venta_dulceria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[asientosdaniadoview]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[asientosdaniadoview] as
select asda.id_asiento_dañado, asda.num_asiento_dañado, asda.descripcion, suc.nombre, sa.tipo_sala, sa.precio
from AsientoDañado asda
left join sala as sa on asda.id_sala = sa.id_sala
left join Sucursal as suc on sa.id_sucursal = suc.id_sucursal



GO
/****** Object:  View [dbo].[cartView]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[cartView] as 
select cart.*,suc.nombre as 'Nombre Sucursal', sa.tipo_sala, sa.precio,sa.num_asientos, peli.nombre as 'Nombre Pelicula', peli.clasificacion, peli.duracion, datepart(hour,peli.duracion)+datepart(hour,cart.hora_inicio) as 'hora_fin', datepart(MINUTE,peli.duracion)+ datepart(MINUTE,cart.hora_inicio) as 'minute_fin' 
from Cartelera cart
left join Pelicula as peli on cart.id_pelicula = peli.id_pelicula
left join Sala as sa on cart.id_sala= sa.id_sala
left join Sucursal as suc on sa.id_sucursal= suc.id_sucursal




GO
/****** Object:  View [dbo].[DulceriaView]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[DulceriaView] as 
select TD.id_ticketdulceria, TD.fecha, Tr.nombre as 'Nombre Trabajador' , Su.nombre as 'Nombre Sucursal',SUM(VD.cantidad)as 'Cantidad productos comprados', Sum(VD.cantidad*pr.precio) AS 'Precio Final'
from TicketDulceria TD
join Trabajador Tr on Tr.id_trabajador=TD.id_trabajador
join Ventas_Dulceria VD on VD.id_ticketdulceria= TD.id_ticketdulceria
join Producto Pr on Pr.id_producto=VD.id_producto
join Sucursal Su on Su.id_sucursal=Tr.id_sucursal
group by TD.id_ticketdulceria, TD.fecha,Tr.nombre, Su.nombre


GO
/****** Object:  View [dbo].[Peliculaview]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Peliculaview] as 
select peli.*, ge.genero
from Pelicula peli
left join Genero ge on peli.id_genero= ge.id_genero



GO
/****** Object:  View [dbo].[salaview]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[salaview] as
select sa.*, suc.nombre as 'Nombre sucursal', suc.direccion, suc.telefono
from sala sa
left join Sucursal suc on sa.id_sucursal = suc.id_sucursal



GO
/****** Object:  View [dbo].[TicketView]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[TicketView] as 
select T.id_ticket, T.fecha,Ca.id_cartelera,Pe.nombre as 'Nombre Pelicula', Ge.genero,Tr.nombre as 'Nombre Trabajador', Sa.id_sala,Sa.tipo_sala, Sa.precio, Su.nombre as 'Nombre Sucursal', (Count(TB.id_ticket)*Sa.precio) as 'Precio Total'
from Ticket T
join Cartelera Ca on Ca.id_cartelera=T.id_cartelera
join Trabajador Tr on Tr.id_trabajador= T.id_trabajador
join sala Sa on Sa.id_sala=Ca.id_sala
join Pelicula Pe on Pe.id_pelicula=Ca.id_pelicula
join Genero Ge on Ge.id_genero=Pe.id_genero
join Sucursal Su on Su.id_sucursal=Sa.id_sucursal
join Ticket_Boleto TB on TB.id_ticket= T.id_ticket
group by T.id_ticket,T.fecha,Ca.id_cartelera, Pe.nombre, Ge.genero, Tr.nombre, Sa.id_sala, Sa. tipo_sala, Sa.precio, Su.nombre




GO
/****** Object:  View [dbo].[TrabajadorView]    Script Date: 11/11/2017 4:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TrabajadorView] as
select tra.id_trabajador, (tra.nombre+tra.apellido) as 'Nombre',tra.edad, suc.id_sucursal,suc.nombre as 'Nombre sucursal', suc.direccion,suc.telefono, pos.posicion
from Trabajador tra
left join Sucursal suc on tra.id_sucursal=suc.id_sucursal
left join Posicion pos on tra.id_posicion=pos.id_posicion



GO
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'4be5574b-aa11-4e87-8708-24b5b2194467', 1, N'89c4ad8d-f640-4b28-9ecd-8a20d77f61f4', N'El asiento tiene pintura negra')
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'6486526d-d380-4105-9f08-2f615f9eef33', 51, N'e45bf87a-8e98-4b56-b4c9-57186f4eed3a', N'El asiento no tiene cojin')
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'c68b90a9-37c0-4bf7-9b9a-3a4ffd59d93a', 15, N'ad4e0df6-3067-4ba7-a0cd-f5d8e04f1bde', N'El asiento se ropio por causa de una pelea')
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'6490572f-2432-428d-a68c-484de93e41d6', 7, N'f1cfe8ef-6d00-4bef-9de1-3a6f64745886', N'Un joven rompio el asiento')
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'0e16727c-4238-45d5-b9b5-c43d8000ea81', 6, N'23371a58-65ea-4cce-961d-4484c12c13be', N'El asiento no tiene porta palomitas')
INSERT [dbo].[AsientoDañado] ([id_asiento_dañado], [num_asiento_dañado], [id_sala], [descripcion]) VALUES (N'dd15606e-198a-4008-af92-d2b6041e43df', 5, N'23371a58-65ea-4cce-961d-4484c12c13be', N'El asiento no tiene porta palomitas')
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'43aa87c7-ce55-4263-940b-0214ab7ed5c7', N'23371a58-65ea-4cce-961d-4484c12c13be', N'3edd8157-2db0-43c4-85fa-656f39cb5a23', CAST(0x823D0B00 AS Date), CAST(0x07001882BA7D0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'326ecb75-bf1d-4639-9580-1d1cb31034bb', N'ad4e0df6-3067-4ba7-a0cd-f5d8e04f1bde', N'99756170-3e62-45be-9fca-30e523102350', CAST(0x823D0B00 AS Date), CAST(0x070090C385800000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'83012698-5ce7-4e35-ab08-2ba220839ec5', N'3a0245c4-d44d-4b9c-bb96-4e690e3c03f4', N'99756170-3e62-45be-9fca-30e523102350', CAST(0x823D0B00 AS Date), CAST(0x0700A040EF7A0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'65d360d1-6d09-46bd-a429-4d6b0479e886', N'3483ee45-f86e-4d3b-b3ee-3af8bb66b25a', N'4564b0f4-bd6a-4cf0-a91c-f5c6d619fe98', CAST(0x823D0B00 AS Date), CAST(0x0700F0B1FE5E0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'bc956fe1-b90e-42a0-9cd6-56a7f21c04e4', N'647b8a22-b0e8-4dc5-bf5e-9965a0e94f69', N'3edd8157-2db0-43c4-85fa-656f39cb5a23', CAST(0x823D0B00 AS Date), CAST(0x07007AD4BC5D0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'7caab407-cccf-4825-bc3e-680084d6e57e', N'9ca20976-e4cc-4eb2-9b23-5543467393c2', N'19b08056-4e99-4151-b800-2b8f68c625bb', CAST(0x823D0B00 AS Date), CAST(0x070090C385800000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'4b3592cf-2d4a-4ef3-b3ac-8baa2ae794e8', N'fd665e0d-5452-4d02-bbce-342d00621565', N'99756170-3e62-45be-9fca-30e523102350', CAST(0x823D0B00 AS Date), CAST(0x070048F9F66C0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'cca6b929-48cb-4705-b5e7-8c0e6d4f4741', N'f1cfe8ef-6d00-4bef-9de1-3a6f64745886', N'849f48d6-0a8b-4d8c-a92c-929a8f1707e3', CAST(0x823D0B00 AS Date), CAST(0x0700CA2E71770000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'4e88ff5c-9577-4144-8c21-a2fb90a8b263', N'8561a9f3-ed46-4f02-b658-06740112f3f3', N'4564b0f4-bd6a-4cf0-a91c-f5c6d619fe98', CAST(0x823D0B00 AS Date), CAST(0x0700E03495640000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'7c5d5096-dbc6-4fd0-ba27-c63567a3f6ac', N'e45bf87a-8e98-4b56-b4c9-57186f4eed3a', N'849f48d6-0a8b-4d8c-a92c-929a8f1707e3', CAST(0x823D0B00 AS Date), CAST(0x0700E80A7E8E0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'9d1eb923-2309-4a19-bbbd-cc318180b208', N'89c4ad8d-f640-4b28-9ecd-8a20d77f61f4', N'a53d081f-9323-46b8-9152-09e081832f3d', CAST(0x823D0B00 AS Date), CAST(0x0700D6E3C76E0000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'85f0ef45-6ebc-4669-a12f-d7beaee2757f', N'8b80b8f3-48eb-4243-9064-33813a2cc1ee', N'849f48d6-0a8b-4d8c-a92c-929a8f1707e3', CAST(0x823D0B00 AS Date), CAST(0x0700E03495640000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'729eac93-d1cc-4637-bf0b-e71d91894d64', N'e45bf87a-8e98-4b56-b4c9-57186f4eed3a', N'19b08056-4e99-4151-b800-2b8f68c625bb', CAST(0x823D0B00 AS Date), CAST(0x0700B0BD58750000 AS Time))
INSERT [dbo].[Cartelera] ([id_cartelera], [id_sala], [id_pelicula], [fecha], [hora_inicio]) VALUES (N'3be951f5-05b9-4fd4-8f67-f3522ee77872', N'8561a9f3-ed46-4f02-b658-06740112f3f3', N'a53d081f-9323-46b8-9152-09e081832f3d', CAST(0x823D0B00 AS Date), CAST(0x070050CFDF960000 AS Time))
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'ad6609ca-4361-4103-bca5-4276737dfefa', N'Terror')
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'324add12-0aaf-4a2b-a0ad-85fb8b9da40e', N'Fantasia')
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'95b1540e-cd98-49cb-bcd5-8d07e026ded0', N'Musical')
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'2672ae3c-2f6c-4e48-8953-9f6a72885eda', N'Suspenso')
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'6e48fb00-8835-4da5-b7ae-abb924bf50a1', N'Romance')
INSERT [dbo].[Genero] ([id_genero], [genero]) VALUES (N'3bdae024-908f-4b9d-bc49-c78161e3db42', N'Comedia')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'a53d081f-9323-46b8-9152-09e081832f3d', N'IT', N'Esta pelicula habla respecto a un grupo de chicos que son atormentados por el payaso Pennywise', CAST(0x0700046BF4140000 AS Time), N'ad6609ca-4361-4103-bca5-4276737dfefa', N'C')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'19b08056-4e99-4151-b800-2b8f68c625bb', N'Vanilla Sky', N'Esta pelicula trata sobre como un hombre pierde todo lo que tiene por un accidente automovilistico y decide tener otra vida con una mujer que amo y vio solamente 1 vez', CAST(0x0700768023130000 AS Time), N'6e48fb00-8835-4da5-b7ae-abb924bf50a1', N'A')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'99756170-3e62-45be-9fca-30e523102350', N'CLAY', N'Esta pelicula trata sobre un grupo de hackers alemanes los cuales intentan ser reconocidos en el mundo', CAST(0x0700D088C3100000 AS Time), N'2672ae3c-2f6c-4e48-8953-9f6a72885eda', N'B')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'3edd8157-2db0-43c4-85fa-656f39cb5a23', N'El mago de Oz', N'Esta pelicula trata sobre una niña que viaja mas alla del arco iris y todas las aventuras que ahi vive para volver a su casa', CAST(0x0700282DDA0C0000 AS Time), N'95b1540e-cd98-49cb-bcd5-8d07e026ded0', N'A')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'849f48d6-0a8b-4d8c-a92c-929a8f1707e3', N'Una loca pelicula epica', N'Esta pelicula trata sobre la historia de 4 huerfanos los cuales pasan por muchos mundos teniendo aventuras muy divertdas', CAST(0x07008499030C0000 AS Time), N'3bdae024-908f-4b9d-bc49-c78161e3db42', N'A')
INSERT [dbo].[Pelicula] ([id_pelicula], [nombre], [sinopsis], [duracion], [id_genero], [clasificacion]) VALUES (N'4564b0f4-bd6a-4cf0-a91c-f5c6d619fe98', N'Piratas del caribe la maldicion de salazar', N'Esta pelicula trata sobre el primer gran enemigo de Jack el cual vuelve para darle caza', CAST(0x070052BE3D1B0000 AS Time), N'324add12-0aaf-4a2b-a0ad-85fb8b9da40e', N'A')
INSERT [dbo].[Posicion] ([id_posicion], [posicion]) VALUES (N'76343a59-2d82-417a-990d-372920c2015b', N'Vendedor')
INSERT [dbo].[Posicion] ([id_posicion], [posicion]) VALUES (N'3d149fdc-95e4-48cd-8e0c-724cdb58d07e', N'Cocinero')
INSERT [dbo].[Posicion] ([id_posicion], [posicion]) VALUES (N'385bc7c0-64b7-4bd2-bcad-753c9b78a68d', N'Limpiador')
INSERT [dbo].[Posicion] ([id_posicion], [posicion]) VALUES (N'2ee3add7-8cb8-4ce5-8ea7-8acbe09f75b6', N'Gerente')
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'8e678703-7e58-4b42-a96a-1f556654de94', N'Coca', 25.0000)
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'f9be7947-e270-4bd2-b23c-2c510c91a215', N'Chocolate', 15.0000)
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'281a0da4-12aa-48a8-987a-32b70663f7af', N'Nachos', 35.0000)
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'0de38f6e-839f-4d3a-8a43-471ebc68e1df', N'Hotdog', 20.0000)
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'0429737b-d77d-4014-8d68-4860d75d8ae5', N'Agua', 19.0000)
INSERT [dbo].[Producto] ([id_producto], [producto], [precio]) VALUES (N'50da8a1a-2485-433c-89d3-d68c9595719c', N'Frost', 30.0000)
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'8561a9f3-ed46-4f02-b658-06740112f3f3', 40, 80.0000, N'3D', N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'8b80b8f3-48eb-4243-9064-33813a2cc1ee', 70, 65.0000, N'2D', N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'fd665e0d-5452-4d02-bbce-342d00621565', 50, 85.0000, N'4D', N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'f1cfe8ef-6d00-4bef-9de1-3a6f64745886', 30, 70.0000, N'4D', N'e9c6115a-87b1-4835-9255-eb48d4be0b3d')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'3483ee45-f86e-4d3b-b3ee-3af8bb66b25a', 40, 65.0000, N'3D', N'9d68b9f0-8ce7-4cdd-b62e-4aa15aa8541b')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'23371a58-65ea-4cce-961d-4484c12c13be', 32, 50.0000, N'3D', N'e9c6115a-87b1-4835-9255-eb48d4be0b3d')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'3a0245c4-d44d-4b9c-bb96-4e690e3c03f4', 40, 80.0000, N'3D', N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'9ca20976-e4cc-4eb2-9b23-5543467393c2', 40, 30.0000, N'3D', N'7415c545-4039-4b1f-b5b4-f92666a5960e')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'e45bf87a-8e98-4b56-b4c9-57186f4eed3a', 60, 45.0000, N'2D', N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'89c4ad8d-f640-4b28-9ecd-8a20d77f61f4', 30, 85.0000, N'4D', N'9d68b9f0-8ce7-4cdd-b62e-4aa15aa8541b')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'647b8a22-b0e8-4dc5-bf5e-9965a0e94f69', 40, 30.0000, N'3D', N'7415c545-4039-4b1f-b5b4-f92666a5960e')
INSERT [dbo].[sala] ([id_sala], [num_asientos], [precio], [tipo_sala], [id_sucursal]) VALUES (N'ad4e0df6-3067-4ba7-a0cd-f5d8e04f1bde', 30, 30.0000, N'2D', N'7415c545-4039-4b1f-b5b4-f92666a5960e')
INSERT [dbo].[Sucursal] ([id_sucursal], [nombre], [direccion], [telefono]) VALUES (N'9d68b9f0-8ce7-4cdd-b62e-4aa15aa8541b', N'Plaza Fiesta Anahuac', N'Av. Manuel L. Barragan 325', N'8283740183')
INSERT [dbo].[Sucursal] ([id_sucursal], [nombre], [direccion], [telefono]) VALUES (N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0', N'Paseo Tec', N'Av. Eugenio Garza Sada 2411', N'8129102981')
INSERT [dbo].[Sucursal] ([id_sucursal], [nombre], [direccion], [telefono]) VALUES (N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9', N'Esfera City', N'Av. La Rioja 245', N'8257392801')
INSERT [dbo].[Sucursal] ([id_sucursal], [nombre], [direccion], [telefono]) VALUES (N'e9c6115a-87b1-4835-9255-eb48d4be0b3d', N'Montemorelos', N'Av. Montemorelos 415', N'8128914658')
INSERT [dbo].[Sucursal] ([id_sucursal], [nombre], [direccion], [telefono]) VALUES (N'7415c545-4039-4b1f-b5b4-f92666a5960e', N'Plaza la Silla', N'Av. Eugenio Garza Sada Sur 3755', N'81928302736')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'5b524853-cbc1-4981-adac-15c5af32adf0', CAST(0x823D0B00 AS Date), N'4e88ff5c-9577-4144-8c21-a2fb90a8b263', N'75422c80-50de-4c00-a822-a9544ca57ad5')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'a4612313-8081-4a6c-ac3d-17df4f1fd593', CAST(0x823D0B00 AS Date), N'7c5d5096-dbc6-4fd0-ba27-c63567a3f6ac', N'67b9869c-d191-4bac-9d97-7030d44882d9')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'f998cb7e-8c36-4331-bf90-1954a681223c', CAST(0x823D0B00 AS Date), N'7caab407-cccf-4825-bc3e-680084d6e57e', N'5e7f803f-bf70-4eaa-9ff0-9440b182ed81')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'966114d8-ddd1-4ae0-8e99-1a2d503234d3', CAST(0x823D0B00 AS Date), N'85f0ef45-6ebc-4669-a12f-d7beaee2757f', N'75422c80-50de-4c00-a822-a9544ca57ad5')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'e858dbca-281b-44df-9725-1cb6ff775aaf', CAST(0x823D0B00 AS Date), N'4b3592cf-2d4a-4ef3-b3ac-8baa2ae794e8', N'f5db84a5-50f6-4972-a860-e2200f978c31')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'57796325-e4a9-48a0-877b-4e123409d953', CAST(0x823D0B00 AS Date), N'729eac93-d1cc-4637-bf0b-e71d91894d64', N'f5db84a5-50f6-4972-a860-e2200f978c31')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'3725e5bf-74c2-4296-9241-711b0a4dcc9d', CAST(0x823D0B00 AS Date), N'3be951f5-05b9-4fd4-8f67-f3522ee77872', N'857c353b-34cc-4726-b6f0-dcc1fb5d428b')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'70632683-b6f9-4a3f-bc9d-76c9e6e27265', CAST(0x823D0B00 AS Date), N'cca6b929-48cb-4705-b5e7-8c0e6d4f4741', N'f9d5a0d2-8360-4f7f-b624-e6a339052e3e')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'ce608c26-ab50-450f-8e32-7a0174b62495', CAST(0x823D0B00 AS Date), N'83012698-5ce7-4e35-ab08-2ba220839ec5', N'75422c80-50de-4c00-a822-a9544ca57ad5')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'93e4ebf2-f02e-4bcb-8866-a46848e48058', CAST(0x823D0B00 AS Date), N'83012698-5ce7-4e35-ab08-2ba220839ec5', N'857c353b-34cc-4726-b6f0-dcc1fb5d428b')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'c2c94660-9781-491c-b89d-ac80a2fe6aff', CAST(0x823D0B00 AS Date), N'729eac93-d1cc-4637-bf0b-e71d91894d64', N'67b9869c-d191-4bac-9d97-7030d44882d9')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'a13d4e0d-35c2-4529-b212-c38cb4072819', CAST(0x823D0B00 AS Date), N'7c5d5096-dbc6-4fd0-ba27-c63567a3f6ac', N'f5db84a5-50f6-4972-a860-e2200f978c31')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'81c43bda-383f-49b4-8ba8-ceedc6f05487', CAST(0x823D0B00 AS Date), N'4b3592cf-2d4a-4ef3-b3ac-8baa2ae794e8', N'67b9869c-d191-4bac-9d97-7030d44882d9')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'fabd4f0f-0ccb-4712-ae31-cf0fec3903b4', CAST(0x823D0B00 AS Date), N'326ecb75-bf1d-4639-9580-1d1cb31034bb', N'5e7f803f-bf70-4eaa-9ff0-9440b182ed81')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'647a13be-6a7f-4668-b993-d1505adfcdb6', CAST(0x823D0B00 AS Date), N'326ecb75-bf1d-4639-9580-1d1cb31034bb', N'3c0e62e8-4d02-4f5c-8dda-c379e1279ec8')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'639ceb92-94a6-4dde-938f-d60e5d29a605', CAST(0x823D0B00 AS Date), N'85f0ef45-6ebc-4669-a12f-d7beaee2757f', N'857c353b-34cc-4726-b6f0-dcc1fb5d428b')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'3f0b650a-a9b9-46c9-b6e6-d91759186489', CAST(0x823D0B00 AS Date), N'3be951f5-05b9-4fd4-8f67-f3522ee77872', N'75422c80-50de-4c00-a822-a9544ca57ad5')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'7a567833-3b68-48bc-a3ba-de17b07d6408', CAST(0x823D0B00 AS Date), N'bc956fe1-b90e-42a0-9cd6-56a7f21c04e4', N'5e7f803f-bf70-4eaa-9ff0-9440b182ed81')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'6e09726b-adef-4b14-baed-e6a98552ebc5', CAST(0x823D0B00 AS Date), N'7caab407-cccf-4825-bc3e-680084d6e57e', N'3c0e62e8-4d02-4f5c-8dda-c379e1279ec8')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'cc957b0d-24a7-43fc-b918-f100e2ca7603', CAST(0x823D0B00 AS Date), N'43aa87c7-ce55-4263-940b-0214ab7ed5c7', N'f9d5a0d2-8360-4f7f-b624-e6a339052e3e')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'793bea8a-7048-47c5-8ef0-f3b651b87338', CAST(0x823D0B00 AS Date), N'bc956fe1-b90e-42a0-9cd6-56a7f21c04e4', N'3c0e62e8-4d02-4f5c-8dda-c379e1279ec8')
INSERT [dbo].[Ticket] ([id_ticket], [fecha], [id_cartelera], [id_trabajador]) VALUES (N'6385cf73-d85f-45cb-8532-ff4520c9a8f4', CAST(0x823D0B00 AS Date), N'4e88ff5c-9577-4144-8c21-a2fb90a8b263', N'857c353b-34cc-4726-b6f0-dcc1fb5d428b')
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'dda3e4cc-e426-4fc0-a19d-00b684adca25', N'fabd4f0f-0ccb-4712-ae31-cf0fec3903b4', 21)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'b2015fa4-2b63-46df-9464-00ff3a6a155b', N'3f0b650a-a9b9-46c9-b6e6-d91759186489', 10)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'a742e81f-0a10-4441-9c34-13220b4407ea', N'70632683-b6f9-4a3f-bc9d-76c9e6e27265', 12)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'0e2fb5d7-3bf7-40c5-b478-161f3a0a21a5', N'966114d8-ddd1-4ae0-8e99-1a2d503234d3', 51)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'8236d2fc-d063-4400-b349-17e8a6b96c79', N'cc957b0d-24a7-43fc-b918-f100e2ca7603', 31)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'1599b419-bc73-450d-bb72-1e238eca0a89', N'81c43bda-383f-49b4-8ba8-ceedc6f05487', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'2c7dbb08-02e2-4b88-b49c-2f4ad53582f7', N'fabd4f0f-0ccb-4712-ae31-cf0fec3903b4', 22)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'83f19454-75a3-41dd-a8f1-3c4415e5fec1', N'c2c94660-9781-491c-b89d-ac80a2fe6aff', 51)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'dc70987f-b74e-4320-bb29-3e0590289d38', N'fabd4f0f-0ccb-4712-ae31-cf0fec3903b4', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'afa55765-f03f-4941-b390-479f4ee27382', N'639ceb92-94a6-4dde-938f-d60e5d29a605', 48)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'8d97d0b5-f18a-4e52-916c-4b6577dbc6c0', N'a13d4e0d-35c2-4529-b212-c38cb4072819', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'df9e5f0a-35dd-49f4-b480-55b84753bdb1', N'7a567833-3b68-48bc-a3ba-de17b07d6408', 34)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'bae598fa-35d0-4ea3-864f-5bec3288cab6', N'57796325-e4a9-48a0-877b-4e123409d953', 49)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'a06dc345-5fee-4342-93ba-5fd6fe10090a', N'70632683-b6f9-4a3f-bc9d-76c9e6e27265', 11)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'1da62e16-a6b6-4acf-9460-6713aa77167d', N'3725e5bf-74c2-4296-9241-711b0a4dcc9d', 30)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'74285b69-25b2-4035-87d7-7589c98b555f', N'70632683-b6f9-4a3f-bc9d-76c9e6e27265', 10)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'cb435d1f-7423-43b9-a68b-782f643f0521', N'5b524853-cbc1-4981-adac-15c5af32adf0', 2)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'88a05602-3e5b-43a9-a6dd-79bf3e50ccee', N'a4612313-8081-4a6c-ac3d-17df4f1fd593', 21)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'fb27b024-75b2-4c23-90c5-80dfe63080da', N'6e09726b-adef-4b14-baed-e6a98552ebc5', 3)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'f2749146-40dd-44d3-bc1c-81187937f4ef', N'93e4ebf2-f02e-4bcb-8866-a46848e48058', 12)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'd58c2010-fc89-4367-a410-89d2778d18b5', N'647a13be-6a7f-4668-b993-d1505adfcdb6', 10)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'a70346b5-86cf-4dab-a438-94d91aa9e475', N'a4612313-8081-4a6c-ac3d-17df4f1fd593', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'eafcef5a-6386-4b48-967d-9afaa5ebe5df', N'c2c94660-9781-491c-b89d-ac80a2fe6aff', 50)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'869d3a64-476e-4a0e-b9d8-9bc6622b5e51', N'f998cb7e-8c36-4331-bf90-1954a681223c', 39)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'2a80cc4c-98e7-4b83-a13a-9d0f9a392c8c', N'966114d8-ddd1-4ae0-8e99-1a2d503234d3', 50)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'54986d06-2a90-4fc5-9636-9e222dc0eda0', N'793bea8a-7048-47c5-8ef0-f3b651b87338', 29)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'9b7b8fde-336e-42d0-a284-a7556827b0b5', N'ce608c26-ab50-450f-8e32-7a0174b62495', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'6e01f427-e233-4a5e-93d2-af7610edf8ab', N'a4612313-8081-4a6c-ac3d-17df4f1fd593', 22)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'93d15f0a-8143-4832-94eb-b589e4f03fdc', N'e858dbca-281b-44df-9725-1cb6ff775aaf', 19)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'f49d5f19-d641-4b9d-be6f-cc023c1a452f', N'6385cf73-d85f-45cb-8532-ff4520c9a8f4', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'ddcf9bbf-7469-4e0f-9484-cea20f94c8e4', N'f998cb7e-8c36-4331-bf90-1954a681223c', 40)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'64e0b011-816e-4ddb-8567-d4b6abb32e7a', N'e858dbca-281b-44df-9725-1cb6ff775aaf', 21)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'6c10911b-22f3-4a23-a6cc-d8933c85dfd4', N'5b524853-cbc1-4981-adac-15c5af32adf0', 3)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'afeae94c-2deb-429e-a0f3-df4da94a9fc4', N'5b524853-cbc1-4981-adac-15c5af32adf0', 1)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'5b9dca4c-6b24-4b1a-a139-e46978a9b7ce', N'3725e5bf-74c2-4296-9241-711b0a4dcc9d', 29)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'7adc60b7-ce80-4beb-a1e4-eb012a8eb69a', N'639ceb92-94a6-4dde-938f-d60e5d29a605', 47)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'13226db4-1c30-4e7a-ac2e-f51cb39694f3', N'e858dbca-281b-44df-9725-1cb6ff775aaf', 20)
INSERT [dbo].[Ticket_Boleto] ([id_ticket_boleto], [id_ticket], [num_asiento]) VALUES (N'a73ccab3-8531-4ed0-8667-fb2d26b46746', N'6385cf73-d85f-45cb-8532-ff4520c9a8f4', 21)
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'9fdf1154-7d91-4839-8481-2cbae12287d4', N'67b9869c-d191-4bac-9d97-7030d44882d9', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'd4835e9e-69c7-48cf-855c-599d438d5b04', N'75422c80-50de-4c00-a822-a9544ca57ad5', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'519468a5-c11c-4308-9307-6c7f2f18d53a', N'3c0e62e8-4d02-4f5c-8dda-c379e1279ec8', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'ee26328b-3766-46ca-919e-86f6bdcb34e3', N'f9d5a0d2-8360-4f7f-b624-e6a339052e3e', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'91c0161e-e85b-4ccc-be9b-94bee92f712b', N'857c353b-34cc-4726-b6f0-dcc1fb5d428b', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'c36a128f-1ec4-4a7f-a876-a98038aa66d4', N'f5db84a5-50f6-4972-a860-e2200f978c31', CAST(0x823D0B00 AS Date))
INSERT [dbo].[TicketDulceria] ([id_ticketdulceria], [id_trabajador], [fecha]) VALUES (N'35a07dde-c65e-49ad-810f-e4705e50fea0', N'5e7f803f-bf70-4eaa-9ff0-9440b182ed81', CAST(0x823D0B00 AS Date))
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'67b9869c-d191-4bac-9d97-7030d44882d9', N'Adrian Alexandro', N'Sanchez Salazar', 28, N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'983b5e07-0d13-4f54-8bb8-70ae52910361', N'Jesus Humberto', N'Plata Alanis', 19, N'7415c545-4039-4b1f-b5b4-f92666a5960e', N'385bc7c0-64b7-4bd2-bcad-753c9b78a68d')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'cc0e8cb2-676b-45f6-9d6a-8e76079dfade', N'Sergio', N'Martinez Palma', 19, N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0', N'2ee3add7-8cb8-4ce5-8ea7-8acbe09f75b6')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'5e7f803f-bf70-4eaa-9ff0-9440b182ed81', N'Jose Emiliano', N'Alanis Ozuna', 19, N'7415c545-4039-4b1f-b5b4-f92666a5960e', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'75422c80-50de-4c00-a822-a9544ca57ad5', N'Marco Antonio', N'Almaguer Cavazos', 18, N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'3c0e62e8-4d02-4f5c-8dda-c379e1279ec8', N'Saul Armando', N'Almaguer Salazar', 19, N'7415c545-4039-4b1f-b5b4-f92666a5960e', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'857c353b-34cc-4726-b6f0-dcc1fb5d428b', N'Gabriela Lizeth', N'Castro Lopez', 19, N'7cddf0bb-ac82-4eb9-9ea9-db4185f72cd9', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'f5db84a5-50f6-4972-a860-e2200f978c31', N'Juan Antonio', N'Arminjo Ochoa', 19, N'1cc3ed80-d14d-4093-a257-a4fd7be03bf0', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'f9d5a0d2-8360-4f7f-b624-e6a339052e3e', N'Diana Elizabeth', N'Diaz Rodriguez', 18, N'e9c6115a-87b1-4835-9255-eb48d4be0b3d', N'76343a59-2d82-417a-990d-372920c2015b')
INSERT [dbo].[Trabajador] ([id_trabajador], [nombre], [apellido], [edad], [id_sucursal], [id_posicion]) VALUES (N'417063e1-92ac-49f9-b207-e90bc63211fb', N'Aneth Michel', N'Mares Perez', 18, N'9d68b9f0-8ce7-4cdd-b62e-4aa15aa8541b', N'3d149fdc-95e4-48cd-8e0c-724cdb58d07e')
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'073bb64c-148d-4ee1-a3b0-46780d0d0888', N'9fdf1154-7d91-4839-8481-2cbae12287d4', N'281a0da4-12aa-48a8-987a-32b70663f7af', 1)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'ecd68552-08e9-4bf2-b02d-4a55d10928c9', N'35a07dde-c65e-49ad-810f-e4705e50fea0', N'0de38f6e-839f-4d3a-8a43-471ebc68e1df', 2)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'e16cd7bf-362c-4dec-9588-54d8a924801b', N'91c0161e-e85b-4ccc-be9b-94bee92f712b', N'8e678703-7e58-4b42-a96a-1f556654de94', 1)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'6ef31e77-76e2-4365-a10a-730286fcf536', N'c36a128f-1ec4-4a7f-a876-a98038aa66d4', N'281a0da4-12aa-48a8-987a-32b70663f7af', 3)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'00914fb1-0cea-483f-80c1-7d018bc8d6dd', N'35a07dde-c65e-49ad-810f-e4705e50fea0', N'0429737b-d77d-4014-8d68-4860d75d8ae5', 2)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'0ed49ec0-453e-4db4-8f18-a3b1a05b7e8b', N'd4835e9e-69c7-48cf-855c-599d438d5b04', N'50da8a1a-2485-433c-89d3-d68c9595719c', 3)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'6db4d1cb-a905-469c-a33e-c2aa0473183a', N'ee26328b-3766-46ca-919e-86f6bdcb34e3', N'0de38f6e-839f-4d3a-8a43-471ebc68e1df', 2)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'07b7cd5f-47f7-48c8-a661-e0ca60b51b42', N'519468a5-c11c-4308-9307-6c7f2f18d53a', N'f9be7947-e270-4bd2-b23c-2c510c91a215', 2)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'62cbd389-b3a5-4db8-a9d0-e14da686521a', N'9fdf1154-7d91-4839-8481-2cbae12287d4', N'8e678703-7e58-4b42-a96a-1f556654de94', 2)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'7945c722-e6a1-4a26-b4f9-ec4b66eed050', N'35a07dde-c65e-49ad-810f-e4705e50fea0', N'f9be7947-e270-4bd2-b23c-2c510c91a215', 1)
INSERT [dbo].[Ventas_Dulceria] ([id_venta_dulceria], [id_ticketdulceria], [id_producto], [cantidad]) VALUES (N'252f3e27-53a7-4ebb-a454-ed9c259a93d4', N'ee26328b-3766-46ca-919e-86f6bdcb34e3', N'0429737b-d77d-4014-8d68-4860d75d8ae5', 2)
ALTER TABLE [dbo].[AsientoDañado]  WITH CHECK ADD  CONSTRAINT [FK_AsientoDañado_sala] FOREIGN KEY([id_sala])
REFERENCES [dbo].[sala] ([id_sala])
GO
ALTER TABLE [dbo].[AsientoDañado] CHECK CONSTRAINT [FK_AsientoDañado_sala]
GO
ALTER TABLE [dbo].[Cartelera]  WITH CHECK ADD  CONSTRAINT [FK_Cartelera_Pelicula] FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[Pelicula] ([id_pelicula])
GO
ALTER TABLE [dbo].[Cartelera] CHECK CONSTRAINT [FK_Cartelera_Pelicula]
GO
ALTER TABLE [dbo].[Cartelera]  WITH CHECK ADD  CONSTRAINT [FK_Cartelera_sala] FOREIGN KEY([id_sala])
REFERENCES [dbo].[sala] ([id_sala])
GO
ALTER TABLE [dbo].[Cartelera] CHECK CONSTRAINT [FK_Cartelera_sala]
GO
ALTER TABLE [dbo].[Pelicula]  WITH CHECK ADD  CONSTRAINT [FK_Pelicula_Genero] FOREIGN KEY([id_genero])
REFERENCES [dbo].[Genero] ([id_genero])
GO
ALTER TABLE [dbo].[Pelicula] CHECK CONSTRAINT [FK_Pelicula_Genero]
GO
ALTER TABLE [dbo].[sala]  WITH CHECK ADD  CONSTRAINT [FK_sala_Sucursal] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [dbo].[sala] CHECK CONSTRAINT [FK_sala_Sucursal]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Cartelera] FOREIGN KEY([id_cartelera])
REFERENCES [dbo].[Cartelera] ([id_cartelera])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Cartelera]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Trabajador] FOREIGN KEY([id_trabajador])
REFERENCES [dbo].[Trabajador] ([id_trabajador])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Trabajador]
GO
ALTER TABLE [dbo].[Ticket_Boleto]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Boleto_Ticket] FOREIGN KEY([id_ticket])
REFERENCES [dbo].[Ticket] ([id_ticket])
GO
ALTER TABLE [dbo].[Ticket_Boleto] CHECK CONSTRAINT [FK_Ticket_Boleto_Ticket]
GO
ALTER TABLE [dbo].[TicketDulceria]  WITH CHECK ADD  CONSTRAINT [FK_Dulceria_Trabajador] FOREIGN KEY([id_trabajador])
REFERENCES [dbo].[Trabajador] ([id_trabajador])
GO
ALTER TABLE [dbo].[TicketDulceria] CHECK CONSTRAINT [FK_Dulceria_Trabajador]
GO
ALTER TABLE [dbo].[Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_Posicion1] FOREIGN KEY([id_posicion])
REFERENCES [dbo].[Posicion] ([id_posicion])
GO
ALTER TABLE [dbo].[Trabajador] CHECK CONSTRAINT [FK_Trabajador_Posicion1]
GO
ALTER TABLE [dbo].[Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_Sucursal] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [dbo].[Trabajador] CHECK CONSTRAINT [FK_Trabajador_Sucursal]
GO
ALTER TABLE [dbo].[Ventas_Dulceria]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Dulceria_Dulceria] FOREIGN KEY([id_ticketdulceria])
REFERENCES [dbo].[TicketDulceria] ([id_ticketdulceria])
GO
ALTER TABLE [dbo].[Ventas_Dulceria] CHECK CONSTRAINT [FK_Ventas_Dulceria_Dulceria]
GO
ALTER TABLE [dbo].[Ventas_Dulceria]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Dulceria_Producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[Producto] ([id_producto])
GO
ALTER TABLE [dbo].[Ventas_Dulceria] CHECK CONSTRAINT [FK_Ventas_Dulceria_Producto]
GO
USE [master]
GO
ALTER DATABASE [Cine] SET  READ_WRITE 
GO
