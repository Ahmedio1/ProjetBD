-- Création du schéma de la BD SPORTS21_BDA_v4
-- Jean-François Condotta - 2021

DROP SCHEMA IF EXISTS version4 CASCADE;
CREATE SCHEMA version4;
SET search_path TO version4;

CREATE TABLE SPORT (
	id_sport INT PRIMARY KEY,
	nom_sport VARCHAR(100) NOT NULL,
	categorie VARCHAR(100) NOT NULL,
	CHECK(LENGTH(nom_sport)>0),
	CHECK(LENGTH(categorie)>0),
	UNIQUE(nom_sport),
	CHECK(id_sport>=0)
);


-- Table comptabilisant le nombre de sports par catégorie
CREATE TABLE T_NB_SPORTS_PAR_CATEGORIE (
	categorie VARCHAR(100) PRIMARY KEY,
	nb_sports INT,
	CHECK (nb_sports>0)
);

-- Vue comptabilisant le nombre de sports par catégorie
CREATE VIEW V_NB_SPORTS_PAR_CATEGORIE AS
SELECT categorie,count(*) as "nb_sports"
FROM SPORT
GROUP BY categorie
ORDER BY categorie;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE OR REPLACE FUNCTION maj_t_nb_sports_par_categorie_ar_i() RETURNS trigger AS $$
	BEGIN
	UPDATE T_NB_SPORTS_PAR_CATEGORIE
	SET nb_sports = nb_sports + 1 
	WHERE categorie = NEW.categorie;
	IF NOT found THEN
		INSERT INTO T_NB_SPORTS_PAR_CATEGORIE VALUES(NEW.categorie, 1);
	END IF;
	RETURN NULL;
    END
$$ LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE TRIGGER trig_sport_ar_i AFTER INSERT ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE maj_t_nb_sports_par_categorie_ar_i();

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une suppression d'un tuple dans la table SPORT.
CREATE OR REPLACE FUNCTION maj_t_nb_sports_par_categorie_ar_d() RETURNS trigger AS $$
	DECLARE
	nb INT;
    BEGIN
	    SELECT nb_sports into nb
	    FROM t_nb_sports_par_categorie
	    WHERE categorie=old.categorie;
	    IF (nb=1) THEN
        DELETE FROM t_nb_sports_par_categorie
        WHERE categorie=old.categorie;
	    ELSE
        UPDATE T_NB_SPORTS_PAR_CATEGORIE
        SET nb_sports = nb_sports - 1
        WHERE categorie=old.categorie;
    end if;
    RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE TRIGGER trig_sport_ar_d AFTER DELETE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE maj_t_nb_sports_par_categorie_ar_d();
-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une maj d'un tuple dans la table SPORT.
CREATE OR REPLACE FUNCTION maj_t_nb_sports_par_categorie_ar_u() RETURNS trigger AS $$
	DECLARE
	nb INT;
    BEGIN
        UPDATE T_NB_SPORTS_PAR_CATEGORIE
	    SET nb_sports = nb_sports + 1
	    WHERE categorie = new.categorie;
	    IF NOT found THEN
	    INSERT INTO T_NB_SPORTS_PAR_CATEGORIE VALUES(NEW.categorie, 1);
	    END IF;
        SELECT nb_sports into nb
        FROM T_NB_SPORTS_PAR_CATEGORIE
        WHERE categorie=old.categorie;
	    IF (nb=1) THEN
        DELETE FROM t_nb_sports_par_categorie
        WHERE old.categorie=categorie;
	    ELSE
        UPDATE T_NB_SPORTS_PAR_CATEGORIE
        SET nb_sports = nb_sports - 1
        WHERE old.categorie=categorie;
        end if;
    RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE TRIGGER trig_sport_ar_u AFTER UPDATE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE maj_t_nb_sports_par_categorie_ar_u();
