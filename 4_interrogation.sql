USE gestion_ferroviaire;

-- 1. PROJECTIONS ET SÉLECTIONS
-- Données : Nom de la gare, ville, nombre de voies
SELECT nom_gare, Ville_gare, Nombre_de_voies_gare
FROM Gare
WHERE Nombre_de_voies_gare > 10
ORDER BY Nombre_de_voies_gare DESC;

-- Q1.2 : Masque sur l'email des voyageurs dont le nom commence par 'D'
-- Données : Nom, prénom et email masqué (ex: j***.d***@email.fr)
SELECT Nom_voyageur, Prénom_voyageur, 
       CONCAT(LEFT(Adresse_e_mail_voyageur, 1), '***', SUBSTRING(Adresse_e_mail_voyageur, LOCATE('@', Adresse_e_mail_voyageur))) AS email_masque
FROM Voyageur
WHERE Nom_voyageur LIKE 'D%';

-- Q1.3 : Circulations de type TGV INOUI ou OUIGO le 2 mai 2024, avec retard compris entre 5 et 30 min
-- Données : Numéro, type de service, retard
SELECT Numéro_circulation, Type_de_service, Retard_à_l_arrivée
FROM Circulation
WHERE Type_de_service IN ('TGV INOUI', 'OUIGO')
  AND Date_de_circulation = '2024-05-02'
  AND Retard_à_l_arrivée BETWEEN 5 AND 30
ORDER BY Retard_à_l_arrivée DESC;

-- Q1.4 : Liste unique des motifs de retard constatés (DISTINCT)
-- Données : Motif de retard
SELECT DISTINCT Motif_retard
FROM Circulation
WHERE Motif_retard IS NOT NULL;

-- Q1.5 : Agents embauchés entre 2015 et 2020, triés par date d'embauche
-- Données : Matricule, nom, fonction, date d'embauche
SELECT Matricule_Agent, Nom_agent, Fonction_agent, Date_embauche_
FROM Agent
WHERE Date_embauche_ BETWEEN '2015-01-01' AND '2020-12-31'
ORDER BY Date_embauche_ ASC;


-- 2. FONCTIONS D'AGRÉGATION 


-- Q2.1 : Nombre de circulations par type de service
-- Données : Type de service, nombre de circulations
SELECT Type_de_service, COUNT(*) AS nb_circulations
FROM Circulation
GROUP BY Type_de_service
ORDER BY nb_circulations DESC;

-- Q2.2 : Retard moyen et nombre de retards par motif, pour les motifs ayant plus de 2 occurrences
-- Données : Motif, retard moyen, nombre de retards
SELECT Motif_retard, AVG(CAST(Retard_à_l_arrivée AS DECIMAL(5,2))) AS retard_moyen, COUNT(*) AS nb_retards
FROM Circulation
WHERE Motif_retard IS NOT NULL
GROUP BY Motif_retard
HAVING COUNT(*) > 2;

-- Q2.3 : Nombre total de places par rame et par classe
-- Données : Numéro de rame, classe, nombre de places
SELECT Numéro_de_rame, Classe_de_la_place, COUNT(*) AS nb_places
FROM Place
GROUP BY Numéro_de_rame, Classe_de_la_place
ORDER BY Numéro_de_rame, Classe_de_la_place;

-- Q2.4 : Prix moyen et nombre de réservations par statut de réservation
-- Données : Statut, prix moyen, nombre de réservations
SELECT Statut_de_la_réservation, AVG(Prix_payé) AS prix_moyen, COUNT(*) AS nb_reservations
FROM Réserver
GROUP BY Statut_de_la_réservation;

-- Q2.5 : Nombre d'interventions par nature, avec durée totale et durée moyenne, pour les natures ayant une durée totale > 10h
-- Données : Nature, nombre, durée totale, durée moyenne
SELECT Nature_intervention, COUNT(*) AS nb_interventions, SUM(Durée_d_intervention) AS duree_totale, AVG(Durée_d_intervention) AS duree_moyenne
FROM Intervention_
GROUP BY Nature_intervention
HAVING SUM(Durée_d_intervention) > 10;


-- 3. JOINTURES 


-- Q3.1 : Jointure interne simple : liste des circulations avec le nom de la gare de départ
-- Données : Numéro circulation, nom gare départ, ville départ
SELECT c.Numéro_circulation, g.nom_gare AS gare_depart, g.Ville_gare AS ville_depart
FROM Circulation c
INNER JOIN Gare g ON c.Code_Uic_gare = g.Code_Uic_gare;

