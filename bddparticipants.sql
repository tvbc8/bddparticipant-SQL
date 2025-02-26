DROP DATABASE IF EXISTS bddparticipants;
CREATE DATABASE bddparticipants;
USE bddparticipants;

CREATE TABLE civilite (
    id_civilite INT NOT NULL AUTO_INCREMENT,
    libelle_long VARCHAR(250) NOT NULL,
    libelle_court VARCHAR(10) DEFAULT NULL,
    CONSTRAINT PK_civilite PRIMARY KEY (id_civilite)
	)ENGINE=InnoDB;

CREATE TABLE titre (
    id_titre INT NOT NULL AUTO_INCREMENT,
    libelle VARCHAR(50) NOT NULL,
    niveau VARCHAR(50) DEFAULT NULL,
    CONSTRAINT PK_titre PRIMARY KEY (id_titre)
	)ENGINE=InnoDB;

CREATE TABLE fonction (
    id_fonction INT NOT NULL AUTO_INCREMENT,
    libelle VARCHAR(50) NOT NULL,
    CONSTRAINT PK_fonction PRIMARY KEY (id_fonction)
	)ENGINE=InnoDB;

CREATE TABLE pays (
    id_pays INT NOT NULL AUTO_INCREMENT,
    code VARCHAR(5) NOT NULL,
    nom VARCHAR(150) NOT NULL,
    CONSTRAINT PK_pays PRIMARY KEY (id_pays)
	)ENGINE=InnoDB;

CREATE TABLE societe (
    siret VARCHAR(20) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    CONSTRAINT PK_societe PRIMARY KEY (siret)
	)ENGINE=InnoDB;

CREATE TABLE email (
    id_email INT NOT NULL AUTO_INCREMENT,
    adresse VARCHAR(10) NOT NULL,
    CONSTRAINT PK_email PRIMARY KEY (id_email)
	)ENGINE=InnoDB;

CREATE TABLE categorie (
    id_categorie INT NOT NULL AUTO_INCREMENT,
    libelle VARCHAR(50) NOT NULL,
    CONSTRAINT PK_categorie PRIMARY KEY (id_categorie)
	)ENGINE=InnoDB;

CREATE TABLE cp_ville (
    id_cpville INT NOT NULL AUTO_INCREMENT,
    code_postal CHAR(5) NOT NULL,
    ville VARCHAR(150) NOT NULL,
    id_pays INT NOT NULL,
    CONSTRAINT PK_cp_ville PRIMARY KEY (id_cpville),
    CONSTRAINT FK_cp_ville_PAYS FOREIGN KEY (id_pays) REFERENCES pays(id_pays)
	)ENGINE=InnoDB;

CREATE TABLE participant (
    id_participant INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    adresse1 VARCHAR(250) NOT NULL,
    adresse2 VARCHAR(250) DEFAULT NULL,
    id_cpville INT NOT NULL,
    id_civilite INT NOT NULL,
    id_email INT NOT NULL,
    CONSTRAINT PK_participant PRIMARY KEY (id_participant),
    CONSTRAINT FK_participant_CPVILLE FOREIGN KEY (id_cpville) REFERENCES cp_ville(id_cpville),
    CONSTRAINT FK_participant_CIVILITE FOREIGN KEY (id_civilite) REFERENCES civilite(id_civilite),
    CONSTRAINT FK_participant_EMAIL FOREIGN KEY (id_email) REFERENCES email(id_email)
	)ENGINE=InnoDB;

CREATE TABLE formation (
    id_formation INT NOT NULL AUTO_INCREMENT,
    libelle VARCHAR(200) NOT NULL,
    CONSTRAINT PK_formation PRIMARY KEY (id_formation)
	)ENGINE=InnoDB;

CREATE TABLE preparer (
    id_titre INT NOT NULL,
    id_formation INT NOT NULL,
    CONSTRAINT FK_preparer_TITRE FOREIGN KEY (id_titre) REFERENCES titre(id_titre),
    CONSTRAINT FK_preparer_FORMATION FOREIGN KEY (id_formation) REFERENCES formation(id_formation)
	)ENGINE=InnoDB;

CREATE TABLE module (
    id_module INT NOT NULL AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    libelle VARCHAR(250) NOT NULL,
    description TEXT NOT NULL,
    id_categorie INT NOT NULL,
    CONSTRAINT PK_module PRIMARY KEY (id_module),
    CONSTRAINT FK_module_CATEGORIE FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
	)ENGINE=InnoDB;

CREATE TABLE suivre (
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    date_obtention DATE NOT NULL,
    id_formation INT NOT NULL,
    id_participant INT NOT NULL,
    CONSTRAINT FK_suivre_FORMATION FOREIGN KEY (id_formation) REFERENCES formation(id_formation),
    CONSTRAINT FK_suivre_PARTICIPANT FOREIGN KEY (id_participant) REFERENCES participant(id_participant)
	)ENGINE=InnoDB;

CREATE TABLE attribuer (
    note FLOAT(5,2) NOT NULL,
    date DATE NOT NULL,
    id_participant INT NOT NULL,
    id_module INT NOT NULL,
    CONSTRAINT PK_attribuer PRIMARY KEY (id_participant, id_module),
    CONSTRAINT FK_attribuer_MODULE FOREIGN KEY (id_module) REFERENCES module(id_module),
    CONSTRAINT FK_attribuer_PARTICIPANT FOREIGN KEY (id_participant) REFERENCES participant(id_participant)
	)ENGINE=InnoDB;

CREATE TABLE travailler (
    date_debutcontrat DATE DEFAULT NULL,
    date_fincontrat DATE DEFAULT NULL,
    id_participant INT NOT NULL,
    siret VARCHAR(20) NOT NULL,
    id_fonction INT NOT NULL,
    CONSTRAINT PK_travailler PRIMARY KEY (id_participant, siret, id_fonction),
    CONSTRAINT FK_travailler_SOCIETE FOREIGN KEY (siret) REFERENCES societe(siret),
    CONSTRAINT FK_travailler_FONCTION FOREIGN KEY (id_fonction) REFERENCES fonction(id_fonction),
    CONSTRAINT FK_travailler_PARTICIPANT FOREIGN KEY (id_participant) REFERENCES participant(id_participant)
	)ENGINE=InnoDB;

CREATE TABLE correspondre (
    coefficient INT NOT NULL,
    id_formation INT NOT NULL,
    id_module INT NOT NULL,
    CONSTRAINT PK_correspondre PRIMARY KEY (id_formation, id_module),
    CONSTRAINT FK_correspondre_FORMATION FOREIGN KEY (id_formation) REFERENCES formation(id_formation),
    CONSTRAINT FK_correspondre_MODULE FOREIGN KEY (id_module) REFERENCES module(id_module)
	)ENGINE=InnoDB;

CREATE TABLE estmere (
    id_categorie_fille INT NOT NULL,
    id_categorie_mere INT NOT NULL,
    CONSTRAINT FK_categorie_FILLE FOREIGN KEY (id_categorie_fille) REFERENCES categorie(id_categorie),
    CONSTRAINT FK_categorie_MERE FOREIGN KEY (id_categorie_mere) REFERENCES categorie(id_categorie)
	)ENGINE=InnoDB;