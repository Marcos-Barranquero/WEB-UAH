-- DROP TABLE IF EXISTS "CIRCUITO" CASCADE;
CREATE TABLE "CIRCUITO"(
	nombre varchar(20) NOT NULL,
	ciudad varchar(20) NOT NULL,
	pais varchar(20) NOT NULL,
	vueltas integer NOT NULL,
	longitud integer NOT NULL,
	curvas integer NOT NULL,
	CONSTRAINT "CIRCUITO_pk" PRIMARY KEY (nombre)
);

-- DROP TABLE IF EXISTS "COCHE" CASCADE;
CREATE TABLE "COCHE"(
	nombre varchar(20) NOT NULL,
	kwcurva integer NOT NULL,
	CONSTRAINT "COCHE_pk" PRIMARY KEY (nombre)
);

-- Datos para poblar un poco la BBDD
INSERT INTO "CIRCUITO" VALUES('Albert Park','Australia','Sydney',55,5303,16)

INSERT INTO "COCHE" VALUES('Perdigon',5)