-- Q3.2 : Jointure externe gauche : liste de toutes les rames, avec le nombre de voitures (0 si aucune)
-- Données : Numéro rame, modèle, nombre de voitures
SELECT r.Numéro_de_rame, r.Modèle_de_rame, COUNT(v.Numéro_de_vouture) AS nb_voitures
FROM Rame r
LEFT JOIN Voiture v ON r.Numéro_de_rame = v.Numéro_de_rame
GROUP BY r.Numéro_de_rame, r.Modèle_de_rame;

-- Q3.3 : Jointure multiple : réservations avec le nom du voyageur, le numéro de circulation et le type de service
-- Données : Nom voyageur, numéro circulation, type de service, prix payé
SELECT v.Nom_voyageur, v.Prénom_voyageur, r.Numéro_circulation, c.Type_de_service, r.Prix_payé
FROM Réserver r
INNER JOIN Voyageur v ON r.Numéro_voyageur = v.Numéro_voyageur
INNER JOIN Circulation c ON r.Numéro_circulation = c.Numéro_circulation;

-- Q3.4 : Jointure externe droite : liste des agents et leur responsable (NULL si aucun)
-- Données : Nom agent, fonction, nom du responsable
SELECT a.Nom_agent, a.Fonction_agent, resp.Nom_agent AS nom_responsable
FROM Agent a
RIGHT JOIN Agent resp ON a.Matricule_Agent_responsable = resp.Matricule_Agent;

-- Q3.5 : Jointure multiple avec agrégation : nombre d'agents par gare et par fonction
-- Données : Nom gare, fonction, nombre d'agents
SELECT g.nom_gare, a.Fonction_agent, COUNT(a.Matricule_Agent) AS nb_agents
FROM Gare g
INNER JOIN Agent a ON g.Code_Uic_gare = a.Code_Uic_gare
GROUP BY g.nom_gare, a.Fonction_agent
ORDER BY g.nom_gare, a.Fonction_agent;


-- 4. REQUÊTES IMBRIQUÉES


-- Q4.1 : Voyageurs ayant réservé au moins une place sur la circulation 8001 (IN)
-- Données : Nom, prénom
SELECT Nom_voyageur, Prénom_voyageur
FROM Voyageur
WHERE Numéro_voyageur IN (
    SELECT Numéro_voyageur
    FROM Réserver
    WHERE Numéro_circulation = 8001
);

-- Q4.2 : Rames n'ayant jamais fait l'objet d'une intervention de maintenance (NOT EXISTS)
-- Données : Numéro rame, modèle
SELECT r.Numéro_de_rame, r.Modèle_de_rame
FROM Rame r
WHERE NOT EXISTS (
    SELECT 1
    FROM Intervention_ i
    WHERE i.Numéro_de_rame = r.Numéro_de_rame
);

-- Q4.3 : Circulations dont le retard est supérieur au retard moyen de toutes les circulations (ANY)
-- Données : Numéro circulation, retard
SELECT Numéro_circulation, Retard_à_l_arrivée
FROM Circulation
WHERE CAST(Retard_à_l_arrivée AS DECIMAL(5,2)) > ANY (
    SELECT AVG(CAST(Retard_à_l_arrivée AS DECIMAL(5,2)))
    FROM Circulation
    WHERE Retard_à_l_arrivée IS NOT NULL
);

-- Q4.4 : Agents dont la fonction est 'conducteur' et qui ont participé à des interventions (NOT IN)
-- Données : Matricule, nom
SELECT Matricule_Agent, Nom_agent
FROM Agent
WHERE Fonction_agent = 'conducteur'
  AND Matricule_Agent NOT IN (
      SELECT Matricule_Agent
      FROM Participer
  );

-- Q4.5 : Gares dont toutes les circulations au départ ont un retard inférieur à 10 minutes (ALL)
-- Données : Nom gare, ville
SELECT nom_gare, Ville_gare
FROM Gare
WHERE Code_Uic_gare IN (
    SELECT Code_Uic_gare
    FROM Circulation
    GROUP BY Code_Uic_gare
    HAVING MAX(CAST(Retard_à_l_arrivée AS DECIMAL(5,2))) < 10
);