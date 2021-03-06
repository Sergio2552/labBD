USE [master]
GO
/****** Object:  Database [cine]    Script Date: 07/10/2017 11:59:49 a.m. ******/
CREATE DATABASE [cine]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cine', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\cine.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cine_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\cine_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cine] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cine].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cine] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cine] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cine] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cine] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cine] SET ARITHABORT OFF 
GO
ALTER DATABASE [cine] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cine] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cine] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cine] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cine] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cine] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cine] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cine] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cine] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cine] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cine] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cine] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cine] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cine] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cine] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cine] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cine] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cine] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cine] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [cine] SET  MULTI_USER 
GO
ALTER DATABASE [cine] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cine] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cine] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cine] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [cine]
GO
/****** Object:  Table [dbo].[Cartelera]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cartelera](
	[IDCartelera] [int] NOT NULL,
	[IDHorario] [int] NOT NULL,
	[IDPelicula] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Horario]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horario](
	[IDHorario] [int] NOT NULL,
	[IDSala] [int] NOT NULL,
	[IDPelicula] [int] NOT NULL,
	[Horario_Inicio] [time](7) NOT NULL,
	[Horario_Fin] [time](7) NOT NULL,
 CONSTRAINT [PK_Horario] PRIMARY KEY CLUSTERED 
(
	[IDHorario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pelicula]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pelicula](
	[IDPelicula] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Sinopsis] [nvarchar](max) NOT NULL,
	[Duracion] [time](7) NOT NULL,
	[Clasificacion] [char](3) NOT NULL,
	[Genero] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Pelicula] PRIMARY KEY CLUSTERED 
(
	[IDPelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Posicion]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posicion](
	[IDPosicion] [int] NOT NULL,
	[IDTrabajador] [int] NOT NULL,
	[Posicion] [int] NOT NULL,
 CONSTRAINT [PK_Posicion] PRIMARY KEY CLUSTERED 
(
	[IDPosicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sala]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sala](
	[IDSala] [int] NOT NULL,
	[NumAsientos] [int] NOT NULL,
	[Precio] [money] NOT NULL,
	[Tipo_Sala] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Sala] PRIMARY KEY CLUSTERED 
(
	[IDSala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sucursal]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursal](
	[IDSucursal] [int] NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
	[Telefono] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[IDSucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trabajadores]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trabajadores](
	[IDTrabajador] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [nchar](10) NOT NULL,
	[Edad] [int] NOT NULL,
	[IDSucursal] [int] NOT NULL,
 CONSTRAINT [PK_Trabajadores] PRIMARY KEY CLUSTERED 
(
	[IDTrabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta_Mostrador]    Script Date: 07/10/2017 11:59:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta_Mostrador](
	[ID_Venta_Mostrador] [int] NOT NULL,
	[Fecha] [datetime2](7) NOT NULL,
	[IDHorario] [int] NOT NULL,
	[IDTrabajador] [int] NOT NULL,
	[IDSucursal] [int] NOT NULL,
	[Cantidad_Boletos] [int] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_Venta_Mostrador] PRIMARY KEY CLUSTERED 
(
	[ID_Venta_Mostrador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Cartelera]  WITH CHECK ADD  CONSTRAINT [FK_Cartelera_Horario] FOREIGN KEY([IDCartelera])
REFERENCES [dbo].[Horario] ([IDHorario])
GO
ALTER TABLE [dbo].[Cartelera] CHECK CONSTRAINT [FK_Cartelera_Horario]
GO
ALTER TABLE [dbo].[Cartelera]  WITH CHECK ADD  CONSTRAINT [FK_Cartelera_Pelicula] FOREIGN KEY([IDPelicula])
REFERENCES [dbo].[Pelicula] ([IDPelicula])
GO
ALTER TABLE [dbo].[Cartelera] CHECK CONSTRAINT [FK_Cartelera_Pelicula]
GO
ALTER TABLE [dbo].[Cartelera]  WITH CHECK ADD  CONSTRAINT [FK_Cartelera_Sucursal] FOREIGN KEY([IDCartelera])
REFERENCES [dbo].[Sucursal] ([IDSucursal])
GO
ALTER TABLE [dbo].[Cartelera] CHECK CONSTRAINT [FK_Cartelera_Sucursal]
GO
ALTER TABLE [dbo].[Horario]  WITH CHECK ADD  CONSTRAINT [FK_Horario_Pelicula] FOREIGN KEY([IDPelicula])
REFERENCES [dbo].[Pelicula] ([IDPelicula])
GO
ALTER TABLE [dbo].[Horario] CHECK CONSTRAINT [FK_Horario_Pelicula]
GO
ALTER TABLE [dbo].[Horario]  WITH CHECK ADD  CONSTRAINT [FK_Horario_Sala] FOREIGN KEY([IDSala])
REFERENCES [dbo].[Sala] ([IDSala])
GO
ALTER TABLE [dbo].[Horario] CHECK CONSTRAINT [FK_Horario_Sala]
GO
ALTER TABLE [dbo].[Posicion]  WITH CHECK ADD  CONSTRAINT [FK_Posicion_Trabajadores] FOREIGN KEY([IDTrabajador])
REFERENCES [dbo].[Trabajadores] ([IDTrabajador])
GO
ALTER TABLE [dbo].[Posicion] CHECK CONSTRAINT [FK_Posicion_Trabajadores]
GO
ALTER TABLE [dbo].[Trabajadores]  WITH CHECK ADD  CONSTRAINT [FK_Trabajadores_Sucursal] FOREIGN KEY([IDSucursal])
REFERENCES [dbo].[Sucursal] ([IDSucursal])
GO
ALTER TABLE [dbo].[Trabajadores] CHECK CONSTRAINT [FK_Trabajadores_Sucursal]
GO
ALTER TABLE [dbo].[Venta_Mostrador]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Mostrador_Sucursal] FOREIGN KEY([IDSucursal])
REFERENCES [dbo].[Sucursal] ([IDSucursal])
GO
ALTER TABLE [dbo].[Venta_Mostrador] CHECK CONSTRAINT [FK_Venta_Mostrador_Sucursal]
GO
ALTER TABLE [dbo].[Venta_Mostrador]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Mostrador_Trabajadores] FOREIGN KEY([IDTrabajador])
REFERENCES [dbo].[Trabajadores] ([IDTrabajador])
GO
ALTER TABLE [dbo].[Venta_Mostrador] CHECK CONSTRAINT [FK_Venta_Mostrador_Trabajadores]
GO
USE [master]
GO
ALTER DATABASE [cine] SET  READ_WRITE 
GO
