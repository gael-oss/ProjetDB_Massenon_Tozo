USE gestion_ferroviaire;

-- 1. Insertion des Gares
INSERT INTO Gare (Code_Uic_gare, nom_gare, Ville_gare, Nombre_de_voies_gare) VALUES
(87113001, 'Paris Gare de Lyon', 'Paris', 28),
(87212027, 'Lyon Part-Dieu', 'Lyon', 12),
(87481002, 'Bordeaux Saint-Jean', 'Bordeaux', 11),
(87381009, 'Marseille Saint-Charles', 'Marseille', 15),
(87114002, 'Lille Europe', 'Lille', 6),
(87271005, 'Strasbourg', 'Strasbourg', 10),
(87471003, 'Nantes', 'Nantes', 9),
(87686006, 'Montpellier Saint-Roch', 'Montpellier', 8),
(87751008, 'Rennes', 'Rennes', 7),
(87171009, 'Dijon-Ville', 'Dijon', 6);

-- 2. Insertion des Rames
INSERT INTO Rame (Numéro_de_rame, Modèle_de_rame, Année_de_mise_en_service) VALUES
('R001', 'Duplex', 2018),
('R002', 'Océane', 2020),
('R003', 'TGV Réseau', 2015),
('R004', 'Duplex', 2021),
('R005', 'Océane', 2022);

-- 3. Insertion des Voitures (3 voitures par rame)
INSERT INTO Voiture (Numéro_de_vouture, Numéro_de_rame) VALUES
(1, 'R001'), (2, 'R001'), (3, 'R001'),
(1, 'R002'), (2, 'R002'), (3, 'R002'),
(1, 'R003'), (2, 'R003'), (3, 'R003'),
(1, 'R004'), (2, 'R004'), (3, 'R004'),
(1, 'R005'), (2, 'R005'), (3, 'R005');

-- 4. Insertion des Places (Exemple pour les 3 voitures de la R001)
INSERT INTO Place (Numéro_de_place_, Classe_de_la_place, Numéro_de_vouture, Numéro_de_rame) VALUES
-- Voiture 1 R001 (1re classe)
(1, '1re classe', 1, 'R001'), (2, '1re classe', 1, 'R001'), (3, '1re classe', 1, 'R001'),
-- Voiture 2 R001 (2de classe)
(1, '2de classe', 2, 'R001'), (2, '2de classe', 2, 'R001'), (3, '2de classe', 2, 'R001'),
-- Voiture 3 R001 (2de classe)
(1, '2de classe', 3, 'R001'), (2, '2de classe', 3, 'R001'), (3, '2de classe', 3, 'R001'),
-- Exemple pour la R002 (Voiture 1)
(1, '1re classe', 1, 'R002'), (2, '1re classe', 1, 'R002'),
(1, '2de classe', 2, 'R002'), (2, '2de classe', 2, 'R002');

-- 5. Insertion des Voyageurs
INSERT INTO Voyageur (Numéro_voyageur, Nom_voyageur, Prénom_voyageur, Adresse_e_mail_voyageur) VALUES
(10001, 'Dupont', 'Jean', 'jean.dupont@email.fr'),
(10002, 'Martin', 'Marie', 'marie.martin@email.fr'),
(10003, 'Bernard', 'Pierre', 'pierre.bernard@email.fr'),
(10004, 'Petit', 'Sophie', 'sophie.petit@email.fr'),
(10005, 'Durand', 'Lucas', 'lucas.durand@email.fr'),
(10006, 'Leroy', 'Emma', 'emma.leroy@email.fr'),
(10007, 'Moreau', 'Thomas', 'thomas.moreau@email.fr'),
(10008, 'Simon', 'Chloé', 'chloe.simon@email.fr'),
(10009, 'Laurent', 'Nicolas', 'nicolas.laurent@email.fr'),
(10010, 'Lefebvre', 'Camille', 'camille.lefebvre@email.fr');

-- 6. Insertion des Agents (Le directeur a un responsable NULL)
INSERT INTO Agent (Matricule_Agent, Nom_agent, Fonction_agent, Date_embauche_, Matricule_Agent_responsable, Code_Uic_gare) VALUES
(100001, 'Directeur Général', 'chef de bord', '2010-01-01', NULL, 87113001),
(100002, 'Paul Responsable', 'chef de bord', '2012-05-15', 100001, 87113001),
(100003, 'Marc Conducteur', 'conducteur', '2015-03-10', 100002, 87113001),
(100004, 'Lucie Contrôleuse', 'contrôleur', '2016-07-20', 100002, 87212027),
(100005, 'Antoine Conducteur', 'conducteur', '2018-09-01', 100002, 87212027),
(100006, 'Sarah Contrôleuse', 'contrôleur', '2019-11-12', 100002, 87481002),
(100007, 'Tech1 Maintenance', 'technicien de maintenance', '2020-02-01', 100002, 87381009),
(100008, 'Tech2 Maintenance', 'technicien de maintenance', '2021-06-15', 100002, 87114002),
(100009, 'Agent Escale 1', 'agent d''escale', '2017-08-30', 100002, 87271005),
(100010, 'Agent Escale 2', 'agent d''escale', '2018-12-01', 100002, 87471003);

