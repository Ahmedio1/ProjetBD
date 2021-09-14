DROP SCHEMA IF EXISTS compilation CASCADE;

CREATE SCHEMA compilation;

SET search_path to compilation;

CREATE TABLE COMPOSITEUR (
id_compositeur SERIAL PRIMARY KEY,
nom VARCHAR(150) NOT NULL ,
prenom VARCHAR(150) NOT NULL ,
age INT NOT NULL ,
ville_naissance VARCHAR(200) DEFAULT NULL );

DROP TABLE IF EXISTS MUSIQUE;
CREATE TABLE MUSIQUE(
    id_musique SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    nom_album VARCHAR(200) DEFAULT NULL,
    genre VARCHAR(150),
    date_sortie DATE DEFAULT NULL
    CHECK(id_musique>=0);
    CHECK(LENGTH(nom)>0);
);

DROP TABLE IF EXISTS COMPOSE;
CREATE TABLE COMPOSE(
    id_compositeur SERIAL REFERENCES COMPOSITEUR(id_compositeur)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    id_musique SERIAL REFERENCES MUSIQUE(id_musique)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    PRIMARY KEY (id_compositeur,id_musique);
    PRIMARY KEY (id_compositeur,id_musique);
)