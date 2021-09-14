DROP TABLE IF EXISTS Film;

CREATE TABLE Musique(
    id_musique, SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    nom_album VARCHAR(200) DEFAULT NULL,
    genre VARCHAR(150),
    date_sortie DATE DEFAULT NULL
    CHECK(id_musique>=0);
    CHECK(LENGTH(nom)>0);
);