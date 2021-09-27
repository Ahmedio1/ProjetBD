DROP SCHEMA IF EXISTS compilation CASCADE;

CREATE SCHEMA compilation;

SET search_path to compilation;

DROP TABLE IF EXISTS CHANTEUR;
CREATE TABLE CHANTEUR(
id_chanteur INT,
nom VARCHAR(150),
prenom VARCHAR(150),
age INT,
ville_naissance VARCHAR(200);

DROP TABLE IF EXISTS MUSIQUE;
CREATE TABLE MUSIQUE(
    id_musique INT,
    nom VARCHAR(200),
    nom_album VARCHAR(200),
    genre VARCHAR(150),
    date_sortie DATE,
);

DROP TABLE IF EXISTS CHANTE;
CREATE TABLE CHANTE(
    id_chanteur INT,
    id_musique INT,
    duree TIME,
);

CREATE VIEW v1 AS(
    SELECT genre, COUNT(id_musique) AS "nb_musiques", COUNT(id_chanteur) AS "nb_chanteur"
    FROM Musique NATURAL JOIN CHANTE
    GROUP BY genre
    ORDER BY genre ASC
);