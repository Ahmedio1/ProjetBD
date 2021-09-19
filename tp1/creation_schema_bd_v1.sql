DROP SCHEMA IF EXISTS compilation CASCADE;

CREATE SCHEMA compilation;

SET search_path to compilation;

CREATE TABLE CHANTEUR(
id_chanteur SERIAL PRIMARY KEY,
nom VARCHAR(150) NOT NULL ,
prenom VARCHAR(150) NOT NULL ,
age INT NULL ,
ville_naissance VARCHAR(200) DEFAULT NULL );

DROP TABLE IF EXISTS MUSIQUE;
CREATE TABLE MUSIQUE(
    id_musique SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    nom_album VARCHAR(200) DEFAULT NULL UNIQUE,
    genre VARCHAR(150),
    date_sortie DATE DEFAULT NULL
    CHECK(id_musique>=0)
    CHECK(LENGTH(nom)>0)
);

DROP TABLE IF EXISTS CHANTE;
CREATE TABLE CHANTE(
    id_chanteur SERIAL REFERENCES CHANTEUR(id_chanteur)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    id_musique SERIAL REFERENCES MUSIQUE(id_musique)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    PRIMARY KEY (id_chanteur,id_musique)
);

CREATE VIEW v1 AS(
    SELECT genre, COUNT(id_musique) AS "nb_musiques", COUNT(id_chanteur) AS "nb_compositeurs"
    FROM Musique NATURAL JOIN CHANTE
    GROUP BY genre
);