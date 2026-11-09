# ProjetDB_Massenon_Tozo
# Prompt final Utilisé
Tu travailles dans le domaine du transport ferroviaire de voyageurs. Ton entreprise a comme activité l'exploitation de trains, la gestion des gares et la vente de places aux voyageurs. C'est une entreprise de transport à capital public comme la SNCF. Les données ont été collectées sur les gares, les circulations de trains, les rames, les places, les voyageurs, les réservations, les agents et les interventions de maintenance. Inspire-toi du site web de la SNCF et de ton expérience de voyageur. 

Ton entreprise veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c'est-à-dire de collecter les besoins auprès de l'entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet : tu dois lui fournir les informations nécessaires pour qu'il applique ensuite lui-même les étapes suivantes de conception et de développement de la base de données. 

D'abord, établis les règles de gestion des données de ton entreprise, sous la forme d'une liste à puces. Elles doivent correspondre aux informations que fournit quelqu'un qui connaît le fonctionnement de l'entreprise, mais pas la façon dont se construit un système d'information. Ces règles doivent décrire des situations réelles qui permettront à l'étudiant de faire apparaître, dans son modèle, une association récursive, une association entre plus de deux éléments et une entité dépendant d'une autre pour être identifiée, sans que tu aies à les nommer. 

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes regroupées dans un tableau, avec les colonnes suivantes : nom de la donnée, signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type), mais sans a priori sur la manière dont les données seront modélisées ensuite. 

Fournis donc les règles de gestion et le dictionnaire de données.

# Règles de gestion

## Nos gares

Nous exploitons des gares. Chacune a un code unique, un nom, une ville et un nombre de voies.

## Nos circulations

Chaque jour, nos trains circulent. Une circulation correspond à un train qui roule un jour donné : elle a un numéro, une date, un type de service (TGV INOUI, OUIGO, TER ou Intercités), une heure de départ prévue et une heure d'arrivée prévue.

## Départ et arrivée

Chaque circulation part d'une gare et arrive dans une autre gare. Une gare peut être le point de départ ou d'arrivée de nombreuses circulations.

## Retards

Quand une circulation arrive en retard, on note le retard à l'arrivée en minutes ainsi que son motif (incident technique, signalisation, météo, etc.).

## Nos rames

Nos trains sont formés de rames. Chaque rame a un numéro, un modèle (par exemple Duplex ou Océane) et une année de mise en service.

## Rame et circulation

Chaque circulation est assurée par une seule rame. Une rame assure plusieurs circulations au fil du temps.

## Voitures et places

Une rame est composée de voitures numérotées. Chaque voiture contient des places numérotées. Le numéro d'une place n'a de sens que dans sa voiture et dans sa rame : la place 12 de la voiture 3 existe dans toutes nos rames. Chaque place est de 1re ou de 2de classe.

## Nos voyageurs

Nos voyageurs ont un numéro de client, un nom, un prénom et une adresse e-mail.

## Réservations

Un voyageur réserve une place précise pour une circulation précise. Pour une circulation donnée, une place n'est réservée qu'à un seul voyageur. Une même place peut en revanche être réservée pour plusieurs circulations (à des jours différents). Un voyageur peut réserver plusieurs places sur la même circulation, par exemple pour sa famille.

## Suivi des réservations

Pour chaque réservation, on note la date de réservation, le prix payé et son statut : confirmée, annulée ou échangée.

## Cohérence des places

La place réservée doit se trouver dans la rame qui assure la circulation.

## Nos agents

