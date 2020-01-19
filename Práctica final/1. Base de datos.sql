-- Crea las tablas e inserta cines, salas, películas y actores

CREATE TABLE "CINE"(
	nombre_cine varchar(50) NOT NULL,
	CONSTRAINT "CINE_pk" PRIMARY KEY (nombre_cine)
);

CREATE TABLE "PELICULA"(
	nombre_pelicula varchar(50) NOT NULL,
	sinopsis varchar(1000) NOT NULL,
	pagina_oficial varchar(100) NOT NULL,
	titulo_original varchar(50) NOT NULL,
	genero varchar(50) NOT NULL,
	nacionalidad varchar(50) NOT NULL,
	duracion integer NOT NULL,
	anyo integer NOT NULL,
	distribuidora varchar(50) NOT NULL,
	director varchar(50) NOT NULL,
	clasificacion_edad integer NOT NULL,
	otros_datos varchar(1000),
	CONSTRAINT "PELICULA_pk" PRIMARY KEY (nombre_pelicula)
);

CREATE TABLE "SALA"(
	id_sala integer NOT NULL,
	filas integer NOT NULL,
	columnas integer NOT NULL,
	numero_sala integer NOT NULL,
	nombre_cine varchar(50) NOT NULL,
	CONSTRAINT "SALA_pk" PRIMARY KEY (id_sala)
);

CREATE TABLE "CLIENTE"(
	nombre varchar(50) NOT NULL,
	apellidos varchar(100) NOT NULL,
	telefono varchar(9) NOT NULL,
	correo varchar(100) NOT NULL,
	contrasenya varchar(50) NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (correo)
);

CREATE TABLE "ACTOR"(
	nombre_actor varchar(100) NOT NULL,
	CONSTRAINT "ACTOR_pk" PRIMARY KEY (nombre_actor)
);

CREATE TABLE "ACTUA_EN"(
	nombre_actor varchar(100) NOT NULL,
	nombre_pelicula varchar(50) NOT NULL,
	CONSTRAINT "ACTUA_EN_pk" PRIMARY KEY (nombre_actor,nombre_pelicula)
);

CREATE TABLE "ENTRADA" (
	id_entrada varchar(50) NOT NULL,
	id_proyeccion integer NOT NULL,
	fila integer NOT NULL,
	columna integer NOT NULL,
	precio float NOT NULL,
	CONSTRAINT "ENTRADA_pk" PRIMARY KEY (id_entrada)
);

CREATE TABLE "CLIENTE_TIENE_ENTRADA" (
	correo varchar(100) NOT NULL,
	id_entrada varchar(50) NOT NULL,
	CONSTRAINT "CLIENTE_TIENE_ENTRADA_PK" PRIMARY KEY(correo, id_entrada)
);


CREATE TABLE "PROYECCION"(
	id_proyeccion integer NOT NULL,
	nombre_cine varchar(50) NOT NULL,
	id_sala integer NOT NULL,
	hora time NOT NULL,
	fecha date NOT NULL,
	nombre_pelicula varchar(50) NOT NULL,
	precio float NOT NULL, -- NUEVO
	CONSTRAINT "PROYECCION_pk" PRIMARY KEY (id_proyeccion)
);

CREATE TABLE "SITIO"(
	fila integer NOT NULL,
	columna integer NOT NULL,
	id_proyeccion integer NOT NULL,
	reservado boolean NOT NULL,
	hora_reserva time, 
	ocupado boolean NOT NULL,
	CONSTRAINT "SITIO_pk" PRIMARY KEY (id_proyeccion, fila, columna)
);

CREATE TABLE "COMENTARIO"(
	correo varchar(100) NOT NULL,
	nombre_pelicula varchar(50) NOT NULL,
	puntuacion integer NOT NULL,
	comentario varchar(1000) NOT NULL,
	CONSTRAINT "COMENTARIO_pk" PRIMARY KEY (correo,nombre_pelicula)
);

ALTER TABLE "SALA" ADD CONSTRAINT sala_cine FOREIGN KEY (nombre_cine)
REFERENCES "CINE" (nombre_cine) ON DELETE CASCADE;

ALTER TABLE "ACTUA_EN" ADD CONSTRAINT actua_actor FOREIGN KEY (nombre_actor)
REFERENCES "ACTOR" (nombre_actor) ON DELETE CASCADE;

