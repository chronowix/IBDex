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