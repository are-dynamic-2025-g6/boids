---
layout: page
title: Choix
---

<h1>Choix réalisés:</h1>
Nos choix se sous-sectionnent en trois grandes catégories: le graphisme, notre moteur, et enn les paramètres utilisés.

<h2>Les graphismes:</h2>
En termes de graphisme, notre projet devait rester simple. Un arrière-plan uniforme, et des formes géométriques basiques pour la représentation des agents. La raison est simple: maximiser les performances de notre simulation. Grâce à notre moteur de jeu, inclure des animations, ou des sprites plus détaillés, aurait été simple, mais cela aurait aussi diminué la uidité de notre simulation (lors de simulation avec un grand
nombre d’agents). Nous recherchons le réalisme, certes, mais pas dans l’apparence de notre projet. Notre priorité principale est le réalisme des comportements achés par les oiseaux.

<h2>Godot:</h2>
Godot est l’engin de jeu que nous avons utilisé pour la conception de notre simulation. Les raisons sont claires, il nous a permis une plus grande facilité d’implémentation, et nous autorise aussi à un plus grand degré de liberté (par rapport à nos capacités de programation). Bien qu’une multitude d’engins existent, Godot était le choix évident. Il est conçu pour être simple d’utilisation et adapté aux débutants; son langage de programmation principale, GDScript, est syntaxiquement très similaire à Python; et énalement certains membres de notre groupe étaient déjà familiers avec cet outil. Godot nous a permis d’utiliser une scène 2D native pour structurer nos oiseaux comme des objets indépendants; il nous a aussi permis la visualisation en directe des modications de nos paramètres. Godot aurait aussi amplement facilité notre tâche si nous avions
souhaité incorporer une des extensions dont nous parlons dans la conclusion.

<h2>Nos paramètres:</h2>
L’obtention des paramètres (c'est-à-dire la taille des cercles de visions, et celle du corps) est faite de manière purement empirique. Pour obtenir des résultats cohérents, nous avons fait varier les paramètres successivement tout en observant les oiseaux et leurs interactions. Ce processus a été répété jusqu'à ce qu’on ait trouvé des paramètres satisfaisant le niveau de réalisme que nous souhaitions atteindre. Nos paramètres sont donc dicilement explicable, n’émanant pas d’une formule mathématique précise, mais d’une
succession d'essais et d'erreurs. Nous allons tout de même essayer d’expliquer et diérencier les résultats que nous avons obtenus lorsque que l’on modie drastiquement nos paramètres dans la prochaine section.