ALTER TABLE "ACTUA_EN" ADD CONSTRAINT actua_pelicula FOREIGN KEY (nombre_pelicula)
REFERENCES "PELICULA" (nombre_pelicula) ON DELETE CASCADE;

ALTER TABLE "PROYECCION" ADD CONSTRAINT proyeccion_pelicula FOREIGN KEY (nombre_pelicula)
REFERENCES "PELICULA" (nombre_pelicula) ON DELETE CASCADE;

ALTER TABLE "PROYECCION" ADD CONSTRAINT proyeccion_sala FOREIGN KEY (id_sala)
REFERENCES "SALA" (id_sala) ON DELETE CASCADE;

ALTER TABLE "PROYECCION" ADD CONSTRAINT proyeccion_cine FOREIGN KEY (nombre_cine)
REFERENCES "CINE" (nombre_cine) ON DELETE CASCADE;

ALTER TABLE "SITIO" ADD CONSTRAINT sitio_proyeccion FOREIGN KEY (id_proyeccion)
REFERENCES "PROYECCION" (id_proyeccion) ON DELETE CASCADE;

ALTER TABLE "COMENTARIO" ADD CONSTRAINT comentario_cliente FOREIGN KEY (correo)
REFERENCES "CLIENTE" (correo) ON DELETE CASCADE;

ALTER TABLE "COMENTARIO" ADD CONSTRAINT comentario_pelicula FOREIGN KEY (nombre_pelicula)
REFERENCES "PELICULA" (nombre_pelicula) ON DELETE CASCADE;

ALTER TABLE "ENTRADA" ADD CONSTRAINT entrada_sitio FOREIGN KEY (id_proyeccion, fila, columna)
REFERENCES "SITIO" (id_proyeccion, fila, columna) ON DELETE CASCADE;

ALTER TABLE "CLIENTE_TIENE_ENTRADA" ADD CONSTRAINT referencia_cliente FOREIGN KEY (correo)
REFERENCES "CLIENTE" (correo) ON DELETE CASCADE;

ALTER TABLE "CLIENTE_TIENE_ENTRADA" ADD CONSTRAINT referencia_entrada FOREIGN KEY (id_entrada)
REFERENCES "ENTRADA" (id_entrada) ON DELETE CASCADE;

-- Son las salas que tendrán los cines. Su formato es el siguiente.
-- INSERT INTO "PELICULA" VALUES ('Título',
-- 'Sinopsis'
-- 'Página oficial oficial', 'Título original', 'Género', 'Nacionalidad', Duración, Año,
-- 'Distribuidora', 'Director',
-- 'Clasificación seguún la edad', 'Otros datos');

INSERT INTO "PELICULA" VALUES ('La maldición',
'Una casa encantada por un espíritu vengativo maldice a todos aquellos que entran en el lugar, llevándolos a tener una muerte violenta.',
'https://imdb.com/title/tt3612126/', 'The Grudge', 'Terror', 'Estados Unidos', 94, 2020,
'Sony Pictures Entertainment (SPE)', 'Nicolas Pesce',
18, null);

INSERT INTO "PELICULA" VALUES ('Richard Jewell',
'Richard Jewell era un guardia de seguridad de los Juegos Olímpicos de Atlanta 1996 que descubrió una mochila con explosivos en su interior y evitó un número mayor de víctimas al ayudar a evacuar el área poco antes de que se produjera el estallido. En un principio se le presentó como un héroe cuya intervención salvó vidas, pero posteriormente Jewell pasó a ser considerado el sospechoso número uno y fue investigado como presunto culpable.',
'https://www.imdb.com/title/tt3513548/', 'Richard Jewell', 'Drama', 'Estados Unidos', 131, 2019,
'Warner Bros. Brasil', 'Clint Eastwood',
12, null);

INSERT INTO "PELICULA" VALUES ('El oficial y el espía',
'El capitán Alfred Dreyfus, un joven oficial judío, es degradado por espiar para Alemania y condenado a cadena perpetua en la isla del Diablo, en la Guayana Francesa. Entre los testigos que hacen posible esta humillación se encuentra el coronel Georges Picquart, encargado de liderar la unidad de contrainteligencia que descubrió al espía. Pero cuando Picquart se entera de que se siguen pasando secretos militares a los alemanes, se adentrará en un peligroso laberinto de mentiras y corrupción, poniendo en peligro su honor y su vida.',
'https://www.imdb.com/title/tt2398149/', 'J''accuse', 'Drama', 'Francia', 126, 2019,
'Gaumont / Légende Films / Canal+ / Eliseo Cinema', 'Roman Polanski',
12, null);

