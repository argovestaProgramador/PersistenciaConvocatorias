
DROP DATABASE IF EXISTS Convocatorias;

GO

CREATE DATABASE Convocatorias;

GO

USE Convocatorias;

GO



GO

CREATE TABLE RolesUsuario(
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

CREATE TABLE Usuario(
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
	CONSTRAINT fkIdRolUsuarioUsuario FOREIGN KEY (idRolUsuario) REFERENCES RolesUsuario(idRolUsuario),
	CONSTRAINT uqCorreoElectronicoUsuario UNIQUE (correoElectronico),
	CONSTRAINT uqUsu UNIQUE (usu),
	CONSTRAINT ckEstadoRegistroUsuario CHECK ( estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Empresa(
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
	CONSTRAINT fkUsuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
	CONSTRAINT uqRazonSocial UNIQUE (razonSocial),
	CONSTRAINT uqRuc UNIQUE (ruc),
	CONSTRAINT uqDireccionFisica UNIQUE (direccionFisica),
	CONSTRAINT uqTelefonoEmpresa UNIQUE (telefono),
	CONSTRAINT uqCorreoElectronico UNIQUE (correoElectronico),
	CONSTRAINT ckEstadoRegistroEmpresa CHECK ( estadoRegistro IN (1, 0))
);

GO

CREATE TABLE TiposDocumento (
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

CREATE TABLE TiposExtension (
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

CREATE TABLE Documentos (
	idDocumento INT IDENTITY(1,1) NOT NULL,
	idUsuario INT NOT NULL,
	idTipoDocumento INT NOT NULL,
	idExtension INT NOT NULL,
	rutaRelativa NVARCHAR(250) NOT NULL,
	nombreLogico NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkDocumento PRIMARY KEY (idDocumento),
	CONSTRAINT fkTipoDocumentoDocumentos FOREIGN KEY (idTipoDocumento) REFERENCES TiposDocumento(idTipoDocumento),
	CONSTRAINT fkUsuarioDocumentos FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
	CONSTRAINT fkTipoExtensionDocumentos FOREIGN KEY (idTipoDocumento) REFERENCES TiposExtension(idTipoExtension),
	CONSTRAINT uqRutaRelativa UNIQUE (rutaRelativa),
	CONSTRAINT ckEstadoRegistroDocumentos CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE TiposJornada (
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

CREATE TABLE TiposModalidad (
	idTipoModalidad INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkTipoModalidad PRIMARY KEY (idTipoModalidad),
	CONSTRAINT uqNombreUnicoTipoModalidad UNIQUE (nombre),
	CONSTRAINT ckEstadoRegistroTiposJornada CHECK (estadoRegistro IN (1, 0))
);

GO

CREATE TABLE Convocatorias (
	idConvocatoria INT IDENTITY(1,1) NOT NULL,
	idTipoModalidad INT NOT NULL,
	idTipoJornada INT NOT NULL,
	idEmpresa INT NOT NULL,
	titulo NVARCHAR(250) NOT NULL,
	descripcion NVARCHAR(550) NOT NULL,
	SalarioMinimo DECIMAL(10,2) NOT NULL,
	SalarioMaximo DECIMAL(10,2) NOT NULL,
	mostrarSalario BIT NOT NULL,
	fechaInicio DATE NOT NULL,
	fechaFinalizacion DATE NOT NULL,
	fechaCreacionRegistro DATE NOT NULL,
	estadoRegistro BIT NOT NULL,

	CONSTRAINT pkConvocatoria PRIMARY KEY (idConvocatoria),
	CONSTRAINT fkTipoModalidadConvocatorias FOREIGN KEY (idTipoModalidad) REFERENCES TiposModalidad(idTipoModalidad),
	CONSTRAINT fkTipoJornadaConvocatorias FOREIGN KEY (idTipoJornada) REFERENCES TiposJornada(idTipoJornada),
	CONSTRAINT fkEmpresaConvocatorias FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa),
	CONSTRAINT ckMostrarSalario CHECK (mostrarSalario IN (1, 0)),
	CONSTRAINT ckFechaFinalizacion CHECK (fechaFinalizacion > fechaInicio),
	CONSTRAINT ckEstadoRegistroConvocatorias CHECK (estadoRegistro IN (1, 0))
);

GO

