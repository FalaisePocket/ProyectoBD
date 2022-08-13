-- Database: mande_db

-- DROP DATABASE mande_db;

CREATE DATABASE mande_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE template0;

\c mande_db


CREATE TABLE ubicacion (
    id_ubicacion SERIAL NOT NULL PRIMARY KEY,
    direccion character varying(60) NOT NULL
);


CREATE TABLE ocupacion (
    id_ocupacion SERIAL NOT NULL PRIMARY KEY,
    nom_ocupacion character varying(40) NOT NULL,
    descripcion text NOT NULL
);


CREATE TABLE ocupacion_trabajador (
    id_ocupacion_trabajador SERIAL NOT NULL PRIMARY KEY,
    id_trabajador integer NOT NULL,
    id_ocupacion integer NOT NULL,
    valor_ocupacion integer NOT NULL,
    FOREIGN KEY (id_trabajador) REFERENCES trabajador(id_trabajador),
    FOREIGN KEY (id_ocupacion) REFERENCES ocupacion(id_ocupacion)
);


CREATE TABLE persona (
    id_persona SERIAL NOT NULL PRIMARY KEY,
    ubicacion integer NOT NULL,
    medio_de_pago character varying(20) NOT NULL,
    contrasena character varying(20) NOT NULL,
    telefono integer NOT NULL,
    FOREIGN KEY (ubicacion) REFERENCES ubicacion(id_ubicacion)
);


CREATE TABLE solicitud (
    id_solicitud SERIAL NOT NULL PRIMARY KEY,
    id_usuario integer NOT NULL,
    id_ocupacion_trabajador integer NOT NULL,
    fecha date NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_ocupacion_trabajador) REFERENCES ocupacion_trabajador(id_ocupacion_trabajador)
);


CREATE TABLE trabajador (
    id_trabajador SERIAL NOT NULL PRIMARY KEY,
    id_persona integer NOT NULL,
    calificacion numeric NOT NULL,
    disponible boolean NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);


CREATE TABLE transaccion (
    id_transaccion SERIAL NOT NULL PRIMARY KEY,
    id_solicitud integer NOT NULL,
    calificacion integer NOT NULL,
    FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud)
);


CREATE TABLE usuario (
    id_usuario SERIAL NOT NULL PRIMARY KEY,
    id_persona integer NOT NULL,
    conf_direccion boolean NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);