INSERT INTO "PELICULA" VALUES ('La gallina Turuleca',
'Turuleca es una gallina singular. Su peculiar aspecto desata las burlas del resto del gallinero, hasta que un día, Isabel, una exprofesora de música, la lleva a vivir a su granja. Allí, feliz y en armonía, la gallina descubre su gran talento oculto con la ayuda de Isabel: ¡Turuleca no sólo puede hablar, sino que canta como jamás has oído cantar a una gallina!',
'https://www.imdb.com/title/tt8790552/', 'Turu, the Wacky Hen', 'Animación', 'España', 79, 2020,
'Filmax', 'Eduardo Gondell',
0, null);

INSERT INTO "PELICULA" VALUES ('El silencio del pantano',
'"Q" es periodista y un reconocido escritor de novela negra. En su obra se relatan los crímenes de un asesino en serie utilizando como telón de fondo la corrupción política y la mezquindad del alma humana. La paradoja es que los crímenes que tienen lugar en sus novelas no son tan ficticios como parecen.',
'https://www.imdb.com/title/tt8743032/', 'El silencio del pantano', 'Thriller', 'España', 87, 2019,
'Zeta Cinema / TVE / Netflix / TV3', 'Marc Vigil',
16, null);

INSERT INTO "PELICULA" VALUES ('Mujercitas',
'Amy, Jo, Beth y Meg son cuatro hermanas en plena adolescencia, que viven con su madre en una Norteamérica que sufre lejanamente su Guerra Civil. Con sus variadas vocaciones artísticas y anhelos juveniles, descubrirán el amor y la importancia de los lazos familiares.',
'https://www.imdb.com/title/tt3281548/', 'Little Women', 'Drama', 'Estados Unidos', 135, 2019,
'Columbia Pictures', 'Greta Gerwig',
0, null);

INSERT INTO "PELICULA" VALUES ('Cats',
'Adaptación del famoso musical de Andrew Lloyd Webber, del mismo título. La trama gira en torno a una tribu de gatos -los Jellicles- durante la noche del año en que toman su más trascendente elección: la de decidir cuál de ellos renacerá en una nueva existencia. La producción teatral se representó ininterrumpidamente 21 años en el West End de Londres, mientras que en Broadway (Nueva York) se mantuvo 18 años en cartel.',
'https://www.imdb.com/title/tt5697572/', 'Cats', 'Musical', 'Reino Unido', 110, 2019,
'Universal Pictures', 'Tom Hooper',
0, null);

INSERT INTO "PELICULA" VALUES ('Espías con disfraz',
'El superespía Lance Sterling y el científico Walter Beckett son casi polos opuestos. Lance es tranquilo, afable y caballeroso. Walter no. Pero lo que le falta a Walter de habilidades sociales lo compensa con ingenio e inventiva, con los que crea increíbles artilugios que Lance usa en sus épicas misiones. Pero cuando los eventos dan un giro inesperado, Walter y Lance de repente tienen que confiar el uno en el otro de una manera completamente nueva. Y si esta extraña pareja no puede aprender a trabajar en equipo, todo el mundo estará en peligro. Adaptación al largometraje del corto de animación homónimo, dirigido y escrito por Lucas Martell en 2009.',
'https://family.foxmovies.com/movies/spies-in-disguise', 'Spies in Disguise', 'Animación', 'Estados Unidos', 101, 2019,
'20th Century Fox', 'Troy Quane, Nick Bruno',
7, null);

INSERT INTO "PELICULA" VALUES ('Dios mío, ¿pero qué te hemos hecho... ahora?',
'Claude y Marie Verneuil, que pasaron un mal rato cuando tuvieron que hacerse a la idea de que sus cuatro hijas se casaban con maridos de origen extranjero, aunque acabaron aceptándolo, atraviesan de nuevo una crisis. Los cuatro yernos, Rachid, David, Chao y Charles, han decidido irse de Francia por motivos distintos. Los Verneuil se ven ya viviendo en el extranjero...',
'https://www.imdb.com/title/tt6556670/', 'Qu''est-ce qu''on a encore fait au bon Dieu?', 'Comedia', 'Francia', 99, 2018,
'TF1 Films Production', 'Philippe de Chauveron',
7, null);

