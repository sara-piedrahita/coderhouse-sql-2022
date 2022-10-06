/* Ingreso de datos a las tablas de la base de datos */
	-- En cada una de las tablas se agrega informacion y datos
    -- No se agregan los numeros de las PK porque son autoincrementales
USE bibliotecas;

INSERT INTO categorias (categoria, prestamos_necesarios, moras_permitidas)
VALUES
	("asociado", 5,	1),
    ("general",	10, 2),
    ("escolar",	15,	3),
    ("investigador", 25, 5),
    ("empleados", 0, 0),
    ("inclusion", 0, 2);
    
INSERT INTO usuarios_registrados (documento, nombre, apellido, correo, telefono, id_categoria)
VALUES
	(2975621, "deodato", "gonzalez", "gillittappaupreu-7501@yopmail.com", 6863296, 2),
    (2223240, "amparo", "rojas", "naullureurafo-8588@yopmail.com", 7738280, 2),
    (2956885, "vilma", "diaz", "fruxussoxolla-2887@yopmail.com", 7623233, 1),
    (7983909, "caridad", "perez", "noufettamujo-6921@yopmail.com", 4453183, 4),
    (5483344, "amelia", "soto", "tafrugromeumau-9471@gmail.com", 6915953, 4),
    (4343344, "margarita", "silva", "casidekenau-6730@hotmail.com", 8471819, 1),
    (1101923, "rosa", "contreras", "haubullannehei-9103@gmail.com", 9748060, 4),
    (7937529, "claudia", "martinez", "greffeizefanno-6494@gmail.com", 6201597, 4),
    (7841282, "cecilia", "sepulveda", "niquilatretau-6087@yopmail.com", 1783677, 4),
    (2795148, "alicia", "morales", "fuwegedauku-1905@hotmail.com", 5691716, 4),
    (5935175, "teresa", "lopez", "koquouhapisi-4274@yopmail.com", 7614264, 3),
    (6962263, "sara", "piedrahita", "winoimupugra-9927@yopmail.com", 4458721, 1),
    (4817734, "jaime", "sierra", "brojojoiddunna-3187@gmail.com", 6074601, 3),
    (2884542, "alberto", "flores", "hecrefogecru-2400@yopmail.com", 6283722, 1),
    (3955585, "jorge", "torres", "wecravimuna-8259@yopmail.com", 7530686, 6),
	(7674013, "victor", "espinoza", "habouhammemmau-8406@gmail.com", 9759844, 1),
	(5833186, "alonso", "castro", "yiseulagreyeu-7628@yopmail.com", "8460683", 3),
	(6582914, "carlos", "pizarro", "norappurotro-5181@yopmail.com", 8276869, 3),
	(1302433, "maximo", "gutierrez", "fudeulaquitri-5708@hotmail.com", 864224, 1),
	(1633498, "mauricio", "alvarez", "quippautipose-1927@yopmail.com", 9347782, 1),
	(5735888, "rosalba", "carrasco", "queicruguffeixei-2231@gmail.com", 5021590, 6),
	(3928433, "bonifacio", "ramirez", "doigefroinoubo-3513@yopmail.com", 9363433, 6),
	(5063767, "ignacio", "cortes", "faummuseppaffe-9022@gmail.com", 7129424, 6),
	(4604805, "lorenzo", "rivera", "jautrumehuquei-7299@gmail.com", 5145121, 1),
	(1317253, "virginia", "petro", "foulufugraujei-9264@yopmail.com", 583815, 1);
    
INSERT INTO sedes (nombre, ciudad, direccion1, telefono)
VALUES
	("gabriel garcia marquez", "santa marta", "calle 14#1c-37", 4210251),
    ("centro cultural de tunja", "tunja", "calle 20 #8-66", 7422311),
    ("centro cultural de manizales", "manizales", "carrera 23 #23-06", 8858515),
    ("centro cultural de neiva", "neiva", "carrera 5 #5-67", 8711348),
    ("casa gomez campuzano", "bogota", "calle 80 #8-66", 2100816),
    ("centro cultural de florencia", "florencia", "carrera 11 #14-70", 4354088),
    ("centro cultural de medellin", "medellin", "calle 50 #50-21", 5767412),
    ("luis angel arango", "bogota", "calle 11 #4-14", 3431212),
    ("centro cultural de valledupar", "valledupar", "carrera 9 #16-13", 5744052),
    ("centro cultural de leticia", "leticia", "carrera 11 #9-43", 5927213);
    
