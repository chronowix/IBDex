# IBDex
Projet d'application mobile de vulgarisation autour des MICI

## Sommaire
1. Contexte
2. Architecture et technologies
3. Forme du site

## 1. Contexte
En France, le site de l'AFA Crohn répertorie des informations concernant les MICI,
mais ces informations peuvent être considérées comme complexes pour des personnes qui ne sont pas habituées
aux termes médicaux et aux explications données. Le but d'IBDex est de regrouper des informations,
conseils et lister des spécialistes autour des MICI. L'application se focalisera au début sur la région Bretagne
pour ensuite s'étendre sur toute la France au fur et à mesure des mises à jour.

## 2. Architecture et technologies
IBDex sera une application mobile cross platform (à déterminer les versions des OS minimales).
L'architecture est la suivante (N.B : les technologies pourront changer ou évoluer au fil de la conception) :
- Utilisation de Dart et Flutter pour une meilleure polyvalence sur le multiplateforme,
- BDD conséquente permettant de stocker un maximum de données ainsi que les données utilisateur (type MySQL ou Postgres),
- Utilisation de Bcrypt afin de chiffrer les mots de passe des utilisateurs lors de leur inscription,
- Utilisation d'APIs pour récupérer des informations et conseils concernant les MICI en particulier celle de Wikipédia
afin de récupérer les articles sur les maladies, traitements et de les adapter au grand public (articles Wikipédia par exemple).

L'application sera structurée de la manière suivante :
- Menu burger inclus sur toute l'application avec dedans les rubriques suivantes :
  - Ma Santé, avec les informations médicales liées aux personnes ayant créé un compte,
  - Support, qui permet d'avoir accès à des numéros d'urgence (SAMU, numéro de votre gastro-entérologue...) et formulaire de contact,
  - Mon Profil, afin de modifier les informations personnelles,
  - Paramètres, pour modifier les options système (thème, accessibilité...), 
  - À Propos, pour comprendre l'origine de ce projet ;)
- Authentification avec plusieurs façons (identifiants classiques, SSO...),
- Home page avec navigation entre les onglets Accueil, Articles, Wiki, Conseils, Nutrition et Carte
- Sur l'onglet Accueil :
  - Un fil d'actualité avec tous les nouveaux posts, quand on clique sur un des posts, on est redirigé vers l'onglet spécifié au post.
- Sur l'onglet Articles :
  - Des posts parlant des nouvelles liées aux MICI, traitements et autres maladies corrélées, il sera possible de liker les posts et de les retrouver sur sa partie Profil,
- Sur l'onglet Wiki:
  - En utilisant l'API de Wikipédia, l'application va récupérer les pages liées aux MICI, traitements et autres maladies corrélées. 
  Après les avoir récupérés, les pages seront modifiées afin vulgariser l'explication des termes médicaux.
- Sur l'onglet Conseils :
  - Une page avec plusieurs conseils pouvant provenir de sources médicales ou provenant de ma propre expérience (après 10 ans de MICI, tu deviens une encyclopédie :p)
- Sur l'onglet Nutrition : 
  - Informations sur les aliments/boissons susceptibles de déclencher une crise ou qui peuvent avoir un impact positif sur la digestion + infos sur les nutriments.
- Sur l'onglet Carte :
  - Affiche sur une carte (API OpenStreetMap) la liste des centres/médecins spécialistes en gastro-entérologie/hépatologie (La carte affichera juste la métropole de Rennes pour commencer).

Tous ces éléments seront dans le MVP, des mises à jour ajouteront des features afin d'optimiser et de rendre l'application plus intéressante :
- [ ] Mise en place d'un forum pour communiquer entre les utilisateurs (anonyme ou non),
- [ ] Agrandissement de la zone de recherche des centres/médecins (Ille-et-Vilaine -> région Bretagne -> France métropolitaine),
- [ ] Mettre en place une rubrique Evènements/Conférences autour des MICI.