INSERT INTO "PELICULA" VALUES ('Frozen II',
'¿Por qué nació Elsa con poderes mágicos? La respuesta le está llamando y amenaza su reino. Junto con Anna, Kristoff, Olaf y Sven emprenderá un viaje peligroso e inolvidable. En "Frozen" Elsa temía que sus poderes fueran demasiado para el mundo, en "Frozen II" deseará que sean... suficientes.',
'https://www.imdb.com/title/tt4520988/', 'Frozen II', 'Animación', 'Estados Unidos', 103, 2019,
'Disney', 'Chris Buck, Jennifer Lee',
0, null);

INSERT INTO "PELICULA" VALUES ('Joker',
'Protagonizada por Joaquin Phoenix como Arthur Fleck, la película explorará los orígenes del personaje, mostrando la historia de un hombre derribado por la sociedad que se convierte en el hombre que conocemos como el Joker.',
'https://www.imdb.com/title/tt7286456/', 'Joker', 'Thriller', 'Estados Unidos', 121, 2019,
'Warner Bros.', 'Todd Phillips',
18, null);

INSERT INTO "PELICULA" VALUES ('Jumanji: Siguiente nivel',
'En esta ocasión, los "jugadores" vuelven al juego, pero sus personajes se han intercambiado entre sí, lo que ofrece un curioso plantel: los mismos héroes con distinta apariencia. Pero, ¿dónde está el resto de la gente? Los participantes sólo tienen una opción: jugar una vez más a esta peligrosa partida para descubrir qué es realmente lo que está sucediendo.',
'https://www.imdb.com/title/tt7975244/', 'Jumanji: The Next Level', 'Aventuras', 'Estados Unidos', 123, 2019,
'Columbia Pictures', 'Jake Kasdan',
7, null);

INSERT INTO "PELICULA" VALUES ('La verdad',
'Fabienne es una de las grandes estrellas del cine francés, una actriz que reina entre los hombres que la aman y admiran, pero en su mundo interior tiene grandes conflictos con Lumir, su hija. Lumir viaja con su marido e hija a París cuando se publican las memorias de su madre. El encuentro no tardará en convertirse en enfrentamiento: se revelarán verdades, se ajustarán cuentas, se hablará de amor y de resentimiento.',
'https://www.imdb.com/title/tt8323120/', 'La vérité (The Truth)', 'Drama', 'Francia', 106, 2019,
'3B Productions / Bun-Buku', 'Hirokazu Koreeda',
0, null);

INSERT INTO "PELICULA" VALUES ('Puñales por la espalda',
'Cuando el renombrado novelista de misterio Harlan Thrombey (Christopher Plummer) es encontrado muerto en su mansión, justo después de la celebración familiar de su 85 cumpleaños, el inquisitivo y cortés detective Benoit Blanc (Daniel Craig) es misteriosamente reclutado para investigar el asunto. Se moverá entre una red de pistas falsas y mentiras interesadas para tratar de descubrir la verdad tras la muerte del escritor.',
'https://knivesout.movie/', 'Knives Out', 'Intriga', 'Estados Unidos', 130, 2019,
'Lionsgate', 'Rian Johnson',
12, null);

INSERT INTO "PELICULA" VALUES ('Si yo fuera rico',
'Santi es un joven en apuros que, de la noche a la mañana, se vuelve rico. Muy rico. El problema es que lo “mejor” que podrá hacer es no contárselo a sus amigos. Y mucho menos a su pareja, claro.',
'https://www.imdb.com/title/tt9010802/', 'Si yo fuera rico', 'Comedia', 'España', 98, 2019,
'Telecinco Cinema', 'Álvaro Fernández Armero',
16, null);

INSERT INTO "PELICULA" VALUES ('Star Wars: El ascenso de Skywalker',
'Un año después de los eventos de "Los últimos Jedi", los restos de la Resistencia se enfrentarán una vez más a la Primera Orden, involucrando conflictos del pasado y del presente. Mientras tanto, el antiguo conflicto entre los Jedi y los Sith llegará a su clímax, lo que llevará a la saga de los Skywalker a un final definitivo. Final de la trilogía iniciada con "El despertar de la Fuerza".',
'https://www.starwars.com/', 'Star Wars: The Rise of Skywalker', 'Ciencia ficción', 'Estados Unidos', 141, 2019,
'Walt Disney Pictures', 'J.J. Abrams',
7, null);

