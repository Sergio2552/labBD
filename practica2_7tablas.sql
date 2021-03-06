USE [master]
GO
/****** Object:  Database [practica_tablas]    Script Date: 09/09/2017 01:00:22 p.m. ******/
CREATE DATABASE [practica_tablas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'practica_tablas', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\practica_tablas.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'practica_tablas_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\practica_tablas_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [practica_tablas] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [practica_tablas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [practica_tablas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [practica_tablas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [practica_tablas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [practica_tablas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [practica_tablas] SET ARITHABORT OFF 
GO
ALTER DATABASE [practica_tablas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [practica_tablas] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [practica_tablas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [practica_tablas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [practica_tablas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [practica_tablas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [practica_tablas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [practica_tablas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [practica_tablas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [practica_tablas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [practica_tablas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [practica_tablas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [practica_tablas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [practica_tablas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [practica_tablas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [practica_tablas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [practica_tablas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [practica_tablas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [practica_tablas] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [practica_tablas] SET  MULTI_USER 
GO
ALTER DATABASE [practica_tablas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [practica_tablas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [practica_tablas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [practica_tablas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [practica_tablas]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[ID-UNIQUE] [uniqueidentifier] NOT NULL,
	[id] [nchar](10) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[Direccion] [varchar](70) NOT NULL,
	[Fecha_nacimiento] [date] NOT NULL,
	[Edad]  AS (datediff(year,[Fecha_nacimiento],getdate())),
	[Nombre_completo]  AS (concat([Nombres],[APellidos])),
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ID-UNIQUE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Juegos]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Juegos](
	[ID] [nchar](10) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Plataforma] [varchar](15) NOT NULL,
	[Genero] [varchar](20) NOT NULL,
	[Precio_renta] [money] NOT NULL,
	[Precio_compra] [money] NOT NULL,
 CONSTRAINT [PK_Juegos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Licencias]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Licencias](
	[ID] [nchar](10) NOT NULL,
	[Tipo] [nchar](30) NOT NULL,
	[Plataforma] [varchar](20) NOT NULL,
	[Precio] [money] NOT NULL,
 CONSTRAINT [PK_Licencias] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pelicula]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pelicula](
	[ID] [nchar](10) NOT NULL,
	[Nombre_Pelicula] [varchar](50) NOT NULL,
	[Genero] [varchar](20) NOT NULL,
	[Duracion] [int] NOT NULL,
	[Estreno] [date] NOT NULL,
	[Precio_renta] [money] NOT NULL,
	[Precio_compra] [money] NOT NULL,
 CONSTRAINT [PK_Pelicula] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rentas]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rentas](
	[ID] [nchar](10) NOT NULL,
	[Fecha_de_pedido] [datetime] NOT NULL,
	[Fecha_de_vencimiento] [datetime] NOT NULL,
	[Tipo_de_renta] [nvarchar](10) NOT NULL,
	[id_cliente] [uniqueidentifier] NOT NULL,
	[tiempo_restante_de_devolucion]  AS (datediff(hour,[Fecha_de_pedido],[Fecha_de_vencimiento])),
 CONSTRAINT [PK_Rentas] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Series]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Series](
	[ID] [nchar](10) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Genero] [varchar](15) NOT NULL,
	[Temporadas] [int] NOT NULL,
	[Precio_renta] [money] NOT NULL,
	[Precio_compra] [money] NOT NULL,
 CONSTRAINT [PK_Series] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sucursal]    Script Date: 09/09/2017 01:00:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursal](
	[ID] [nchar](10) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_Clientes]    Script Date: 09/09/2017 01:00:22 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Clientes] ON [dbo].[Clientes]
(
	[ID-UNIQUE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Rentas]  WITH CHECK ADD  CONSTRAINT [FK_Rentas_Rentas] FOREIGN KEY([ID])
REFERENCES [dbo].[Rentas] ([ID])
GO
ALTER TABLE [dbo].[Rentas] CHECK CONSTRAINT [FK_Rentas_Rentas]
GO
USE [master]
GO
ALTER DATABASE [practica_tablas] SET  READ_WRITE 
GO
