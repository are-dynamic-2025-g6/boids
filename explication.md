---
layout: page
title: Explication
---

<h3>Généralités:</h3>
L’algorithme de boids est utilisé majoritairement en représentation graphique. Il permet de réaliser une simulation réaliste d’une nuée d'oiseaux ainsi que d'autres créatures se déplaçant en groupe, tel que: un banc de poisson, ou un essaim d'insectes.
De par la simplicité de son implémentation (que nous allons prochainement discuter) il fait office du choix standard dès qu’il s’agit de représenter ce type de comportements. 

<h3>Les trois règles fondamentales:</h3>
L’aspect impressionnant de l’algorithme de boids est qu’il repose uniquement sur trois lois relativement basiques et facilement programmables. Il serait même juste de dire que toute la complexité d’obtention d’une simulation réaliste, et de la cohésion entre les trois lois, vient du réglage des paramètres utilisés.

Avant de comprendre comment ces lois fonctionnent, il est judicieux d'expliquer comment les entités que nous allons manipuler (les oiseaux) fonctionnent. Dans notre code, chaque oiseau est représenté par un vecteur. Toutes les frames, l’oiseau se déplace via ce vecteur, sa position est donc mise à jour en fonction des composantes de ce vecteur. Ainsi, ce que l’on va constamment manipuler pour simuler des mouvements, c’est les vecteurs associés a chaque oiseau. Finalement, notre oiseau possède aussi trois champs différents, représentés par des cercles de rayon variant sur la Figure 1. Chaque cercle va permettre d’appliquer une loi spécifique, (notez que ces cercles sont modulables, ils font partie des paramètres influençant notre simulation, dont nous parlerons plus tard).					
Ce point étant clarifié, voici les règles: 

<h4>Séparation:</h4>
Chaque individu s'éloigne de ceux qui sont trop proches.
Quand un ou plusieurs individus sont détécté à l’interieur de la zone représentant le corps de l’oiseau (le cercle blanc - Figure 1), le vecteur de direction de  l’oiseau est modifié de manière a s’eloigner de ceux ci.	

<h4>Alignement:</h4>					
Chaque individu aligne sa direction sur celle des individus aux alentours.
Quand un ou plusieurs individus entrent dans la zone de vision de l’oiseau (le cercle gris foncé - Figure 1), le vecteur de direction de l’individu va être aligné pour qu’il suive une direction relativement similaire à celle du groupe dans le cercle.

<h4>Cohésion:</h4>
Chaque individu se rapproche des individus trop éloignés à sa portée.
Quand un ou plusieurs individus entrent dans la deuxième zone de vision (le cercle gris clair - Figure 1), le vecteur de direction de l’individu va être modifié pour qu’il se rapproche des autres individus dans cette zone.

<h3>Simultanéités des lois: </h3>
Ces trois lois, quand elles sont activées simultanément, se marchent l’une sur l’autre : 
Simulons l'application des trois lois à un individu. La première a changé son vecteur direction, la deuxième va aussi le changer  et la troisième, idem. Les modifications étant successives pour éviter d’avoir un vecteur dû uniquement à la dernière loi appelée, on utilise la relation de Chasles, grâce à laquelle on obtient un vecteur combinant les trois lois. 

<h3>Le rôle des paramètres:</h3>
Comme précédemment mentionné, chaque zone sûre la Figure 1 possède une taille qui est modifiable directement dans le code ainsi que interactivement sur la fenêtre notre projet. Chaque taille est donc un paramètre influençant le rendu final et le réalisme de notre représentation. Comme susmentionné, l’un des aspects les plus complexes de notre projet est l’harmonisation de ces paramètres. Pour atteindre une simulation réaliste, on a empiriquement affiné nos paramètres jusqu'à ce qu’a l’obtention d’un rendu satisfaisant, sans oublier qu'une légère fluctuation dans l’un des paramètres nécessite le réajustement des deux autres.
Nous discuterons plus tard dans la section “Choix réalisés” la provenance des valeurs que nous avons décidé d’attribuer à nos paramètres et donc à nos tailles de cercles.