-- Son los cines, su nombre será el de la ciudad donde están
INSERT INTO "CINE" VALUES ('Madrid');
INSERT INTO "CINE" VALUES ('Barcelona');
INSERT INTO "CINE" VALUES ('Valencia');
INSERT INTO "CINE" VALUES ('Sevilla');
INSERT INTO "CINE" VALUES ('Zaragoza');
INSERT INTO "CINE" VALUES ('Málaga');
INSERT INTO "CINE" VALUES ('Murcia');
INSERT INTO "CINE" VALUES ('Palma de Mallorca');
INSERT INTO "CINE" VALUES ('Las Palmas de Gran Canaria');
INSERT INTO "CINE" VALUES ('Bilbao');
INSERT INTO "CINE" VALUES ('Alicante');
INSERT INTO "CINE" VALUES ('Córdoba');
INSERT INTO "CINE" VALUES ('Valladolid');
INSERT INTO "CINE" VALUES ('Vigo');
INSERT INTO "CINE" VALUES ('Gijón');
INSERT INTO "CINE" VALUES ('Hospitalet de Llobregat');
INSERT INTO "CINE" VALUES ('Vitoria');
INSERT INTO "CINE" VALUES ('La Coruña');
INSERT INTO "CINE" VALUES ('Elche');
INSERT INTO "CINE" VALUES ('Granada');
INSERT INTO "CINE" VALUES ('Tarrasa');
INSERT INTO "CINE" VALUES ('Badalona');
INSERT INTO "CINE" VALUES ('Oviedo');
INSERT INTO "CINE" VALUES ('Cartagena');
INSERT INTO "CINE" VALUES ('Sabadell');
INSERT INTO "CINE" VALUES ('Jerez de la Frontera');
INSERT INTO "CINE" VALUES ('Móstoles');
INSERT INTO "CINE" VALUES ('Santa Cruz de Tenerife');
INSERT INTO "CINE" VALUES ('Pamplona');
INSERT INTO "CINE" VALUES ('Almería');
INSERT INTO "CINE" VALUES ('Alcalá de Henares');
INSERT INTO "CINE" VALUES ('Fuenlabrada');
INSERT INTO "CINE" VALUES ('Leganés');
INSERT INTO "CINE" VALUES ('San Sebastián');
INSERT INTO "CINE" VALUES ('Getafe');
INSERT INTO "CINE" VALUES ('Burgos');
INSERT INTO "CINE" VALUES ('Albacete');
INSERT INTO "CINE" VALUES ('Santander');
INSERT INTO "CINE" VALUES ('Castellón de la Plana');
INSERT INTO "CINE" VALUES ('Alcorcón');
INSERT INTO "CINE" VALUES ('San Cristóbal de la Laguna');
INSERT INTO "CINE" VALUES ('Logroño');
INSERT INTO "CINE" VALUES ('Badajoz');
INSERT INTO "CINE" VALUES ('Salamanca');
INSERT INTO "CINE" VALUES ('Huelva');
INSERT INTO "CINE" VALUES ('Marbella');
INSERT INTO "CINE" VALUES ('Lérida');
INSERT INTO "CINE" VALUES ('Tarragona');
INSERT INTO "CINE" VALUES ('Dos Hermanas');
INSERT INTO "CINE" VALUES ('Torrejón de Ardoz');

