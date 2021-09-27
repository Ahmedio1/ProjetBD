DROP SCHEMA IF EXISTS compilation CASCADE;

CREATE SCHEMA compilation;

SET search_path to compilation;

DROP TABLE IF EXISTS CHANTEUR;
CREATE TABLE CHANTEUR(
id_chanteur INT,
nom VARCHAR(150),
prenom VARCHAR(150),
age INT,
ville_naissance VARCHAR(200)
);

DROP TABLE IF EXISTS MUSIQUE;
CREATE TABLE MUSIQUE(
    id_musique INT,
    nom VARCHAR(200),
    nom_album VARCHAR(200),
    genre VARCHAR(150),
    date_sortie DATE
);

DROP TABLE IF EXISTS CHANTE;
CREATE TABLE CHANTE(
    id_chanteur INT,
    id_musique INT,
    duree TIME
);

CREATE VIEW v1 AS(
    SELECT genre, COUNT(id_musique) AS "nb_musiques", COUNT(id_chanteur) AS "nb_chanteur"
    FROM Musique NATURAL JOIN CHANTE
    GROUP BY genre
    ORDER BY genre ASC
);

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTEUR
-- Voir les tests : Test CHANTEUR 1 / Test CHANTEUR 3 / Test CHANTEUR 4 / Test CHANTEUR 5 / Test CHANTEUR 6 /Test CHANTEUR
CREATE OR REPLACE FUNCTION test_chanteur_br_iu() RETURNS trigger AS $$
    BEGIN
        IF NEW.id_chanteur IS NULL THEN
        RAISE EXCEPTION 'id_chanteur de CHANTEUR ne peut pas être NULL !';
        END IF;
        IF NEW.nom IS NULL THEN
        RAISE EXCEPTION 'nom de CHANTEUR ne peut être NULL !';
        END IF;
        IF NEW.prenom IS NULL THEN
        RAISE EXCEPTION 'prenom de CHANTEUR ne peut être NULL !';
        END IF;
        IF NEW.age<=0 THEN
        RAISE EXCEPTION 'age de CHANTEUR ne peut être inférieur ou égale à 0 !';
        END IF;
        IF NEW.id_chanteur<0 THEN
        RAISE EXCEPTION 'id_chanteur ne peut être strictement inférieur à 0 !';
        END IF;
        IF length(NEW.ville_naissance)<=0 THEN
        RAISE EXCEPTION 'la ville de naissance doit être réferencé !';
        END IF;
        RETURN NEW;
    END
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTEUR
-- Voir les tests : Test CHANTEUR 1 / Test CHANTEUR 3 / Test CHANTEUR 4 / Test CHANTEUR 5 / Test CHANTEUR 6
CREATE TRIGGER trig_chanteur_br_iu BEFORE INSERT OR UPDATE ON CHANTEUR
    FOR EACH ROW EXECUTE PROCEDURE test_chanteur_br_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTEUR
-- Voir les tests : Test CHANTEUR 2
CREATE OR REPLACE FUNCTION test_chanteur_ar_iu() RETURNS trigger AS $$
    DECLARE
	nb INTEGER;
    BEGIN
        SELECT COUNT(*) INTO nb
        FROM CHANTEUR
        WHERE id_chanteur=NEW.id_chanteur;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de CHANTEUR ne peuvent pas avoir même valeur pour id_chanteur !';
        END IF;
        RETURN NEW;
    END
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTEUR
-- Voir les tests : Test CHANTEUR 2
CREATE TRIGGER trig_chanteur_ar_iu AFTER INSERT OR UPDATE ON CHANTEUR
    FOR EACH ROW EXECUTE PROCEDURE test_chanteur_ar_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTE
-- Voir les tests : Test CHANTE 2/Test CHANTE 3/Test CHANTE 4 / Test CHANTE 5 /Test CHANTE 6

CREATE OR REPLACE FUNCTION test_chante_br_iu() RETURNS trigger AS $$
    BEGIN
        IF NEW.duree <='00:00:00' THEN
        RAISE EXCEPTION 'la duree ne peut être inférieur ou égale a 00:00:00 !';
        END IF;
        IF NEW.id_chanteur IS NULL THEN
        RAISE EXCEPTION 'id_chanteur de CHANTE ne peut pas être NULL !';
        END IF;
        IF NEW.id_musique IS NULL THEN
        RAISE EXCEPTION 'id_musique de CHANTE ne peut pas être NULL !';
        END IF;
        IF NEW.id_chanteur<0 THEN
        RAISE EXCEPTION 'id_chanteur de CHANTE ne peut être inferieur à 0 !';
        END IF;
        IF NEW.id_musique<0 THEN
        RAISE EXCEPTION 'id_musique de CHANTE ne peut être inferieur à 0 !';
        END IF;
        RETURN NEW;
    END
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTE
-- Voir les tests : Test CHANTE 2/ Test CHANTE 3/Test CHANTE 4 / Test CHANTE 5 /Test CHANTE 6
CREATE TRIGGER trig_chante_br_iu AFTER INSERT OR UPDATE ON CHANTE
    FOR EACH ROW EXECUTE PROCEDURE test_chante_br_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTEUR
-- Voir les tests : Test CHANTE 1
CREATE OR REPLACE FUNCTION test_chante_ar_iu() RETURNS trigger AS $$
    DECLARE
	nb INTEGER;
    BEGIN
        SELECT COUNT(*) INTO nb
        FROM CHANTE
        WHERE id_chanteur=NEW.id_chanteur AND id_musique=NEW.id_musique;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de CHANTE ne peuvent pas avoir même valeur pour id_chanteur et id_musique !';
        END IF;
        RETURN NEW;
    END
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table CHANTE
-- Voir les tests : Test CHANTE 1
CREATE TRIGGER trig_chante_ar_iu AFTER INSERT OR UPDATE ON CHANTE
    FOR EACH ROW EXECUTE PROCEDURE test_chante_ar_iu();