INSERT INTO empleados (documento, nombre, apellido, correo_oficial, correo_personal, cargo, id_sede)
VALUES
	("1867143", "diosdado", "sanchez", "dsandoch@banrep.gov.co", "dddsanch@gmail.com", "bibliotecario", 10),
    ("1073175", "justa", "patino", "juscatpa@banrep.gov.co", "justa.patino@gmail.com", "bibliotecario", 9),
    ("5967524", "rigoberto", "andrade", "banrepculturalmaniza@banrep.gov.co", "randrad03@hotmail.com", "director", 1),
    ("2290265", "nairo", "quintana", "banrepculturalneiva@banrep.gov.co", "nairo0303@yahoo.es", "director", 2),
    ("4115642", "ricardo", "jimenez", "rjimenur@banrep.gov.co", "ricardo.jimenez@hotmail.com", "bibliotecario", 8),
    ("4915676", "margarita", "vargaS", "mvargapo@banrep.gov.co", "margaravarg@gmail.com", "bibliotecario", 7),
    ("6302644", "daniela", "abello", "abelloda@banrep.gov.co", "danielaabello1@gmail.com", "director", 3),
    ("7399043", "mirando", "nogales", "nospinmi@banrep.gov.co", "mirando_2@yahoo.es", "bibliotecario", 6),
    ("6402830", "carlos", "gomez", "museodelorocalima@banrep.gov.co", "nospinogal@hotmail.com", "director", 4),
    ("3189852", "kaiser", "castiro", "kcastiro@banrep.gov.co", "kaiser@yahoo.es", "bibliotecario", 5),
    ("8374723", "yurany", "rios", "yriospal@banrep.gov.co", "rios-yury@hotmail.com", "bibliotecario", 4),
    ("6246771", "misandro", "garcia", "mgarcide@banrep.gov.co", "misgarcia@gmail.com", "bibliotecario", 3),
    ("1170473", "carlos", "restrepo", "cferrees@banrep.gov.co", "carlos.restrepo.d@gmail.com", "director", 5),
    ("9278704", "elder", "petro", "banrepculturalmonteria@banrep.gov.co", "elderppp@hotmail.com", "director", 6),
    ("3211445", "francia", "palacio", "fpalacva@banrep.gov.co", "fpv2@gmail.com", "director", 7),
    ("7975689", "ancia", "sierra", "ac-s-areacultural@banrep.gov.co", "anciasierra32@hotmail.com", "director", 8),
    ("3121167", "asteca", "miraflorez", "asteelmi@banrep.gov.co", "asteca.azteca@gmail.com", "bibliotecario", 2),
    ("8963314", "andrea", "osorio", "aosorivi@banrep.gov.co", "andrea_osorio@gmail.com", "bibliotecario", 1),
    ("1268166", "arnulfo", "garcia", "agarcior@banrep.gov.co", "arnulfo@upb.edu.co", "director", 9),
    ("2322812", "juanarto", "carrique", "jcarriqu@banrep.gov.co", "carriquedim123@yahoo.es", "director", 10);

INSERT INTO estado (estado, disponibilidad)
VALUES
	("catalogado", 1),
    ("apartado", 0),
    ("enviado", 0),
    ("recibido", 0),
    ("prestado", 0),
    ("mantenimiento", 0);
    
INSERT INTO catalogo_libros (titulo, autor, total_ejemplares, id_sede, id_estado)
VALUES
	("Cómo ganar e influir sobre las personas", "Dale Carnegie", 1, 8, 1),
    ("Fangirl", "Rainbow Rowell", 13, 5, 2),
    ("Curso de lingüística general", "Ferdinand de Saussure", 1, 6, 1),
    ("Eero Saarinen 1910-1961", "Pierluigi Serraino", 1, 6, 5),
    ("Prescripción y procesos de pertenencia", "Edgar Guillermo Escobar", 16, 9, 1),
    ("El arte dramático aplicado a la educación", "Patrice Baldwin", 20, 10, 3),
    ("La sociedad del desprecio", "Axl Honneth", 1, 10, 1),
    ("Sueña", "Lisa McMann", 1, 9, 1),
    ("The talented Mr. Ripley", "Patricia Highsmith", 1, 8, 3),
    ("El universo de la ciencia ficción", "Kingsley Amis", 1, 7, 1),
    ("Jorn Utzon obras y proyectos", "Jaime J. Ferrer", 1, 7, 4),
    ("inquietud teórica y estrategia proyectual : en la obra de ocho arquitectos contemporáneos", "Rafael Moneo", 2, 5, 1),
    ("Vértigo", "W. G. Sebald", 1, 8, 5),
    ("Mask of medusa : works 1947-1983", "John Hejduk", 1, 7, 1),
    ("Louis I. Kahn : in the realm of architecture", "David B. Brownlee", 3, 4, 3),
    ("Las tres ecologías", "Félix Guattari", 2, 4, 2),
    ("La música y la puesta en escena : la obra de arte viviente", "Adolphe Appia", 1, 8, 1),
    ("La caída del angelus novus : ensayos para una nueva teoría social y una nueva práctica política", "Boaventura de Sousa Santos", 3, 8, 1),
    ("It", "Stephen King", 1, 4, 5),
    ("Introducción a la metodología de la investigación", "Adriana Fassio", 1, 3, 1),
    ("desarrollo y gestión de la colección local en la biblioteca pública", "Francisco Javier García Gómez", 4, 5, 1),
    ("Manual básico de técnica cinematográfica y dirección de fotografía", "José Martínez Abadía", 1, 5, 1),
    ("Combates por la historia", "Lucien Febvre", 3, 5, 5),
    ("El poder de la risa", "Andrés Castillo", 1, 3, 5),
    ("Integrating genomic features for non-invasive early lung cancer detection", "Jacob J. Chabon", 1, 2, 1),
    ("Esto si da risa ó la gallina ciega", "José Ayarza", 1, 1, 6),
    ("35 dias en China : el despertar del Dragón", "Eugenio Madueño", 2, 7, 1),
    ("101 cuentos clásicos de la India : la tradición de un legado espiritual", "Ramiro Calle", 5, 7, 5),
    ("100 años de Kafka : las metamorfosis del retrato", "Pedro Gómez", 3, 7, 1),
    ("10 mujeres de pasíon", "Hosanna Abela Alonso", 1, 2, 1),
    ("Producción legislativa y representaciones políticas de la élite parlamentaria brasileña", "Débora Messenberg", 1, 1, 3),
    ("Energy and society : the relation between energy, social change, and economic development", "Fred Cottrell", 2, 1, 6);