-- Son las SALAs
INSERT INTO "SALA" VALUES (1, 8, 10, 1, 'Madrid');
INSERT INTO "SALA" VALUES (2, 8, 10, 1, 'Barcelona');
INSERT INTO "SALA" VALUES (3, 8, 10, 1, 'Valencia');
INSERT INTO "SALA" VALUES (4, 8, 10, 1, 'Sevilla');
INSERT INTO "SALA" VALUES (5, 8, 10, 1, 'Zaragoza');
INSERT INTO "SALA" VALUES (6, 8, 10, 1, 'Málaga');
INSERT INTO "SALA" VALUES (7, 8, 10, 1, 'Murcia');
INSERT INTO "SALA" VALUES (8, 8, 10, 1, 'Palma de Mallorca');
INSERT INTO "SALA" VALUES (9, 8, 10, 1, 'Las Palmas de Gran Canaria');
INSERT INTO "SALA" VALUES (10, 8, 10, 1, 'Bilbao');
INSERT INTO "SALA" VALUES (11, 8, 10, 1, 'Alicante');
INSERT INTO "SALA" VALUES (12, 8, 10, 1, 'Córdoba');
INSERT INTO "SALA" VALUES (13, 8, 10, 1, 'Valladolid');
INSERT INTO "SALA" VALUES (14, 8, 10, 1, 'Vigo');
INSERT INTO "SALA" VALUES (15, 8, 10, 1, 'Gijón');
INSERT INTO "SALA" VALUES (16, 8, 10, 1, 'Hospitalet de Llobregat');
INSERT INTO "SALA" VALUES (17, 8, 10, 1, 'Vitoria');
INSERT INTO "SALA" VALUES (18, 8, 10, 1, 'La Coruña');
INSERT INTO "SALA" VALUES (19, 8, 10, 1, 'Elche');
INSERT INTO "SALA" VALUES (20, 8, 10, 1, 'Granada');
INSERT INTO "SALA" VALUES (21, 8, 10, 1, 'Tarrasa');
INSERT INTO "SALA" VALUES (22, 8, 10, 1, 'Badalona');
INSERT INTO "SALA" VALUES (23, 8, 10, 1, 'Oviedo');
INSERT INTO "SALA" VALUES (24, 8, 10, 1, 'Cartagena');
INSERT INTO "SALA" VALUES (25, 8, 10, 1, 'Sabadell');
INSERT INTO "SALA" VALUES (26, 8, 10, 1, 'Jerez de la Frontera');
INSERT INTO "SALA" VALUES (27, 8, 10, 1, 'Móstoles');
INSERT INTO "SALA" VALUES (28, 8, 10, 1, 'Santa Cruz de Tenerife');
INSERT INTO "SALA" VALUES (29, 8, 10, 1, 'Pamplona');
INSERT INTO "SALA" VALUES (30, 8, 10, 1, 'Almería');
INSERT INTO "SALA" VALUES (31, 8, 10, 1, 'Alcalá de Henares');
INSERT INTO "SALA" VALUES (32, 8, 10, 1, 'Fuenlabrada');
INSERT INTO "SALA" VALUES (33, 8, 10, 1, 'Leganés');
INSERT INTO "SALA" VALUES (34, 8, 10, 1, 'San Sebastián');
INSERT INTO "SALA" VALUES (35, 8, 10, 1, 'Getafe');
INSERT INTO "SALA" VALUES (36, 8, 10, 1, 'Burgos');
INSERT INTO "SALA" VALUES (37, 8, 10, 1, 'Albacete');
INSERT INTO "SALA" VALUES (38, 8, 10, 1, 'Santander');
INSERT INTO "SALA" VALUES (39, 8, 10, 1, 'Castellón de la Plana');
INSERT INTO "SALA" VALUES (40, 8, 10, 1, 'Alcorcón');
INSERT INTO "SALA" VALUES (41, 8, 10, 1, 'San Cristóbal de la Laguna');
INSERT INTO "SALA" VALUES (42, 8, 10, 1, 'Logroño');
INSERT INTO "SALA" VALUES (43, 8, 10, 1, 'Badajoz');
INSERT INTO "SALA" VALUES (44, 8, 10, 1, 'Salamanca');
INSERT INTO "SALA" VALUES (45, 8, 10, 1, 'Huelva');
INSERT INTO "SALA" VALUES (46, 8, 10, 1, 'Marbella');
INSERT INTO "SALA" VALUES (47, 8, 10, 1, 'Lérida');
INSERT INTO "SALA" VALUES (48, 8, 10, 1, 'Tarragona');
INSERT INTO "SALA" VALUES (49, 8, 10, 1, 'Dos Hermanas');
INSERT INTO "SALA" VALUES (50, 8, 10, 1, 'Torrejón de Ardoz');
INSERT INTO "SALA" VALUES (51, 8, 10, 2, 'Madrid');
INSERT INTO "SALA" VALUES (52, 8, 10, 3, 'Madrid');
INSERT INTO "SALA" VALUES (53, 8, 10, 4, 'Madrid');
INSERT INTO "SALA" VALUES (54, 8, 10, 5, 'Madrid');

