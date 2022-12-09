DROP DATABASE IF EXISTS transport;

CREATE DATABASE IF NOT EXISTS transport
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
;

USE transport;

CREATE TABLE train(
   id_train INT AUTO_INCREMENT,
   nb_place VARCHAR(50) ,
   PRIMARY KEY(id_train)
);

CREATE TABLE ligne(
   id_ligne INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   PRIMARY KEY(id_ligne)
);

CREATE TABLE gare(
   id_gare INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   PRIMARY KEY(id_gare)
);

CREATE TABLE horaire_depart(
   id_horaire INT AUTO_INCREMENT,
   id_ligne INT NOT NULL,
   PRIMARY KEY(id_horaire),
   FOREIGN KEY(id_ligne) REFERENCES ligne(id_ligne)
);

CREATE TABLE _jour_(
   jour DATE,
   PRIMARY KEY(jour)
);

CREATE TABLE trajet(
   jour DATE,
   id_horaire INT,
   id_train INT NOT NULL,
   PRIMARY KEY(jour, id_horaire),
   FOREIGN KEY(jour) REFERENCES _jour_(jour),
   FOREIGN KEY(id_horaire) REFERENCES horaire_depart(id_horaire),
   FOREIGN KEY(id_train) REFERENCES train(id_train)
);

CREATE TABLE personne(
   id_personne INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   prenom VARCHAR(50) ,
   mail VARCHAR(50) ,
   PRIMARY KEY(id_personne)
);

CREATE TABLE client(
   id_personne INT,
   PRIMARY KEY(id_personne),
   FOREIGN KEY(id_personne) REFERENCES personne(id_personne)
);

CREATE TABLE planificateur(
   id_personne INT,
   PRIMARY KEY(id_personne),
   FOREIGN KEY(id_personne) REFERENCES personne(id_personne)
);

CREATE TABLE commande(
   id_commande INT AUTO_INCREMENT,
   id_personne INT NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(id_personne) REFERENCES client(id_personne)
);

CREATE TABLE billet(
   jour DATE,
   id_horaire INT,
   gare_depart INT,
   gare_arrivee INT,
   id_commande INT,
   id_billet INT,
   no_place TINYINT,
   no_voiture TINYINT,
   PRIMARY KEY(jour, id_horaire, gare_depart, gare_arrivee, id_commande, id_billet),
   FOREIGN KEY(jour, id_horaire) REFERENCES trajet(jour, id_horaire),
   FOREIGN KEY(gare_depart) REFERENCES gare(id_gare),
   FOREIGN KEY(gare_arrivee) REFERENCES gare(id_gare),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE dessert(
   id_ligne INT,
   id_gare INT,
   rang TINYINT NOT NULL,
   PRIMARY KEY(id_ligne, id_gare),
   FOREIGN KEY(id_ligne) REFERENCES ligne(id_ligne),
   FOREIGN KEY(id_gare) REFERENCES gare(id_gare)
);

CREATE TABLE horaire_gare(
   id_gare INT,
   id_horaire INT,
   heure DATETIME,
   PRIMARY KEY(id_gare, id_horaire),
   FOREIGN KEY(id_gare) REFERENCES gare(id_gare),
   FOREIGN KEY(id_horaire) REFERENCES horaire_depart(id_horaire)
);
