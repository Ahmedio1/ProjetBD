DROP SCHEMA IF EXISTS compilation CASCADE;

CREATE SCHEMA compilation;

SET search_path to compilation;

DROP TABLE IF EXISTS CHANTEUR;
CREATE TABLE CHANTEUR(
id_chanteur INT PRIMARY KEY,
nom VARCHAR(150) NOT NULL ,
prenom VARCHAR(150) NOT NULL ,
age INT NULL ,
ville_naissance VARCHAR(200) DEFAULT NULL
CHECK (id_chanteur>0)
CHECK(age>0)
CHECK(LENGTH(ville_naissance)>0));

DROP TABLE IF EXISTS MUSIQUE;
CREATE TABLE MUSIQUE(
    id_musique INT PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    nom_album VARCHAR(200) DEFAULT NULL,
    genre VARCHAR(150),
    date_sortie DATE DEFAULT NULL,
    CHECK (id_musique>0),
    CHECK(LENGTH(nom)>0),
    UNIQUE(nom,nom_album)
);

DROP TABLE IF EXISTS CHANTE;
CREATE TABLE CHANTE(
    id_chanteur INT REFERENCES CHANTEUR(id_chanteur)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    id_musique INT REFERENCES MUSIQUE(id_musique)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
    duree TIME DEFAULT NULL,
    CHECK (duree>'00:00:00'),
    PRIMARY KEY (id_chanteur,id_musique)
);

CREATE VIEW v1 AS(
    SELECT genre, COUNT(id_musique) AS "nb_musiques", COUNT(id_chanteur) AS "nb_chanteur"
    FROM Musique NATURAL JOIN CHANTE
    GROUP BY genre
    ORDER BY genre ASC
);