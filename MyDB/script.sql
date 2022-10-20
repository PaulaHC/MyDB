
/*----------------------------------------------------------------
DROP DE TABLAS
*/

drop table IF EXISTS USUARIOREGISTRADO ;
drop table IF EXISTS BASEDEDATOS;

/*----------------------------------------------------------------
DEFINICIÓN DE TABLAS
*/

create table USUARIOREGISTRADO(

         /*---------------------------------------------------------------- 
        atributos propios de usuarioRegistrado
        */

        EMAIL varchar(100),

        NOMBRE varchar(50) NOT NULL ,
        APELLIDO varchar(50) NOT NULL ,
        PASSWORD varchar(50) NOT NULL ,

        PRIMARY KEY (EMAIL)

);

create table BASEDEDATOS(

         /*---------------------------------------------------------------- 
        atributos propios de baseDeDatos
        */

         /*
        Clave foranea hacia usuarioRegistrado
        */

        EMAILUSUARIO varchar(100) ,

        NOMBRE varchar(50) NOT NULL ,
        FECHACREACION date NOT NULL ,

        FECHAMODIFICACION date ,
        FICHERO blob,
        
       
        PRIMARY KEY (NOMBRE,FECHACREACION),

        FOREIGN KEY(EMAILUSUARIO) REFERENCES USUARIOREGISTRADO (EMAIL)

/* COMPROBACIONES FECHAS

        CONSTRAINT fecha_creacion__correcta
        CHECK (fecha_creacion <= NOW()),
        
        CONSTRAINT fecha_modificacion__correcta
        CHECK (
            CASE WHEN fecha_modificacion IS NOT NULL
                THEN
                    fecha_modificacion <= NOW() AND fecha_creacion <> fecha_modificacion AND 
                    fecha_creacion < fecha_modificacion   
                END
        )*/
);


/* Poblacion de las tablas */

/*F
Insercion de usuarioRegistrado
*/

INSERT INTO USUARIOREGISTRADO VALUES ('prueba1@gmail.com','David','Fernandez','1234');
INSERT INTO USUARIOREGISTRADO VALUES ('prueba2@gmail.com','Pedro','Perez','abcd');
INSERT INTO USUARIOREGISTRADO VALUES ('prueba3@gmail.com','Daniel','Hernandez','1234');
INSERT INTO USUARIOREGISTRADO VALUES ('prueba4@gmail.com','Pablo','Martin','abcd');
INSERT INTO USUARIOREGISTRADO VALUES ('prueba5@gmail.com','Clara','Mateo','1234');
INSERT INTO USUARIOREGISTRADO VALUES ('prueba6@gmail.com','Paula','Alonso','abcd');

/*
Insercion de baseDeDatos
*/

INSERT INTO BASEDEDATOS VALUES ('prueba1@gmail.com','Aviones','2021-10-05',NULL, LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));
INSERT INTO BASEDEDATOS VALUES ('prueba1@gmail.com','Barcos','2019-10-05','2020-04-02',LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));
INSERT INTO BASEDEDATOS VALUES ('prueba2@gmail.com','Asignaturas','2021-11-15',NULL,LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));
INSERT INTO BASEDEDATOS VALUES ('prueba2@gmail.com','Clases','2012-01-05','2018-12-12',LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));
INSERT INTO BASEDEDATOS VALUES ('prueba6@gmail.com','Equipos','2011-03-05',NULL,LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));
INSERT INTO BASEDEDATOS VALUES ('prueba6@gmail.com','Jugadores','2012-10-05','2021-04-02',LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\script.sql'));

