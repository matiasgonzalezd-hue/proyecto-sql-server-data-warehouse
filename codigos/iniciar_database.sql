/*
====================================================================================
Crear la base de Datos y los Schemas
====================================================================================

Proposito del Código:
	Este código crea una nueva Base de Datos llamada 'DataWareHouse2026' luego de validar si ya existe.
	Si es que ya existiera una Base de Datos con ese nombre entonces se dropea y se recrea. Adicionalmente el código
	genera tambien tres schemas dentro de la Base de Datos: 'bronce', 'plata', 'oro'.

AVISO:
	Ejecutar este código eliminará por completo la Base de Datos 'DataWareHouse2026' si es que existe.
	Toda la data en la Base de Datos será borrada permanentemente. Se debe proceder con preacución 
	Y teniendo la seguridad de que se han realizado los BackUp correspondientes antes de ejecutar el código.
*/


USE master;
GO

-- Dropear y Recrear la base de Datos 'DataWareHouse2026'
IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse2026')
BEGIN
	ALTER DATABASE DataWareHouse2026 SET SINGLE_USER WITH ROLLBACK INMEDIATE;
	DROP DATABASE DataWareHouse2026;
END;
GO

-- Crear la Base de Datos 'DataWareHouse2026'
CREATE DATABASE DataWareHouse2026;
GO

USE DataWareHouse2026;
GO

-- Crear los Schemas

CREATE SCHEMA bronce;
GO

CREATE SCHEMA plata;
GO

CREATE SCHEMA oro;
GO
