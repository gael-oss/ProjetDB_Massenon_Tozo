CREATE DATABASE gestion_ferroviaire;
USE gestion_ferroviaire;

-- 1. Table Gare (aucune dépendance)
CREATE TABLE Gare (
    Code_Uic_gare DECIMAL(8,0) NOT NULL,
    nom_gare VARCHAR(40) NOT NULL,
    Ville_gare VARCHAR(30) NOT NULL,
    Nombre_de_voies_gare DECIMAL(2,0) NOT NULL,
    PRIMARY KEY (Code_Uic_gare)
) ENGINE=InnoDB;

-- 2. Table Rame (aucune dépendance)
CREATE TABLE Rame (
    Numéro_de_rame VARCHAR(6) NOT NULL,
    Modèle_de_rame VARCHAR(20) NOT NULL,
    Année_de_mise_en_service DECIMAL(4,0) NOT NULL,
    PRIMARY KEY (Numéro_de_rame)
) ENGINE=InnoDB;

-- 3. Table Voyageur (aucune dépendance)
CREATE TABLE Voyageur (
    Numéro_voyageur DECIMAL(8,2) NOT NULL,
    Nom_voyageur VARCHAR(50) NOT NULL,
    Prénom_voyageur VARCHAR(50) NOT NULL,
    Adresse_e_mail_voyageur VARCHAR(60) NOT NULL,
    PRIMARY KEY (Numéro_voyageur)
) ENGINE=InnoDB;

-- 4. Table Agent (dépend de Gare et de elle-même)
CREATE TABLE Agent (
    Matricule_Agent DECIMAL(6,0) NOT NULL,
    Nom_agent VARCHAR(50) NOT NULL,
    Fonction_agent VARCHAR(25) NOT NULL,
    Date_embauche_ DATE NOT NULL,
    Matricule_Agent_responsable DECIMAL(6,0) NULL, -- NULL pour le directeur
    Code_Uic_gare DECIMAL(8,0) NOT NULL,
    PRIMARY KEY (Matricule_Agent),
    FOREIGN KEY (Matricule_Agent_responsable) REFERENCES Agent(Matricule_Agent) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (Code_Uic_gare) REFERENCES Gare(Code_Uic_gare) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Table Voiture (dépend de Rame)
CREATE TABLE Voiture (
    Numéro_de_vouture DECIMAL(2,0) NOT NULL,
    Numéro_de_rame VARCHAR(6) NOT NULL,
    PRIMARY KEY (Numéro_de_rame, Numéro_de_vouture),
    FOREIGN KEY (Numéro_de_rame) REFERENCES Rame(Numéro_de_rame) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. Table Place (dépend de Voiture)
CREATE TABLE Place (
    Numéro_de_place_ DECIMAL(3,0) NOT NULL,
    Classe_de_la_place VARCHAR(10) NOT NULL,
    Numéro_de_vouture DECIMAL(2,0) NOT NULL,
    Numéro_de_rame VARCHAR(6) NOT NULL,
    PRIMARY KEY (Numéro_de_rame, Numéro_de_vouture, Numéro_de_place_),
    FOREIGN KEY (Numéro_de_rame, Numéro_de_vouture) REFERENCES Voiture(Numéro_de_rame, Numéro_de_vouture) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Table Intervention_ (dépend de Rame)
CREATE TABLE Intervention_ (
    Numéro_d_intervention DECIMAL(8,0) NOT NULL,
    Date_d_intervention DATE NOT NULL,
    Nature_intervention VARCHAR(20) NOT NULL,
    Durée_d_intervention DECIMAL(4,0) NOT NULL,
    Numéro_de_rame VARCHAR(6) NOT NULL,
    PRIMARY KEY (Numéro_d_intervention),
    FOREIGN KEY (Numéro_de_rame) REFERENCES Rame(Numéro_de_rame) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. Table Circulation (dépend de Rame et Gare)
CREATE TABLE Circulation (
    Numéro_circulation DECIMAL(8,0) NOT NULL,
    Date_de_circulation DATE NOT NULL,
    Type_de_service VARCHAR(15) NOT NULL,
    Heure_de_départ TIME NOT NULL,
    Heure_d_arrivee TIME NOT NULL,
    Retard_à_l_arrivée VARCHAR(3) NULL,
    Motif_retard VARCHAR(50) NULL,
    Numéro_de_rame VARCHAR(6) NOT NULL,
    Code_Uic_gare DECIMAL(8,0) NOT NULL,      -- Gare de départ
    Code_Uic_gare_1 DECIMAL(8,0) NOT NULL,    -- Gare d'arrivée
    PRIMARY KEY (Numéro_circulation),
    FOREIGN KEY (Numéro_de_rame) REFERENCES Rame(Numéro_de_rame) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Code_Uic_gare) REFERENCES Gare(Code_Uic_gare) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Code_Uic_gare_1) REFERENCES Gare(Code_Uic_gare) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 9. Table Réserver (dépend de Circulation, Place, Voyageur)
CREATE TABLE Réserver (
    Numéro_circulation DECIMAL(8,0) NOT NULL,
    Numéro_de_place_ DECIMAL(3,0) NOT NULL,
    Numéro_de_vouture DECIMAL(2,0) NOT NULL,
    Numéro_de_rame VARCHAR(6) NOT NULL,
    Numéro_voyageur DECIMAL(8,2) NOT NULL,
    Date_réservation DATE NOT NULL,
    Prix_payé DECIMAL(7,0) NOT NULL,
    Statut_de_la_réservation VARCHAR(12) NOT NULL,
    PRIMARY KEY (Numéro_circulation, Numéro_de_rame, Numéro_de_vouture, Numéro_de_place_),
    FOREIGN KEY (Numéro_circulation) REFERENCES Circulation(Numéro_circulation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Numéro_de_rame, Numéro_de_vouture, Numéro_de_place_) REFERENCES Place(Numéro_de_rame, Numéro_de_vouture, Numéro_de_place_) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Numéro_voyageur) REFERENCES Voyageur(Numéro_voyageur) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 10. Table Affecter (dépend de Circulation et Agent)
CREATE TABLE Affecter (
    Numéro_circulation DECIMAL(8,0) NOT NULL,
    Matricule_Agent DECIMAL(6,0) NOT NULL,
    Heure_de_prise_de_service TIME NOT NULL,
    PRIMARY KEY (Numéro_circulation, Matricule_Agent),
    FOREIGN KEY (Numéro_circulation) REFERENCES Circulation(Numéro_circulation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Matricule_Agent) REFERENCES Agent(Matricule_Agent) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 11. Table Participer (dépend de Agent et Intervention_)
CREATE TABLE Participer (
    Matricule_Agent DECIMAL(6,0) NOT NULL,
    Numéro_d_intervention DECIMAL(8,0) NOT NULL,
    PRIMARY KEY (Matricule_Agent, Numéro_d_intervention),
    FOREIGN KEY (Matricule_Agent) REFERENCES Agent(Matricule_Agent) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Numéro_d_intervention) REFERENCES Intervention_(Numéro_d_intervention) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;