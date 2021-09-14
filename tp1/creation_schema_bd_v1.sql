drop schema if exists cours CASCADE;

CREATE SCHEMA cours;

set search_path to cours;

CREATE TABLE PERSONNE (
id serial PRIMARY KEY,
nom varchar(150) not null,
prenom varchar(150) not null,
age int not null,
ville varchar(200) default null);

