# YUM vs DNF
Dandified Yum ou DNF est un gestionnaire de paquets. C’est le successeur de YUM . Pour les commandes les plus courantes, son usage est identique à celui de yum. Il est accessible via une interface en ligne de commande. 

DNF remplace le gestionnaire de paquets par défaut de Fedora Yum, qui est présent depuis Fedora Core 1 (septembre 2003).

Plusieurs éléments ont mené à la création de DNF. Yum était âgé et son évolution a laissé un code peu maintenable, écrit en Python 2, avec une API assez mal documentée. De surcroît son empreinte mémoire est importante et ses performances laissent à désirer. Partant de ce constat, Yum a été forké en janvier 2012, donnant naissance à DNF.

Les développeurs de DNF ont ainsi procédé à une réécriture et un nettoyage du code, abandonnant au passage certaines fonctionnalités et rendant l’outil compatible avec Python 3. Ils ont documenté l’API depuis le début du projet. 

# Bascis commands
```bash
# installe un paquet (et ses dépendances, si nécessaire).
dnf install nom_paquet 
# désinstalle un paquet (et gère les dépendances liées).
dnf remove nom_paquet 
# recherche les mises à jour des programmes installés.
dnf check-update 
# met à jour tous les programmes installés.
dnf update 
# met à jour l'ensemble de la distribution.
dnf upgrade 
# recherche un paquet ; exemple dnf search dvd cherche les paquets dont le nom ou la description contiennent le mot dvd.
dnf search nom_paquet 
# installe un groupe de paquets en passant son nom de groupe complet.
dnf group install "group name" 
# indique les paquets fournissant la dépendance ou fichier demandé.
dnf provides dependance 
```