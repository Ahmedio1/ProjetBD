-- Tests des différentes contraintes sur la BD Compilation
-- DAOUD Ahmed & BERCHE Cyril - 2021

-- Ordres SQL pour tester des contraintes d'intégrité sur la table Chanteur

\echo '\n*** Test Chanteur 1 - Contrainte NOT NULL sur id_chanteur de Chanteur ***\n'
INSERT INTO Chanteur VALUES (null, 'Nom', 'Prénom', null, null);
\echo '\n*** Test Chanteur 1 - Contrainte UNIQUE sur id_chanteur de Chanteur ***\n'
INSERT INTO Chanteur VALUES (null, 'Nom', 'Prénom', null, null);
\echo '\n*** Test Chanteur 3 - Contrainte NOT NULL sur nom de Chanteur ***\n'
INSERT INTO Chanteur VALUES (1, null, 'Prénom', null, null);
\echo '\n*** Test Chanteur 4 - Contrainte NOT NULL sur prénom de Chanteur ***\n'
INSERT INTO Chanteur VALUES (1, 'Nom',null, null, null);
\echo '\n*** Test Chanteur 5 - Contrainte age>0 sur age de Chanteur ***\n'
INSERT INTO Chanteur VALUES (1, 'Nom','Prénom', 0, null);
\echo '\n*** Test Chanteur 6 - Contrainte id_chanteur>=0 de Chanteur ***\n'
INSERT INTO Chanteur VALUES (-1, 'Nom','Prénom', null, null);

-- Ordres SQL pour tester des contraintes d'intégrité sur la table Musique

\echo '\n*** Test Musique 1 - Contrainte UNIQUE sur id_musique de Musique ***\n'
INSERT INTO Musique VALUES (null, 'nomMusique', 'nomAlbum', 'genre', '01/01/0101');
\echo '\n*** Test Musique 2 - Contrainte NOT NULL sur id_musique de Musique ***\n'
INSERT INTO Musique VALUES (null, 'nomMusique', 'nomAlbum', 'genre', '01/01/0101');
\echo '\n*** Test Musique 3 - Contrainte NOT NULL sur nom de Musique ***\n'
INSERT INTO Musique VALUES (1, null, 'nomAlbum', 'genre', '01/01/0101');
\echo '\n*** Test Musique 4 - Contrainte nom>0 sur nom de Musique ***\n'
INSERT INTO Musique VALUES (1, '', 'nomAlbum', 'genre', '01/01/0101');
\echo '\n*** Test Musique 5 - Contrainte UNIQUE sur (nom,nom_album) de Musique ***\n'
INSERT INTO Musique VALUES (1, null, null, 'genre', '01/01/0101');
\echo '\n*** Test Musique 6 - Contrainte id_musique>=0 de Musique ***\n'
INSERT INTO Musique VALUES (-1, 'nomMusique', 'nomAlbum', 'genre', '01/01/0101');
\echo '\n*** Test Musique 7 - Contrainte date <= CURRENT_DATE de Musique ***\n'
INSERT INTO Musique VALUES (1, 'nomMusique', 'nomAlbum', 'genre', '01/01/2222');

-- Ordres SQL pour tester des contraintes d'intégrité sur la table Chante

\echo '\n*** Test Chante 1 - Contrainte UNIQUE sur (id_chanteur,id_musique) de Chante ***\n'
INSERT INTO Chante VALUES (null, null, '00:00:01');
\echo '\n*** Test Chante 2 - Contrainte NOT NULL sur id_chanteur de Chante ***\n'
INSERT INTO Chante VALUES (null, 1, '00:00:01');
\echo '\n*** Test Chante 3 - Contrainte NOT NULL sur id_musique de Chante ***\n'
INSERT INTO Chante VALUES (1, null, '00:00:01');
\echo '\n*** Test Chante 5 - Contrainte duree>0.0 sur duree de Chante ***\n'
INSERT INTO Chante VALUES (1, 1, '00:00:00');
\echo '\n*** Test Chante 6 - Contrainte id_chanteur de Chanteur référence id_chanteur de Chante ***\n'
INSERT INTO Chante VALUES (-1, 1, '00:00:01');
\echo '\n*** Test Chante 7 - Contrainte id_musique de Musique référence id_musique de Chante ***\n'
INSERT INTO Chante VALUES (1, -1, '00:00:01');