INSERT INTO reservas (id_registro, id_usuario, fecha_reserva, fecha_devolucion)
VALUES
	(4, 20, "2003-11-27 04:41:52", "2003-12-10 04:41:52"),
    (6, 5, "2019-07-18 02:14:46", "2019-07-31 02:14:46"),
    (9, 10, "2013-10-03 08:15:06", "2013-10-18 08:15:06"),
    (11, 14, "2021-10-20 21:23:08", "2021-11-05 21:23:08"),
    (13, 2, "2007-10-04 22:57:55", "2007-10-19 22:57:55"),
    (15, 22, "2018-11-16 18:15:11", "2018-11-30 18:15:11"),
    (19, 12, "2011-01-22 15:30:42", "2011-02-06 15:30:42"),
    (23, 13, "2013-07-15 06:53:16", "2013-07-30 06:53:16"),
    (24, 18, "2005-01-18 10:27:13", "2005-01-31 10:27:13"),
    (28, 25, "2001-03-01 07:40:26", "2001-03-16 07:40:26"),
    (31, 19, "2007-10-30 17:17:02", "2007-11-14 17:17:02");

INSERT INTO envios (id_reserva, id_usuario, guia_envio)
VALUES
	(2, 5, "94971485AB"),
    (3, 10, "22FG82644124"),
    (4, 14, "8968TY34905"),
    (6, 22, "81567631JKL7"),
    (11, 19, "SVT92514013916");

INSERT INTO mora_entregas (id_usuario, id_reserva, fecha_entrega, valor)
VALUES
	(20, 1, "2003-12-12 04:41:52", 5000),
    (2, 5, "2007-10-25 22:57:55", 15000);



/* Triggers */ 
	-- Creacion de triggers para las tablas de auditoria cuando se modifique la base de datos 
    
USE bibliotecas;

-- Triggers para la tabla de auditoria del catalogo (au_nuevos_libros)
	-- Se actualiza al agregar o eliminar libros del catalogo
CREATE TRIGGER tr_agregar_nuevo_libro
AFTER INSERT ON catalogo_libros
FOR EACH ROW
INSERT INTO au_nuevos_libros (id_registro, titulo, autor, fecha, usuario, accion)
VALUES (NEW.id_registro, NEW.titulo, NEW.autor, CURDATE(), SESSION_USER(), "agregado");

CREATE TRIGGER tr_retirar_libros
BEFORE DELETE ON catalogo_libros
FOR EACH ROW
INSERT INTO au_nuevos_libros (id_registro, titulo, autor, fecha, usuario, accion)
VALUES (OLD.id_registro, OLD.titulo, OLD.autor, CURDATE(), SESSION_USER(), "retirado");


-- Triggers para la tabla de auditoria de sedes (au_sedes)
	-- Se actualiza si hay nuevas sedes o si la informacion de alguna se actualiza/modifica
CREATE TRIGGER tr_nuevas_sedes
BEFORE INSERT ON sedes
FOR EACH ROW
INSERT INTO au_sedes (id_sede, nombre, ciudad, telefono, fecha, usuario, accion)
VALUES (NEW.id_sede, NEW.nombre, NEW.ciudad, NEW.telefono, CURDATE(), SESSION_USER(), "nueva");

CREATE TRIGGER tr_cambio_sedes
AFTER UPDATE ON sedes
FOR EACH ROW
INSERT INTO au_sedes (id_sede, nombre, ciudad, telefono, fecha, usuario, accion)
VALUES (OLD.id_sede, OLD.nombre, OLD.ciudad, OLD.telefono, CURDATE(), SESSION_USER(), "modificada");
