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
<img width="880" alt="image" src="https://github.com/user-attachments/assets/d268458b-4e2f-4b15-8655-8afc6a7be512" />