--Inserta actores y actuaciones
INSERT INTO "ACTOR" VALUES ('Sarah Michelle');
INSERT INTO "ACTOR" VALUES ('Takaro Fuji');
INSERT INTO "ACTOR" VALUES ('Yuya Ozeki');
INSERT INTO "ACTOR" VALUES ('Paul Walter Hauser');
INSERT INTO "ACTOR" VALUES ('Olivia Wilde');
INSERT INTO "ACTOR" VALUES ('Sam Rockwell');
INSERT INTO "ACTOR" VALUES ('Jean Dujardin');
INSERT INTO "ACTOR" VALUES ('Louis Garrel');
INSERT INTO "ACTOR" VALUES ('Emmanuelle Seigner');
INSERT INTO "ACTOR" VALUES ('Jose Mota');
INSERT INTO "ACTOR" VALUES ('Eva Hache');
INSERT INTO "ACTOR" VALUES ('Nacho Fresneda');
INSERT INTO "ACTOR" VALUES ('Pedro Alonso');
INSERT INTO "ACTOR" VALUES ('Luis Zahera');
INSERT INTO "ACTOR" VALUES ('Saoirse Ronan');
INSERT INTO "ACTOR" VALUES ('Timothee Chalamet');
INSERT INTO "ACTOR" VALUES ('Emma Watson');
INSERT INTO "ACTOR" VALUES ('Taylor Swift');
INSERT INTO "ACTOR" VALUES ('Jennifer Hudson');
INSERT INTO "ACTOR" VALUES ('Judi Dench');
INSERT INTO "ACTOR" VALUES ('Will Smith');
INSERT INTO "ACTOR" VALUES ('Tom Holland');
INSERT INTO "ACTOR" VALUES ('Karen Gillan');
INSERT INTO "ACTOR" VALUES ('Christian Clavier');
INSERT INTO "ACTOR" VALUES ('Ary Abittan');
INSERT INTO "ACTOR" VALUES ('Chantal Lauby');
INSERT INTO "ACTOR" VALUES ('Idina Menzel');
INSERT INTO "ACTOR" VALUES ('Kristen Bell');
INSERT INTO "ACTOR" VALUES ('Josh Gad');
INSERT INTO "ACTOR" VALUES ('Joaquin Phoenix');
INSERT INTO "ACTOR" VALUES ('Robert De Niro');
INSERT INTO "ACTOR" VALUES ('Brett Cullen');
INSERT INTO "ACTOR" VALUES ('Dwayne Johnson');
INSERT INTO "ACTOR" VALUES ('Kevin Hart');
INSERT INTO "ACTOR" VALUES ('Elena Rivera');
INSERT INTO "ACTOR" VALUES ('Jon Kortajarena');
INSERT INTO "ACTOR" VALUES ('Lydia Bosch');
INSERT INTO "ACTOR" VALUES ('Ana de Armas');
INSERT INTO "ACTOR" VALUES ('Chris Evans');
INSERT INTO "ACTOR" VALUES ('Daniel Craig');
INSERT INTO "ACTOR" VALUES ('Alex Garcia Fernandez');
INSERT INTO "ACTOR" VALUES ('Alexandra Jimenez');
INSERT INTO "ACTOR" VALUES ('Antonio Resines');
INSERT INTO "ACTOR" VALUES ('Daisy Ridley');
INSERT INTO "ACTOR" VALUES ('John Boyega');
INSERT INTO "ACTOR" VALUES ('Oscar Isaac');

