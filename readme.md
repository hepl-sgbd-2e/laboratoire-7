# Exercices sur les procédures et fonctions

Les exercices de ce laboratoire sont à réaliser dans la base de données Hôpital.

## Procédure AjouterPatient

Écrire la procédure `AjouterPatient` qui permet d'ajouter une ligne dans la table `Patients`. Cette procédure reçoit
comme paramètre une ligne de la table `Patients`. La violation de la contrainte d'entité, des contraintes référentielles
et la violation des contraintes applicatives seront interceptées pour renvoyer un code d'erreur personnalisé. Le
déclencheur `PatientsInsertNrSIS` est activé.

Construire un jeu de commandes permettant de tester cette procédure.

```sql

```

Test 1 : Ajout correct

```sq

```

Test 2 : Compte bancaire incorrect

```sq

```

Test 3 : État civil NULL

```sq

```

Test 4 : État civil non NULL, mais différent de 'C', 'M', 'D' ou 'V'

```sql

```

Test 5 : Groupe sanguin différent de 'A', 'B', ’O' et 'AB'

```sql

```

Test 6 : Sexe NULL

```sql

```

Test 7 : Sexe non NULL, mais différent de 'M' et 'F'

```sql

```

Test 8 : Code adresse qui n'existe pas dans la table Adresses

```sql

```

Test 9 : Code mutuelle qui n'existe pas dans la table Mutuelles

```sql

```

Test 10 : Nationalité qui n'existe pas dans la table Pays

```sql
```



## Procédure ModifierPatient

Écrire la procédure `ModifierPatient` qui permet de modifier toutes les colonnes de la table `Patients`. Cette procédure
reçoit comme paramètre l'ancien tuple du patient ainsi que le nouveau. La violation de la contrainte d'entité, des
contraintes référentielles et la violation des contraintes applicatives seront interceptées pour renvoyer un code
d'erreur personnalisé. Il faut utiliser la double transaction. Le déclencheur `PatientsUpdateNrSis` est activé.

Construire un jeu de commandes permettant de tester cette procédure.

```sql

```

Test 1 : Modification correcte

```sql

```

Test 2 : Ressource occupée

```sql

```

Test 3 : Ressource modifiée entretemps

```sql

```

Test 4 : Ressource supprimée entretemps

```sql

```

## Procédure SuppimerPatient

Écrire la procédure `SupprimerPatient` qui permet de supprimer tout ce qui concerne le patient à condition que ce
patient n'ait pas de médecin généraliste (spécialité `MEDECINE GENERALE`). On effacera également l'adresse du patient à
condition que plus personne n'habite à cette adresse (Patient ou médecin). Cette procédure reçoit comme paramètre un
numéro de SIS d'un patient. Le déclencher `PatientsDelNrSis` est activé et gère l'option `ON DELETE CASCADE`.

Construire un jeu de commandes permettant de tester cette procédure.

```sql

```

Test 1 : Suppression correcte

```sql

```

Test 2 : Pas de données trouvées

```sql

```

Test 3 : Numéro de sis null

```sql

```

Test 4 : Possède un médecin généraliste

```sql

```

## Fonction Rechercher

Écrire la fonction Rechercher qui permet de rechercher le signalétique du médecin qui soigne au moins un patient
habitant à Liège et au moins un patient habitant à Saint-Nicolas. Si la recherche donne plusieurs résultats, une
exception est lancée. La requête sera réalisée en utilisant un opérateur ensembliste.

Construire un jeu de commandes permettant de tester cette fonction.

```sql

```
