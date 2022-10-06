/* Estructura bibliotecas */
	-- Creacion de la base de datos y creacion de las tablas 
	-- Se crea la base, se utiliza y se agregan las tablas con las que se trabajara
CREATE DATABASE IF NOT EXISTS bibliotecas;

USE bibliotecas;

CREATE TABLE IF NOT EXISTS categorias (
		id_categoria INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        categoria VARCHAR(20) NOT NULL,
        prestamos_necesarios INT,
        moras_permitidas INT
);

CREATE TABLE IF NOT EXISTS usuarios_registrados (
		id_usuario INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        documento VARCHAR(15),
        nombre VARCHAR(30) NOT NULL,
        apellido VARCHAR(30),
        correo VARCHAR(50),
        telefono INT NOT NULL,
        id_categoria INT NOT NULL,
        FOREIGN KEY (id_categoria)
			REFERENCES categorias (id_categoria)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS sedes (
		id_sede INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(30) NOT NULL,
        ciudad VARCHAR(15) NOT NULL,
        direccion1 VARCHAR(50) NOT NULL,
        direccion2 VARCHAR(50),
        telefono INT
);

CREATE TABLE IF NOT EXISTS empleados (
		id_empleado INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        documento VARCHAR(15) NOT NULL,
        nombre VARCHAR(30) NOT NULL,
        apellido VARCHAR(30) NOT NULL,
        correo_oficial VARCHAR(50),
        correo_personal VARCHAR(50) NOT NULL,
        cargo VARCHAR(20) NOT NULL,
        id_sede INT NOT NULL,
        FOREIGN KEY (id_sede)
			REFERENCES sedes (id_sede)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS estado (
		id_estado INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        estado VARCHAR(30) NOT NULL,
        disponibilidad BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS catalogo_libros (
	id_registro INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(30) NOT NULL,
    total_ejemplares INT NOT NULL,
    id_sede INT NOT NULL,
    id_estado INT NOT NULL,
    FOREIGN KEY (id_sede)
		REFERENCES sedes (id_sede)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_estado)
		REFERENCES estado (id_estado)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS reservas (
		id_reserva INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
        id_registro INT NOT NULL,
        id_usuario INT NOT NULL,
        fecha_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        fecha_devolucion DATETIME NOT NULL,
        FOREIGN KEY (id_registro)
			REFERENCES catalogo_libros (id_registro)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
		FOREIGN KEY (id_usuario)
			REFERENCES usuarios_registrados (id_usuario)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS envios (
	id_envio INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_reserva INT NOT NULL,
    guia_envio VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_reserva)
		REFERENCES reservas (id_reserva)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_usuario)
		REFERENCES usuarios_registrados (id_usuario)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mora_entregas (
	id_mora INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_reserva INT NOT NULL,
    fecha_entrega DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	valor INT NOT NULL,
    FOREIGN KEY (id_reserva)
		REFERENCES reservas (id_reserva)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_usuario)
		REFERENCES usuarios_registrados (id_usuario)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);


/* Creación de vistas */
	-- Se crean las vistas para acceder a diferente informacion de referencia
-- (1) vista de libros con estado "catalogado", es decir, libros que están disponibles
CREATE OR REPLACE VIEW libros_disponibles
AS 
	SELECT * FROM catalogo_libros
    WHERE id_estado = 1;

-- (2) vista del catalogo completo de libros con nombre de sede y estado
CREATE OR REPLACE VIEW catalogo_completo
AS
	SELECT cl.titulo, cl.autor, cl.total_ejemplares AS ejemplares, s.nombre, e.estado
    FROM catalogo_libros AS cl
    JOIN sedes AS s
    ON cl.id_sede = s.id_sede
    JOIN estado AS e
    ON cl.id_estado = e.id_estado;

-- (3) vista de libros enviados (en envio y recibidos en sucursal) a los que se hace seguimiento
CREATE OR REPLACE VIEW libros_enviados
AS
	SELECT cl.titulo AS libro, s.nombre AS sede, e.estado
    FROM catalogo_libros AS cl
    JOIN sedes AS s
    ON cl.id_sede = s.id_sede
    JOIN estado AS e
    ON cl.id_estado = e.id_estado
    WHERE cl.id_estado = 3 OR cl.id_estado = 4;

-- (4) vista de usuarios con moras y sus deudas
CREATE OR REPLACE VIEW usuarios_moras
AS
	SELECT ur.nombre, ur.apellido, ur.correo AS contacto, me.valor
    FROM mora_entregas AS me
    JOIN usuarios_registrados AS ur
    ON me.id_usuario = ur.id_usuario;

-- (5) vista de usuarios ordenados por categoria
CREATE OR REPLACE VIEW registro_usuarios
AS
	SELECT ur.documento, ur.nombre, ur.apellido, ur.correo, ur.telefono, cg.categoria
    FROM usuarios_registrados AS ur
    JOIN categorias AS cg
    ON ur.id_categoria = cg.id_categoria
    ORDER BY cg.categoria DESC;

-- (6) vista de empleados con sus sedes de empleo
CREATE OR REPLACE VIEW empleados_completo
AS
	SELECT em.documento, em.nombre, em.apellido, em.correo_oficial, em.cargo, s.nombre AS sede_laboral
    FROM empleados AS em
    JOIN sedes AS s
    ON em.id_sede = s.id_sede
    ORDER BY em.cargo DESC;


/* Funciones */
	-- Creacion de las funciones para uso constante de la base de datos
-- Funcion para traer el correo de contacto de los usuarios una vez creada una mora
	-- A patir de un id_mora se identifica el correo electronico de contacto
DELIMITER $$
CREATE FUNCTION contacto_moras (param_moraid INT) 
RETURNS CHAR(100)
READS SQL DATA
	BEGIN 
    DECLARE contacto VARCHAR(100);
    SELECT correo INTO contacto FROM usuarios_registrados WHERE id_usuario = param_moraid;
    RETURN contacto;
    END $$

-- Funcion para encontrar el valor total a cobrar por mora incluyendo el iva nacional del 19%
	-- A partir de un id_mora se identifica el valor total a pagar por el usuario
DELIMITER $$
CREATE FUNCTION valor_a_cobrar (param_moraid INT)
RETURNS INT
READS SQL DATA
	BEGIN
    DECLARE cobro_total INT;
    DECLARE iva DECIMAL(9,2);
    SET iva = 1.19;
    SET cobro_total = (SELECT valor FROM mora_entregas WHERE id_mora = param_moraid) * iva;
    RETURN cobro_total;
    END $$

-- Volvemos al delimitador de punto y coma
DELIMITER ;


/* Stored Procedures */
	-- Stored Procedure 1. Indica a traves de un campo el ordenamiento del catalogo de libros y el que dicho orden sea descendente
USE bibliotecas;

DELIMITER $$
CREATE PROCEDURE sp_orden_catalogo (IN campo CHAR(50))
BEGIN 
	IF campo <> " " THEN
		SET @orden_catalogo = CONCAT("ORDER BY ", campo);
	ELSE
		SET @orden_catalogo = " ";
	END IF;
    
    SET @ordenar = " DESC";
    
    SET @clausula_sql = CONCAT("SELECT * FROM bibliotecas.catalogo_libros ", @orden_catalogo, @ordenar);
    
    PREPARE consultasql FROM @clausula_sql;
    EXECUTE consultasql;
    DEALLOCATE PREPARE consultasql;
END $$

-- Stored Procedure 2. Inserta nuevas categorias o marca un error en caso de que haya un problema
USE bibliotecas;

DELIMITER $$
CREATE PROCEDURE sp_nueva_categoria (IN nombre CHAR(50))
BEGIN 
	IF nombre = "" THEN
		SET @insercion = 'SELECT "! No se puede crear la categoria indicada" AS Error';
	ELSE
		SET @insercion = CONCAT("INSERT INTO bibliotecas.categorias (categoria) VALUES ('", nombre, "')");
	END IF;
    
    PREPARE consultasql FROM @insercion;
    EXECUTE consultasql;
    DEALLOCATE PREPARE consultasql;
END $$

-- Volvemos al delimitador de punto y coma
DELIMITER ;


/* Triggers */
USE bibliotecas;

-- Se crean las tablas de auditoria para la definicion de triggers e inclusion de su informacion
	-- Las tablas se vinculan al catalogo y a las sedes
CREATE TABLE au_nuevos_libros (
	id_registro INT,
    titulo VARCHAR (200),
    autor VARCHAR (100),
    fecha DATE,
    usuario VARCHAR (100),
    accion VARCHAR (50)
);

CREATE TABLE au_sedes (
	id_sede INT,
    nombre VARCHAR (50),
    ciudad VARCHAR (50),
    telefono INT,
    fecha DATE,
    usuario VARCHAR (100),
    accion VARCHAR (50)
);

-- La creacion como tal de los triggers se encuentra en el script de la insercion de datos