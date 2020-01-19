-- Creo base de datos
CREATE DATABASE 'Universidad' 

-- Añado tablas

-- -- Tabla profesor
CREATE TABLE Profesor (
  DNI varchar(15) NOT NULL,
  Nombre varchar(20) NOT NULL,
  Apellido varchar(30) NOT NULL,
  Sueldo FLOAT NOT NULL
);

-- -- Tabla asignatura
CREATE TABLE Asignatura (
  IdAsignatura varchar(15) NOT NULL,
  Nombre varchar(20) NOT NULL,
  Descripcion varchar(30) NOT NULL,
  DNI varchar(15) NOT NULL
);

-- -- Tabla alumno
CREATE TABLE Alumno (
  DNI varchar(15) NOT NULL,
  Nombre varchar(20) NOT NULL,
  Apellido varchar(30) NOT NULL,
  Sueldo FLOAT NOT NULL
);

-- -- Tabla intermedia de relación "alumno asiste a clase"
CREATE TABLE Asiste (
  DNI varchar(15) NOT NULL, -- dni del alumno
  IdAsignatura varchar(15) NOT NULL -- id de asignatura
);

-- Añado PKs
ALTER TABLE Profesor ADD CONSTRAINT KEY_PROFESOR PRIMARY KEY(DNI);
ALTER TABLE Asignatura ADD CONSTRAINT KEY_ASIGNATURA PRIMARY KEY(IdAsignatura);
ALTER TABLE Alumno ADD CONSTRAINT KEY_AUMNO PRIMARY KEY(DNI);

-- Relación 1 profesor imparte N asignaturas
ALTER TABLE Asignatura ADD CONSTRAINT Imparte FOREIGN KEY(DNI) REFERENCES Profesor(DNI);

-- Relación 1:N alumnos asisten a 1:N asignaturas
-- -- Creo PK conjunta en Asiste
ALTER TABLE Asiste ADD CONSTRAINT KEY_ASISTE PRIMARY KEY(DNI, IdAsignatura);

-- -- Añado referencias de la PK de la tabla intermedia a las tablas relacionadas
ALTER TABLE Asiste ADD CONSTRAINT ALUMNO_ASISTE FOREIGN KEY(DNI) REFERENCES Alumno(DNI);
ALTER TABLE Asiste ADD CONSTRAINT ASIGNATURA_ASISTE FOREIGN KEY(IdAsignatura) REFERENCES Asignatura(IdAsignatura);

-- Valores añadidos a la BBDD para comprobar su funcionamiento.

INSERT INTO Profesor VALUES('123456789N','Roberto','Bachatas',1500);

INSERT INTO Asignatura VALUES('ASIG9','Web','Asignatura de hacer webs','123456789N');

INSERT INTO Alumno VALUES('25395723F','Daniel','Manzano',-1);

INSERT INTO Asiste VALUES('25395723F','ASIG9');