Nos agents ont un matricule, un nom, une fonction (conducteur, contrôleur, chef de bord, agent d'escale ou technicien de maintenance) et une date d'embauche. Chaque agent est rattaché à une seule gare.

## Encadrement

Chaque agent est encadré par un responsable, qui est lui-même un agent de l'entreprise. Un responsable encadre plusieurs agents. Seul le directeur n'a pas de responsable.

## Équipes à bord

Chaque circulation est assurée par plusieurs agents (au moins un conducteur et un contrôleur). Un agent peut être affecté à plusieurs circulations. Pour chaque affectation, on note son heure de prise de service.

## Maintenance

Nos rames font l'objet d'interventions de maintenance (révision, réparation ou nettoyage). Chaque intervention a un numéro, une date, une nature et une durée en heures.

## Qui intervient

Une intervention porte sur une seule rame, mais une rame subit de nombreuses interventions. Elle est réalisée par un ou plusieurs techniciens, et un technicien participe à de nombreuses interventions.

## Disponibilité

Une rame en intervention de maintenance un jour donné ne peut pas assurer de circulation ce jour-là.

# Dictionnaire de données

| N° | Donnée | Signification | Type | Taille |
|----|--------|---------------|------|--------|
| 1 | Code UIC de la gare | Code unique identifiant une gare | Numérique | 8 |
| 2 | Nom gare | Nom officiel de la gare | Texte | 40 |
| 3 | Ville gare | Ville où se situe la gare | Texte | 30 |
| 4 | Nombre de voies | Nombre de voies à quai de la gare | Numérique | 2 |
| 5 | Numéro de circulation | Identifiant unique d'un train qui circule un jour donné | Numérique | 8 |
| 6 | Date de circulation | Jour où la circulation a lieu | Date (JJ/MM/AAAA) | 10 |
| 7 | Type de service | TGV INOUI, OUIGO, TER ou Intercités | Texte | 15 |
| 8 | Heure de départ prévue | Heure de départ prévue de la gare de départ | Heure (HH:MM) | 5 |
| 9 | Heure d'arrivée prévue | Heure d'arrivée prévue à la gare d'arrivée | Heure (HH:MM) | 5 |
| 10 | Retard à l'arrivée | Retard constaté à l'arrivée, en minutes | Numérique | 3 |
| 11 | Motif du retard | Cause du retard (incident technique, météo, etc.) | Texte | 40 |
| 12 | Numéro de rame | Identifiant unique d'une rame | Alphanumérique | 6 |
| 13 | Modèle de rame | Modèle de matériel roulant (Duplex, Océane, etc.) | Texte | 20 |
| 14 | Année de mise en service | Année où la rame a commencé à circuler | Numérique | 4 |
| 15 | Numéro de voiture | Numéro de la voiture dans la rame | Numérique | 2 |
| 16 | Numéro de place | Numéro de la place dans la voiture | Numérique | 3 |
| 17 | Classe de la place | 1re classe ou 2de classe | Texte | 10 |
| 18 | Numéro voyageur | Identifiant unique d'un voyageur | Numérique | 8 |
| 19 | Nom voyageur | Nom de famille du voyageur | Texte | 50 |
| 20 | Prénom voyageur | Prénom du voyageur | Texte | 30 |
| 21 | Adresse e-mail voyageur | Adresse e-mail de contact du voyageur | Texte | 60 |
| 22 | Date de réservation | Jour où la réservation a été faite | Date (JJ/MM/AAAA) | 10 |
| 23 | Prix payé | Montant payé pour la réservation, en € | Décimal | 7 |
| 24 | Statut de la réservation | Confirmée, annulée ou échangée | Texte | 12 |
| 25 | Matricule agent | Identifiant unique d'un agent | Numérique | 6 |
| 26 | Nom agent | Nom et prénom de l'agent | Texte | 50 |
| 27 | Fonction agent | Conducteur, contrôleur, chef de bord, agent d'escale ou technicien | Texte | 25 |
| 28 | Date d'embauche | Jour où l'agent a été embauché | Date (JJ/MM/AAAA) | 10 |
| 29 | Heure de prise de service | Heure à laquelle l'agent commence son service sur une circulation | Heure (HH:MM) | 5 |
| 30 | Numéro d'intervention | Identifiant unique d'une intervention de maintenance | Numérique | 8 |
| 31 | Date d'intervention | Jour où l'intervention a lieu | Date (JJ/MM/AAAA) | 10 |
| 32 | Nature d'intervention | Révision, réparation ou nettoyage | Texte | 20 |
| 33 | Durée d'intervention | Durée de l'intervention, en heures | Décimal | 4 |

# Modèle Conceptuel de Données
<img width="880" alt="MCD - Modèle Conceptuel de Données" src="https://github.com/user-attachments/assets/1d1bc35f-35db-4c02-8f75-6cc65fa25801" />

# Modèle Logique de données
```text
Gare = (Code_Uic_gare DECIMAL(8,0), nom_gare VARCHAR(40), Ville_gare VARCHAR(30), Nombre_de_voies_gare DECIMAL(2,0));
Rame = (Numéro_de_rame VARCHAR(6), Modèle_de_rame VARCHAR(20), Année_de_mise_en_service DECIMAL(4,0));
Voiture = (Numéro_de_voiture DECIMAL(2,0), #Numéro_de_rame);
Place = (Numéro_de_place_ DECIMAL(3,0), Classe_de_la_place VARCHAR(10), #Numéro_de_voiture);
Voyageur = (Numéro_voyageur DECIMAL(8,2), Nom_voyageur VARCHAR(50), Prénom_voyageur VARCHAR(50), Adresse_e_mail_voyageur VARCHAR(60));
Agent = (Matricule_Agent DECIMAL(6,0), Nom_agent VARCHAR(50), Fonction_agent VARCHAR(25), Date_embauche_ DATE, #Matricule_Agent_responsable*, #Code_Uic_gare);
Intervention_ = (Numéro_d_intervention DECIMAL(8,0), Date_d_intervention DATE, Nature_intervention VARCHAR(20), Durée_d_intervention DECIMAL(4,0), #Numéro_de_rame);
Circulation = (Numéro_circulation DECIMAL(8,0), Date_de_circulation DATE, Type_de_service VARCHAR(15), Heure_de_départ TIME, Heure_d_arrivee TIME, Retard_à_l_arrivée VARCHAR(3), Motif_retard VARCHAR(50), #Numéro_de_rame, #Code_Uic_gare, #Code_Uic_gare_1);
Réserver = (#Numéro_circulation, #Numéro_de_place_, #Numéro_voyageur, Date_réservation DATE, Prix_payé DECIMAL(7,0), Statut_de_la_réservation VARCHAR(12));
Affecter = (#Numéro_circulation, #Matricule_Agent, Heure_de_prise_de_service TIME);
Participer = (#Matricule_Agent, #Numéro_d_intervention);
```


## Prompt à soumis à l'IA

Tu es un expert en bases de données SQL (MySQL/MariaDB). 
Je te fournis le schéma de ma base de données ferroviaire. 
Ta mission est de générer un script SQL d'insertion (fichier 3_insertion.sql) contenant un nombre conséquent de données réalistes (au moins 50 lignes par table principale).

### SCHÉMA DE LA BASE (MPD)
Gare = (Code_Uic_gare DECIMAL(8,0), nom_gare VARCHAR(40), Ville_gare VARCHAR(30), Nombre_de_voies_gare DECIMAL(2,0));
Rame = (Numéro_de_rame VARCHAR(6), Modèle_de_rame VARCHAR(20), Année_de_mise_en_service DECIMAL(4,0));
Voiture = (Numéro_de_voiture DECIMAL(2,0), #Numéro_de_rame);
Place = (Numéro_de_place_ DECIMAL(3,0), Classe_de_la_place VARCHAR(10), #Numéro_de_voiture);
Voyageur = (Numéro_voyageur DECIMAL(8,2), Nom_voyageur VARCHAR(50), Prénom_voyageur VARCHAR(50), Adresse_e_mail_voyageur VARCHAR(60));
Agent = (Matricule_Agent DECIMAL(6,0), Nom_agent VARCHAR(50), Fonction_agent VARCHAR(25), Date_embauche_ DATE, #Matricule_Agent_responsable*, #Code_Uic_gare);
Intervention_ = (Numéro_d_intervention DECIMAL(8,0), Date_d_intervention DATE, Nature_intervention VARCHAR(20), Durée_d_intervention DECIMAL(4,0), #Numéro_de_rame);
Circulation = (Numéro_circulation DECIMAL(8,0), Date_de_circulation DATE, Type_de_service VARCHAR(15), Heure_de_départ TIME, Heure_d_arrivee TIME, Retard_à_l_arrivée VARCHAR(3), Motif_retard VARCHAR(50), #Numéro_de_rame, #Code_Uic_gare, #Code_Uic_gare_1);
Réserver = (#Numéro_circulation, #Numéro_de_place_, #Numéro_voyageur, Date_réservation DATE, Prix_payé DECIMAL(7,0), Statut_de_la_réservation VARCHAR(12));
Affecter = (#Numéro_circulation, #Matricule_Agent, Heure_de_prise_de_service TIME);
Participer = (#Matricule_Agent, #Numéro_d_intervention);

### CONTRAINTES À RESPECTER ABSOLUMENT
1. L'ordre des INSERT doit respecter les dépendances (insérer les Gares, Rames, Voyageurs en premier, puis les tables dépendantes).
2. Respecter les contraintes CHECK définies :
   - Fonction_agent : 'conducteur', 'contrôleur', 'chef de bord', 'agent d''escale', 'technicien de maintenance'
   - Nature_intervention : 'révision', 'réparation', 'nettoyage'
   - Type_de_service : 'TGV INOUI', 'OUIGO', 'TER', 'Intercités'
   - Classe_de_la_place : '1re classe', '2de classe'
   - Statut_de_la_réservation : 'confirmée', 'annulée', 'échangée'
   - Code_Uic_gare (départ) <> Code_Uic_gare_1 (arrivée)
3. Règle métier : Au moins un conducteur et un contrôleur par circulation dans la table Affecter.
4. Règle métier : La place réservée doit appartenir à la rame qui assure la circulation.
5. Règle métier : Une rame en maintenance un jour J ne doit pas avoir de circulation ce même jour J.
6. Le champ Matricule_Agent_responsable peut être NULL (seul le directeur n'a pas de responsable).

### FORMAT DE SORTIE ATTENDU
Génère uniquement le code SQL, avec des commentaires pour séparer chaque table. 
Utilise des données réalistes (villes françaises, noms francophones, modèles de trains réels).


## Scénario d'utilisation

###  Contexte

La base de données ferroviaire est exploitée par la **SNCF** (Société Nationale des Chemins de fer Français). Plus précisément, elle est utilisée par la **Direction du Pilotage & de la Qualité (DPQ)**. 

Ce service est chargé de surveiller la ponctualité des trains, la fréquentation des lignes, la disponibilité du matériel roulant et la performance des équipes. Les données extraites servent à produire des rapports stratégiques pour la direction, à optimiser l'offre de transport (TGV INOUI, OUIGO, TER, Intercités) et à anticiper les besoins en maintenance.

###  Rôle de l'utilisateur : Analyste de données (Data Analyst)

**Mission :** Interroger la base de données pour produire des tableaux de bord et des indicateurs de performance (KPI) destinés aux décideurs de la SNCF.

###  Données à extraire

L'analyste doit être en mesure d'extraire les informations suivantes :

1. **Suivi de la ponctualité :** 
   - Liste des circulations en retard (triées par retard décroissant), avec la gare de départ, d'arrivée et le motif.
   - Identification des axes ferroviaires les plus impactés par les retards.

2. **Occupation des places :** 
   - Taux de remplissage des rames (nombre de places réservées / nombre total de places) pour une période donnée.
   - Répartition des réservations par classe (1re ou 2de classe) et par type de service.

3. **Disponibilité du matériel :** 
   - Rames n'ayant fait l'objet d'aucune intervention de maintenance sur une période, afin de les affecter à de nouvelles circulations.
   - Historique des interventions (révision, réparation, nettoyage) par rame.

4. **Statistiques voyageurs :** 
   - Répartition des réservations par statut (confirmées, annulées, échangées).
   - Identification des voyageurs les plus fidèles (nombre de réservations par voyageur).

5. **Performance des agents :** 
   - Nombre de circulations affectées à chaque agent (conducteurs, contrôleurs, chefs de bord).
   - Temps moyen de prise de service par gare.

6. **Alertes maintenance :** 
   - Rames ayant subi plus de 3 interventions de type "réparation" dans l'année.
   - Gares ayant le plus grand nombre d'agents rattachés.
  


### 3. Étude du plan d'exécution (Algèbre relationnelle)

Pour illustrer l'optimisation des requêtes, nous étudions la requête suivante. Elle utilise **trois opérateurs de l'algèbre relationnelle** : la sélection (σ), la jointure (⨝) et l'agrégation (γ).

**Requête étudiée :** Nombre de réservations confirmées par type de service TGV INOUI.

```sql
SELECT c.Type_de_service, COUNT(*) AS nb_reservations
FROM Réserver r
INNER JOIN Circulation c ON r.Numéro_circulation = c.Numéro_circulation
WHERE c.Type_de_service = 'TGV INOUI' AND r.Statut_de_la_réservation = 'confirmée'
GROUP BY c.Type_de_service;
```
Pour simplifier les calculs de coût, nous posons les hypothèses suivantes sur le volume de données :

    Table Circulation : 1 000 lignes au total.

    Table Réserver : 10 000 lignes au total.

    Sélection Type_de_service = 'TGV INOUI' : 200 lignes (20% des circulations).

    Sélection Statut = 'confirmée' : 7 000 lignes (70% des réservations)

# Arbre relationnel 1 : Plan neutre (Jointure d'abord)

Ce plan effectue la jointure cartésienne des deux tables complètes, puis applique les filtres (sélections) et enfin l'agrégation.

https://github.com/gael-oss/ProjetDB_Massenon_Tozo/blob/main/jointure_dabord.png

Calcul du coût (nombre d'instructions) :

    Jointure (⨝) : 1 000 (Circulation) × 10 000 (Réserver) = 10 000 000 comparaisons.

    Sélection (σ) sur le résultat : 10 000 000 lignes à parcourir.

    Agrégation (γ) : Traitement des lignes restantes.

    Total : ~10 000 000+ instructions. (Très coûteux)

# Arbre relationnel 2 : Plan Optimisé (Sélections avant jointure)

Ce plan applique les sélections (σ) le plus tôt possible pour réduire la taille des relations avant de faire la jointure. C'est ce que fait naturellement l'optimiseur de requêtes SQL.

https://./images/selection_avant_jointure.png

Calcul du coût (nombre d'instructions) :

    Sélection (σ) sur Circulation : 1 000 lignes parcourues → 200 lignes retenues.

    Sélection (σ) sur Réserver : 10 000 lignes parcourues → 7 000 lignes retenues.

    Jointure (⨝) : 200 × 7 000 = 1 400 000 comparaisons.

    Agrégation (γ) : Traitement des 1 400 000 lignes jointes.

    Total : 1 000 + 10 000 + 1 400 000 = ~1 411 000 instructions.

# Conclusion

Le plan d'exécution optimisé est l'Arbre 2 (Sélections avant jointure).

En appliquant les filtres (σ) avant la jointure, on réduit considérablement le nombre de lignes à traiter lors de la jointure (de 10 millions de comparaisons à 1,4 million). 