INSERT INTO "ACTUA_EN" VALUES ('Sarah Michelle','La maldición');
INSERT INTO "ACTUA_EN" VALUES ('Takaro Fuji','La maldición');
INSERT INTO "ACTUA_EN" VALUES ('Yuya Ozeki','La maldición');
INSERT INTO "ACTUA_EN" VALUES ('Paul Walter Hauser','Richard Jewell');
INSERT INTO "ACTUA_EN" VALUES ('Olivia Wilde','Richard Jewell');
INSERT INTO "ACTUA_EN" VALUES ('Sam Rockwell','Richard Jewell');
INSERT INTO "ACTUA_EN" VALUES ('Jean Dujardin','El oficial y el espía');
INSERT INTO "ACTUA_EN" VALUES ('Louis Garrel','El oficial y el espía');
INSERT INTO "ACTUA_EN" VALUES ('Emmanuelle Seigner','El oficial y el espía');
INSERT INTO "ACTUA_EN" VALUES ('Jose Mota','La gallina Turuleca');
INSERT INTO "ACTUA_EN" VALUES ('Eva Hache','La gallina Turuleca');
INSERT INTO "ACTUA_EN" VALUES ('Nacho Fresneda','El silencio del pantano');
INSERT INTO "ACTUA_EN" VALUES ('Pedro Alonso','El silencio del pantano');
INSERT INTO "ACTUA_EN" VALUES ('Luis Zahera','El silencio del pantano');
INSERT INTO "ACTUA_EN" VALUES ('Saoirse Ronan','Mujercitas');
INSERT INTO "ACTUA_EN" VALUES ('Timothee Chalamet','Mujercitas');
INSERT INTO "ACTUA_EN" VALUES ('Emma Watson','Mujercitas');
INSERT INTO "ACTUA_EN" VALUES ('Taylor Swift','Cats');
INSERT INTO "ACTUA_EN" VALUES ('Jennifer Hudson','Cats');
INSERT INTO "ACTUA_EN" VALUES ('Judi Dench','Cats');
INSERT INTO "ACTUA_EN" VALUES ('Will Smith','Espías con disfraz');
INSERT INTO "ACTUA_EN" VALUES ('Tom Holland','Espías con disfraz');
INSERT INTO "ACTUA_EN" VALUES ('Karen Gillan','Espías con disfraz');
INSERT INTO "ACTUA_EN" VALUES ('Christian Clavier','Dios mío, ¿pero qué te hemos hecho... ahora?');
INSERT INTO "ACTUA_EN" VALUES ('Ary Abittan','Dios mío, ¿pero qué te hemos hecho... ahora?');
INSERT INTO "ACTUA_EN" VALUES ('Chantal Lauby','Dios mío, ¿pero qué te hemos hecho... ahora?');
INSERT INTO "ACTUA_EN" VALUES ('Idina Menzel','Frozen II');
INSERT INTO "ACTUA_EN" VALUES ('Kristen Bell','Frozen II');
INSERT INTO "ACTUA_EN" VALUES ('Josh Gad','Frozen II');
INSERT INTO "ACTUA_EN" VALUES ('Joaquin Phoenix','Joker');
INSERT INTO "ACTUA_EN" VALUES ('Robert De Niro','Joker');
INSERT INTO "ACTUA_EN" VALUES ('Brett Cullen','Joker');
INSERT INTO "ACTUA_EN" VALUES ('Dwayne Johnson','Jumanji: Siguiente nivel');
INSERT INTO "ACTUA_EN" VALUES ('Karen Gillan','Jumanji: Siguiente nivel');
INSERT INTO "ACTUA_EN" VALUES ('Kevin Hart','Jumanji: Siguiente nivel');
INSERT INTO "ACTUA_EN" VALUES ('Elena Rivera','La verdad');
INSERT INTO "ACTUA_EN" VALUES ('Jon Kortajarena','La verdad');
INSERT INTO "ACTUA_EN" VALUES ('Lydia Bosch','La verdad');
INSERT INTO "ACTUA_EN" VALUES ('Ana de Armas','Puñales por la espalda');
INSERT INTO "ACTUA_EN" VALUES ('Chris Evans','Puñales por la espalda');
INSERT INTO "ACTUA_EN" VALUES ('Daniel Craig','Puñales por la espalda');
INSERT INTO "ACTUA_EN" VALUES ('Alex Garcia Fernandez','Si yo fuera rico');
INSERT INTO "ACTUA_EN" VALUES ('Alexandra Jimenez','Si yo fuera rico');
INSERT INTO "ACTUA_EN" VALUES ('Antonio Resines','Si yo fuera rico');
INSERT INTO "ACTUA_EN" VALUES ('Daisy Ridley','Star Wars: El ascenso de Skywalker');
INSERT INTO "ACTUA_EN" VALUES ('John Boyega','Star Wars: El ascenso de Skywalker');
INSERT INTO "ACTUA_EN" VALUES ('Oscar Isaac','Star Wars: El ascenso de Skywalker');