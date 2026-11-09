USE gestion_ferroviaire;
-- 1. CONTRAINTES DE VALIDATION 

-- Contrainte sur la table Gare
ALTER TABLE Gare 
ADD CONSTRAINT chk_gare_voies CHECK (Nombre_de_voies_gare > 0);

-- Contrainte sur la table Rame
ALTER TABLE Rame 
ADD CONSTRAINT chk_rame_annee CHECK (Année_de_mise_en_service >= 1900 AND Année_de_mise_en_service <= 2100);

-- Contrainte sur la table Voyageur
ALTER TABLE Voyageur 
ADD CONSTRAINT chk_voyageur_email CHECK (Adresse_e_mail_voyageur LIKE '%@%.%');

-- Contrainte sur la table Agent
ALTER TABLE Agent 
ADD CONSTRAINT chk_agent_fonction CHECK (Fonction_agent IN ('conducteur', 'contrôleur', 'chef de bord', 'agent d''escale', 'technicien de maintenance'));

-- Contrainte sur la table Place
ALTER TABLE Place 
ADD CONSTRAINT chk_place_classe CHECK (Classe_de_la_place IN ('1re classe', '2de classe'));

-- Contraintes sur la table Intervention_
ALTER TABLE Intervention_ 
ADD CONSTRAINT chk_intervention_nature CHECK (Nature_intervention IN ('révision', 'réparation', 'nettoyage')),
ADD CONSTRAINT chk_intervention_duree CHECK (Durée_d_intervention > 0);

-- Contraintes sur la table Circulation
-- Note : La contrainte chk_circulation_gares (départ <> arrivée) a été retirée car MySQL interdit
-- l'utilisation de colonnes de clés étrangères avec CASCADE dans un CHECK.
ALTER TABLE Circulation 
ADD CONSTRAINT chk_circulation_service CHECK (Type_de_service IN ('TGV INOUI', 'OUIGO', 'TER', 'Intercités')),
ADD CONSTRAINT chk_circulation_retard CHECK (Retard_à_l_arrivée IS NULL OR CAST(Retard_à_l_arrivée AS UNSIGNED) >= 0);

-- Contraintes sur la table Réserver
ALTER TABLE Réserver 
ADD CONSTRAINT chk_reserver_statut CHECK (Statut_de_la_réservation IN ('confirmée', 'annulée', 'échangée')),
ADD CONSTRAINT chk_reserver_prix CHECK (Prix_payé >= 0);



-- 2. TRIGGERS (Contraintes métier complexes)

-- Trigger 1 : Au moins un conducteur et un contrôleur par circulation
DELIMITER //
CREATE TRIGGER trg_affecter_roles
AFTER INSERT ON Affecter
FOR EACH ROW
BEGIN
    DECLARE v_conducteurs INT DEFAULT 0;
    DECLARE v_controleurs INT DEFAULT 0;

    SELECT COUNT(*) INTO v_conducteurs 
    FROM Affecter a JOIN Agent ag ON a.Matricule_Agent = ag.Matricule_Agent 
    WHERE a.Numéro_circulation = NEW.Numéro_circulation AND ag.Fonction_agent = 'conducteur';

    SELECT COUNT(*) INTO v_controleurs 
    FROM Affecter a JOIN Agent ag ON a.Matricule_Agent = ag.Matricule_Agent 
    WHERE a.Numéro_circulation = NEW.Numéro_circulation AND ag.Fonction_agent = 'contrôleur';

    IF v_conducteurs = 0 OR v_controleurs = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Une circulation doit avoir au moins un conducteur et un contrôleur.';
    END IF;
END;
//
DELIMITER ;


-- Trigger 2 : La place réservée doit être dans la rame de la circulation
DELIMITER //
CREATE TRIGGER trg_reserver_coherence
BEFORE INSERT ON Réserver
FOR EACH ROW
BEGIN
    DECLARE v_rame_circulation VARCHAR(6);

    SELECT Numéro_de_rame INTO v_rame_circulation 
    FROM Circulation 
    WHERE Numéro_circulation = NEW.Numéro_circulation;

    IF v_rame_circulation <> NEW.Numéro_de_rame THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La place réservée ne se trouve pas dans la rame de la circulation.';
    END IF;
END;
//
DELIMITER ;


-- Trigger 3 : Une rame en maintenance ne peut pas circuler le même jour
DELIMITER //
CREATE TRIGGER trg_rame_disponible
BEFORE INSERT ON Circulation
FOR EACH ROW
BEGIN
    DECLARE v_maintenance INT DEFAULT 0;

    SELECT COUNT(*) INTO v_maintenance 
    FROM Intervention_ 
    WHERE Numéro_de_rame = NEW.Numéro_de_rame 
      AND Date_d_intervention = NEW.Date_de_circulation;

    IF v_maintenance > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La rame est en maintenance ce jour-là et ne peut pas assurer de circulation.';
    END IF;
END;
//
DELIMITER ;
