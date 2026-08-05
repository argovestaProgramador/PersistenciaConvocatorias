
USE master;

GO

DROP DATABASE IF EXISTS Convocatorias;

GO

CREATE DATABASE Convocatorias;

GO

USE Convocatorias;

GO

CREATE SCHEMA Seguridad;

GO

CREATE SCHEMA Reclutamiento;

GO

CREATE TABLE Seguridad.RolesUsuario(
	idRolUsuario INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkIdRolUsuario PRIMARY KEY (idRolUsuario),
	CONSTRAINT uqNombreUnicoRolesUsuario UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistrosRolesUsuario CHECK ( estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Seguridad.Usuarios(
	idUsuario INT IDENTITY(1,1) NOT NULL,
	idRolUsuario INT NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	apellidoPaterno NVARCHAR(50) NOT NULL,
	apellidoMaterno NVARCHAR(50) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	correoElectronico NVARCHAR(100) NOT NULL,
	usu NVARCHAR(50) NOT NULL,
	passHash NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkIdUsuario PRIMARY KEY (idUsuario),
	CONSTRAINT fkIdRolesUsuarioUsuario FOREIGN KEY (idRolUsuario) REFERENCES Seguridad.RolesUsuario(idRolUsuario),
	CONSTRAINT uqCorreoElectronicoUsuario UNIQUE (correoElectronico),
	CONSTRAINT uqUsu UNIQUE (usu),
	CONSTRAINT ckEstadoRegistroUsuario CHECK ( estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Seguridad.Empresas(
	idEmpresa INT IDENTITY(1,1) NOT NULL,
	idUsuario INT NOT NULL,
	razonSocial NVARCHAR(250) NOT NULL,
	nombreComercial NVARCHAR(250) NOT NULL,
	ruc NCHAR(11) NOT NULL,
	direccionFisica NVARCHAR(250) NOT NULL,
	telefono NCHAR(9) NOT NULL,
	correoElectronico NVARCHAR(100) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkEmpresa PRIMARY KEY (idEmpresa),
	CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (idUsuario) REFERENCES Seguridad.Usuarios(idUsuario),
	CONSTRAINT uqRazonSocial UNIQUE (razonSocial),
	CONSTRAINT uqRuc UNIQUE (ruc),
	CONSTRAINT uqDireccionFisica UNIQUE (direccionFisica),
	CONSTRAINT uqTelefonoEmpresa UNIQUE (telefono),
	CONSTRAINT uqCorreoElectronico UNIQUE (correoElectronico),
	CONSTRAINT ckEstadoRegistroEmpresa CHECK ( estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Seguridad.TiposDocumento (
	idTipoDocumento INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(100) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkTipoDocumento PRIMARY KEY (idTipoDocumento),
	CONSTRAINT uqNombreTipoDocumentoUnico UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroTiposDocumento CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Seguridad.TiposExtension (
	idTipoExtension INT IDENTITY(1,1) NOT NULL,
	nombreExtension NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkTipoExtension PRIMARY KEY (idTipoExtension),
	CONSTRAINT uqNombreExtensionUnico UNIQUE (nombreExtension),
	CONSTRAINT ckEstadoRegistroTipoExtension CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Seguridad.Documentos (
	idDocumento INT IDENTITY(1,1) NOT NULL,
	idUsuario INT NOT NULL,
	idTipoDocumento INT NOT NULL,
	idExtension INT NOT NULL,
	rutaRelativa NVARCHAR(250) NOT NULL,
	nombreLogico NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkDocumento PRIMARY KEY (idDocumento),
	CONSTRAINT fkTipoDocumentoDocumentos FOREIGN KEY (idTipoDocumento) REFERENCES Seguridad.TiposDocumento(idTipoDocumento),
	CONSTRAINT fkUsuarioDocumentos FOREIGN KEY (idUsuario) REFERENCES Seguridad.Usuarios(idUsuario),
	CONSTRAINT fkTipoExtensionDocumentos FOREIGN KEY (idTipoDocumento) REFERENCES Seguridad.TiposExtension(idTipoExtension),
	CONSTRAINT uqRutaRelativa UNIQUE (rutaRelativa),
	CONSTRAINT ckEstadoRegistroDocumentos CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.TiposJornada (
	idTipoJornada INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkTipoJornada PRIMARY KEY (idTipoJornada),
	CONSTRAINT uqNombreUnicoTiposJornadas UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroTiposJornada CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.TiposModalidad (
	idTipoModalidad INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkTipoModalidad PRIMARY KEY (idTipoModalidad),
	CONSTRAINT uqNombreUnicoTipoModalidad UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroTiposModalidad CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.Convocatorias (
	idConvocatoria INT IDENTITY(1,1) NOT NULL,
	idTipoModalidad INT NOT NULL,
	idTipoJornada INT NOT NULL,
	idEmpresa INT NOT NULL,
	titulo NVARCHAR(250) NOT NULL,
	descripcion NVARCHAR(550) NOT NULL,
	salarioMinimo DECIMAL(10,2) NOT NULL,
	salarioMaximo DECIMAL(10,2) NOT NULL,
	mostrarSalario BIT NOT NULL,
	fechaInicio DATE NOT NULL,
	fechaFinalizacion DATE NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkConvocatoria PRIMARY KEY (idConvocatoria),
	CONSTRAINT fkTipoModalidadConvocatorias FOREIGN KEY (idTipoModalidad) REFERENCES Reclutamiento.TiposModalidad(idTipoModalidad),
	CONSTRAINT fkTipoJornadaConvocatorias FOREIGN KEY (idTipoJornada) REFERENCES Reclutamiento.TiposJornada(idTipoJornada),
	CONSTRAINT fkEmpresaConvocatorias FOREIGN KEY (idEmpresa) REFERENCES Seguridad.Empresas(idEmpresa),
	CONSTRAINT ckMostrarSalario CHECK (mostrarSalario IN (1, 0)),
	CONSTRAINT ckFechaFinalizacion CHECK (fechaFinalizacion > fechaInicio),
	CONSTRAINT ckEstadoRegistroConvocatorias CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.EstadosPostulacion (
	idEstadoPostulacion INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkEstadoPostulacion PRIMARY KEY (idEstadoPostulacion),
	CONSTRAINT uqNombreUnicoEstadoPostulacion UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroEstadoPostulacion CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.ResolucionesPostulacion (
	idResolucionPostulacion INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkResolucionPostulacion PRIMARY KEY (idResolucionPostulacion),
	CONSTRAINT uqNombreUnicoResolucionPostulacion UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroResolucionPostulacion CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Reclutamiento.Postulaciones (
	idPostulacion INT IDENTITY(1,1) NOT NULL,
	idEstadoPostulacion INT NOT NULL,
	idResolucionPostulacion INT NOT NULL,
	idConvocatoria INT NOT NULL,
	idUsuario INT NOT NULL,
	pretensionSalarial DECIMAL(10,2) NOT NULL,
	fechaPostulacion DATE NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkPostulacion PRIMARY KEY (idPostulacion),
	CONSTRAINT fkEstadoPostulacionPostulaciones FOREIGN KEY (idEstadoPostulacion) REFERENCES Reclutamiento.EstadosPostulacion(idEstadoPostulacion),
	CONSTRAINT fkResolucionPostulacionPostulaciones FOREIGN KEY (idResolucionPostulacion) REFERENCES Reclutamiento.ResolucionesPostulacion(idResolucionPostulacion),
	CONSTRAINT fkConvocatoriaPostulaciones FOREIGN KEY (idConvocatoria) REFERENCES Reclutamiento.Convocatorias(idConvocatoria),
	CONSTRAINT fkUsuarioPostulaciones FOREIGN KEY (idUsuario) REFERENCES Seguridad.Usuarios(idUsuario),
	CONSTRAINT ckEstadoRegistroPostulaciones CHECK (estadoRegistro IN (1, 0))
);

-- registros

INSERT INTO Seguridad.RolesUsuario (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'admin', N'Administrador total del sistema', GETDATE(), 1),
    (N'comun', N'Usuario postulante o candidato', GETDATE(), 1),
    (N'empresa', N'Representante de empresa reclutadora', GETDATE(), 1);
GO

INSERT INTO Seguridad.Usuarios (idRolUsuario, nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, correoElectronico, usu, passHash, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (1, N'Carlos', N'Mendoza', N'Silva', '1988-05-12', N'admin@sistema.com', N'admin_carlos', N'$2a$12$eImiTXuWVxfM37uY4JANjOL.8848r8.11894', GETDATE(), 1),
    (2, N'Juan', N'Pérez', N'Gómez', '1995-08-20', N'juan.perez@email.com', N'jperez', N'$2a$12$eImiTXuWVxfM37uY4JANjOL.8848r8.11894', GETDATE(), 1),
    (3, N'María', N'López', N'Torres', '1990-03-15', N'm.lopez@techcorp.com', N'mlopez_corp', N'$2a$12$eImiTXuWVxfM37uY4JANjOL.8848r8.11894', GETDATE(), 1);
GO

INSERT INTO Seguridad.Empresas (idUsuario, razonSocial, nombreComercial, ruc, direccionFisica, telefono, correoElectronico, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (3, N'TechCorp Solutions S.A.C.', N'TechCorp', N'20123456789', N'Av. Javier Prado Este 1234, San Isidro, Lima', N'987654321', N'contacto@techcorp.com', GETDATE(), 1);
GO

INSERT INTO Seguridad.TiposDocumento (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'CV', N'Curriculum Vitae', GETDATE(), 1),
    (N'DNI', N'Documento Nacional de Identidad', GETDATE(), 1),
    (N'Documento de Extranjería', N'Carné de extranjería', GETDATE(), 1),
    (N'Pasaporte', N'Pasaporte internacional', GETDATE(), 1);
GO

INSERT INTO Seguridad.TiposExtension (nombreExtension, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'.pdf', N'Formato de documento portátil Adobe', GETDATE(), 1),
    (N'.doc', N'Formato de documento Microsoft Word', GETDATE(), 1);
GO

INSERT INTO Seguridad.Documentos (idUsuario, idTipoDocumento, idExtension, rutaRelativa, nombreLogico, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (2, 1, 1, N'/uploads/docs/2026/cv_juan_perez_2026.pdf', N'CV_JuanPerez_Programador.pdf', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.TiposJornada (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'medio tiempo', N'Jornada laboral parcial (Part-time)', GETDATE(), 1),
    (N'tiempo completo', N'Jornada laboral completa (Full-time)', GETDATE(), 1),
    (N'por horas', N'Trabajo por horas o proyectos puntuales', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.TiposModalidad (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'híbrido', N'Modalidad combinada remota y presencial', GETDATE(), 1),
    (N'presencial', N'Trabajo 100% en las instalaciones de la empresa', GETDATE(), 1),
    (N'virtual', N'Trabajo 100% remoto', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.Convocatorias (idTipoModalidad, idTipoJornada, idEmpresa, titulo, descripcion, salarioMinimo, salarioMaximo, mostrarSalario, fechaInicio, fechaFinalizacion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (3, 2, 1, N'Desarrollador Backend Senior C# / SQL', N'Buscamos un desarrollador backend con experiencia comprobada en .NET Core y SQL Server.', 4500.00, 6500.00, 1, '2026-08-01', '2026-09-01', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.EstadosPostulacion (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'enviado', N'La postulación ha sido enviada por el candidato', GETDATE(), 1),
    (N'visto', N'La postulación ha sido revisada por el reclutador', GETDATE(), 1),
    (N'en gestión', N'El candidato está en proceso de evaluación / entrevistas', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.ResolucionesPostulacion (nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (N'pendiente', N'El proceso aún no ha finalizado', GETDATE(), 1),
    (N'contratado', N'El candidato ha sido seleccionado para la posición', GETDATE(), 1),
    (N'rechazado', N'El candidato no continuará en el proceso', GETDATE(), 1);
GO

INSERT INTO Reclutamiento.Postulaciones (idEstadoPostulacion, idResolucionPostulacion, idConvocatoria, idUsuario, pretensionSalarial, fechaPostulacion, fechaCreacionRegistro, estadoRegistro)
VALUES 
    (1, 1, 1, 2, 5000.00, '2026-08-04', GETDATE(), 1);
GO

-- procedimientos Convocatoria

CREATE OR ALTER PROCEDURE Reclutamiento.sp_listarConvocatorias
AS 
	BEGIN
		SELECT con.idConvocatoria,
			   tip.nombre AS "tipoModalidad",
			   jor.nombre AS "tipoJornada",
			   em.nombreComercial AS "empresa",
			   con.titulo,
			   con.descripcion,
			   CASE
				WHEN mostrarSalario = 1 THEN con.SalarioMinimo
				ELSE 0
			   END AS "salarioMinimo",
			   CASE
			    WHEN mostrarSalario = 1 THEN con.SalarioMaximo
				ELSE 0
			   END AS "salarioMaximo",
			   con.fechaInicio,
			   con.fechaFinalizacion
		FROM Reclutamiento.Convocatorias AS con
		INNER JOIN Reclutamiento.TiposModalidad AS tip ON tip.idTipoModalidad = con.idTipoModalidad
		INNER JOIN Reclutamiento.TiposJornada AS jor ON jor.idTipoJornada = con.idTipoJornada
		INNER JOIN Seguridad.Empresas AS em ON em.idEmpresa = con.idEmpresa
		WHERE con.estadoRegistro = 1;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_listarConvocatoriasTipoModalidad
(
	@idTipoModalidad INT
)
AS
	BEGIN
		SELECT con.idConvocatoria,
			   tip.nombre AS "tipoModalidad",
			   jor.nombre AS "tipoJornada",
			   em.nombreComercial AS "empresa",
			   con.titulo,
			   con.descripcion,
			   CASE
				WHEN mostrarSalario = 1 THEN con.SalarioMinimo
				ELSE 0
			   END AS "salarioMinimo",
			   CASE
			    WHEN mostrarSalario = 1 THEN con.SalarioMaximo
				ELSE 0
			   END AS "salarioMaximo",
			   con.fechaInicio,
			   con.fechaFinalizacion
		FROM Reclutamiento.Convocatorias AS con
		INNER JOIN Reclutamiento.TiposModalidad AS tip ON tip.idTipoModalidad = con.idTipoModalidad
		INNER JOIN Reclutamiento.TiposJornada AS jor ON jor.idTipoJornada = con.idTipoJornada
		INNER JOIN Seguridad.Empresas AS em ON em.idEmpresa = con.idEmpresa
		WHERE con.estadoRegistro = 1 AND con.idTipoModalidad = @idTipoModalidad;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_listarConvocatoriasTipoJornada
(
	@idTipoJornada INT
)
AS 
	BEGIN
		SELECT con.idConvocatoria,
			   tip.nombre AS "tipoModalidad",
			   jor.nombre AS "tipoJornada",
			   em.nombreComercial AS "empresa",
			   con.titulo,
			   con.descripcion,
			   CASE
				WHEN mostrarSalario = 1 THEN con.SalarioMinimo
				ELSE 0
			   END AS "salarioMinimo",
			   CASE
			    WHEN mostrarSalario = 1 THEN con.SalarioMaximo
				ELSE 0
			   END AS "salarioMaximo",
			   con.fechaInicio,
			   con.fechaFinalizacion
		FROM Reclutamiento.Convocatorias AS con
		INNER JOIN Reclutamiento.TiposModalidad AS tip ON tip.idTipoModalidad = con.idTipoModalidad
		INNER JOIN Reclutamiento.TiposJornada AS jor ON jor.idTipoJornada = con.idTipoJornada
		INNER JOIN Seguridad.Empresas AS em ON em.idEmpresa = con.idEmpresa
		WHERE con.estadoRegistro = 1 AND con.idTipoJornada = @idTipoJornada;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_listarConvocatoriasEmpresa
(
	@idEmpresa INT
)
AS 
	BEGIN
		SELECT con.idConvocatoria,
			   tip.nombre AS "tipoModalidad",
			   jor.nombre AS "tipoJornada",
			   em.nombreComercial AS "empresa",
			   con.titulo,
			   con.descripcion,
			   CASE
				WHEN mostrarSalario = 1 THEN con.SalarioMinimo
				ELSE 0
			   END AS "salarioMinimo",
			   CASE
			    WHEN mostrarSalario = 1 THEN con.SalarioMaximo
				ELSE 0
			   END AS "salarioMaximo",
			   con.fechaInicio,
			   con.fechaFinalizacion
		FROM Reclutamiento.Convocatorias AS con
		INNER JOIN Reclutamiento.TiposModalidad AS tip ON tip.idTipoModalidad = con.idTipoModalidad
		INNER JOIN Reclutamiento.TiposJornada AS jor ON jor.idTipoJornada = con.idTipoJornada
		INNER JOIN Seguridad.Empresas AS em ON em.idEmpresa = con.idEmpresa
		WHERE con.estadoRegistro = 1 AND con.idEmpresa = @idEmpresa;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_buscarConvocatoriaPorId
(
	@idConvocatoria INT
)
AS
	BEGIN
		SELECT con.idConvocatoria,
			   tip.nombre AS "tipoModalidad",
			   jor.nombre AS "tipoJornada",
			   em.nombreComercial AS "empresa",
			   con.titulo,
			   con.descripcion,
			   CASE
				WHEN mostrarSalario = 1 THEN con.SalarioMinimo
				ELSE 0
			   END AS "salarioMinimo",
			   CASE
			    WHEN mostrarSalario = 1 THEN con.SalarioMaximo
				ELSE 0
			   END AS "salarioMaximo",
			   con.fechaInicio,
			   con.fechaFinalizacion
		FROM Reclutamiento.Convocatorias AS con
		INNER JOIN Reclutamiento.TiposModalidad AS tip ON tip.idTipoModalidad = con.idTipoModalidad
		INNER JOIN Reclutamiento.TiposJornada AS jor ON jor.idTipoJornada = con.idTipoJornada
		INNER JOIN Seguridad.Empresas AS em ON em.idEmpresa = con.idEmpresa
		WHERE con.estadoRegistro = 1 AND con.idConvocatoria = @idConvocatoria;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_crearConvocatoria
(
	@idTipoModalidad INT,
	@idTipoJornada INT,
	@idEmpresa INT,
	@titulo NVARCHAR(250),
	@descripcion NVARCHAR(550),
	@salarioMinimo DECIMAL(10,2),
	@salarioMaximo DECIMAL(10,2),
	@fechaInicio DATE,
	@fechaFinalizacion DATE 
)
AS 
	BEGIN
		INSERT INTO Reclutamiento.Convocatorias(idTipoModalidad, idTipoJornada, idEmpresa, titulo, descripcion, SalarioMinimo, 
				    SalarioMaximo, mostrarSalario, fechaInicio, fechaFinalizacion, fechaCreacionRegistro, estadoRegistro)
		VALUES (@idTipoModalidad, @idTipoJornada, @idEmpresa, @titulo, @descripcion, @salarioMinimo, @salarioMaximo, 1, 
				@fechaInicio, @fechaFinalizacion, GETDATE(), 1);
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_actualizarConvocatoria
(
	@idTipoModalidad INT,
	@idTipoJornada INT,
	@idEmpresa INT,
	@titulo NVARCHAR(250),
	@descripcion NVARCHAR(550),
	@salarioMinimo DECIMAL(10,2),
	@salarioMaximo DECIMAL(10,2),
	@mostrarSalario BIT,
	@fechaInicio DATE,
	@fechaFinalizacion DATE,
	@idConvocatoria INT
)
AS 
	BEGIN
		UPDATE Reclutamiento.Convocatorias
		SET idTipoModalidad = @idTipoModalidad, idTipoJornada = @idTipoJornada, idEmpresa = @idEmpresa, titulo = @titulo, descripcion = @descripcion,
			salarioMinimo = @salarioMinimo, salarioMaximo = @salarioMaximo, mostrarSalario = @mostrarSalario, fechaInicio = @fechaInicio, fechaFinalizacion = @fechaFinalizacion
		WHERE idConvocatoria = @idConvocatoria;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_eliminarConvocatoria
(
	@idConvocatoria INT
)
AS
	BEGIN
		UPDATE Reclutamiento.Convocatorias
		SET estadoRegistro = 0
		WHERE idConvocatoria = @idConvocatoria;
	END;

-- Procedimientos Estados de postulacion

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_listarEstadosPostulacion
AS
	BEGIN
		SELECT est.idEstadoPostulacion,
			   est.nombre,
			   est.descripcion
		FROM Reclutamiento.EstadosPostulacion AS est
		WHERE est.estadoRegistro = 1;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_crearEstadoPostulacion
(
	@nombre NVARCHAR(50),
	@descripcion NVARCHAR(250)
)
AS
	BEGIN
		INSERT INTO Reclutamiento.EstadosPostulacion(nombre, descripcion, fechaCreacionRegistro, estadoRegistro)
		VALUES (@nombre, @descripcion, GETDATE(), 1);
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_actualizarEstadoPostulacion
(
	@nombre NVARCHAR(50),
	@descripcion NVARCHAR(250),
	@idEstadoPostulacion INT
)
AS
	BEGIN
		UPDATE Reclutamiento.EstadosPostulacion
		SET nombre = @nombre, descripcion = @descripcion
		WHERE idEstadoPostulacion = @idEstadoPostulacion;
	END;

GO

CREATE OR ALTER PROCEDURE Reclutamiento.sp_eliminarEstadoPostulacion
(
	@idEstadoPostulacion INT
)
AS
	BEGIN
		UPDATE Reclutamiento.EstadosPostulacion
		SET estadoRegistro = 0
		WHERE idEstadoPostulacion = @idEstadoPostulacion;
	END;

GO

-- Procedimientos Postulaciones