-- 7. Insertion des Interventions (Assurez-vous que les rames ne circulent pas ces jours-là)
INSERT INTO Intervention_ (Numéro_d_intervention, Date_d_intervention, Nature_intervention, Durée_d_intervention, Numéro_de_rame) VALUES
(5001, '2024-05-01', 'révision', 8, 'R001'),
(5002, '2024-05-02', 'nettoyage', 2, 'R002'),
(5003, '2024-05-03', 'réparation', 5, 'R003'),
(5004, '2024-05-04', 'révision', 10, 'R004'),
(5005, '2024-05-05', 'nettoyage', 3, 'R005');

-- 8. Insertion des Circulations (Respect des dates sans intervention pour la même rame)
INSERT INTO Circulation (Numéro_circulation, Date_de_circulation, Type_de_service, Heure_de_départ, Heure_d_arrivee, Retard_à_l_arrivée, Motif_retard, Numéro_de_rame, Code_Uic_gare, Code_Uic_gare_1) VALUES
(8001, '2024-05-02', 'TGV INOUI', '08:00:00', '10:00:00', '0', NULL, 'R001', 87113001, 87212027),
(8002, '2024-05-02', 'OUIGO', '09:30:00', '12:30:00', '15', 'incident technique', 'R002', 87113001, 87481002),
(8003, '2024-05-03', 'TER', '10:00:00', '11:30:00', '0', NULL, 'R003', 87212027, 87381009),
(8004, '2024-05-04', 'Intercités', '14:00:00', '17:00:00', '5', 'météo', 'R004', 87481002, 87114002),
(8005, '2024-05-05', 'TGV INOUI', '16:00:00', '18:30:00', '0', NULL, 'R005', 87271005, 87113001);

-- 9. Insertion des Affectations (Au moins 1 conducteur et 1 contrôleur par circulation)
-- Circulation 8001 (R001)
INSERT INTO Affecter (Numéro_circulation, Matricule_Agent, Heure_de_prise_de_service) VALUES
(8001, 100003, '07:30:00'), -- Conducteur
(8001, 100004, '07:30:00'), -- Contrôleur
(8001, 100009, '07:00:00'); -- Agent d'escale

-- Circulation 8002 (R002)
INSERT INTO Affecter (Numéro_circulation, Matricule_Agent, Heure_de_prise_de_service) VALUES
(8002, 100005, '09:00:00'), -- Conducteur
(8002, 100006, '09:00:00'); -- Contrôleur

-- Circulation 8003 (R003)
INSERT INTO Affecter (Numéro_circulation, Matricule_Agent, Heure_de_prise_de_service) VALUES
(8003, 100003, '09:30:00'), 
(8003, 100004, '09:30:00');

-- 10. Insertion des Participations (Techniciens aux interventions)
INSERT INTO Participer (Matricule_Agent, Numéro_d_intervention) VALUES
(100007, 5001),
(100008, 5001),
(100007, 5003),
(100008, 5004),
(100007, 5005);

-- 11. Insertion des Réservations (La place doit correspondre à la rame de la circulation)
-- Rappel : Circulation 8001 utilise la rame R001.
INSERT INTO Réserver (Numéro_circulation, Numéro_de_place_, Numéro_de_vouture, Numéro_de_rame, Numéro_voyageur, Date_réservation, Prix_payé, Statut_de_la_réservation) VALUES
(8001, 1, 1, 'R001', 10001, '2024-04-15', 120, 'confirmée'),
(8001, 2, 1, 'R001', 10002, '2024-04-16', 120, 'confirmée'),
(8001, 1, 2, 'R001', 10003, '2024-04-17', 80, 'annulée'),
(8001, 3, 2, 'R001', 10004, '2024-04-18', 80, 'confirmée');

-- Rappel : Circulation 8002 utilise la rame R002.
INSERT INTO Réserver (Numéro_circulation, Numéro_de_place_, Numéro_de_vouture, Numéro_de_rame, Numéro_voyageur, Date_réservation, Prix_payé, Statut_de_la_réservation) VALUES
(8002, 1, 1, 'R002', 10005, '2024-04-20', 45, 'confirmée'),
(8002, 2, 1, 'R002', 10006, '2024-04-21', 45, 'échangée');