---
layout: page
title: Conclusion
---
<h2>Nos résultats:</h2>
Nous pouvons armer que nous avons conçu une simulation réaliste d’une nuée d'oiseaux. Notre analyse permet de conrmer que notre programme mathématiquement converge vers des résultats naturels, et nous-même, en observant notre programme en tant que groupe, avons décrété que notre système répond aux attentes que nous avions pour lui au début de ce projet. Nous avons bien vu que grâce à nos 3 paramètres il nous est possible de nous rapprocher de la réalité et d’arriver à une convergence du système, tant que nos paramètres sont bien choisis. Cet algorithme permet donc une modélisation dynamique réaliste d’une nuée d’oiseaux, tout en utilisant un nombre de paramètres nis.

<h2>Réalisme:</h2>
Dans notre projet le réalisme se manifeste sous deux formes principales: L’implémentation de facteurs que l’on retrouve naturellement dans les une nuée d’oiseaux, et la modication des paramètres visant à augmenter le réalisme des interactions entre agents. Dans le cadre de ce projet, une extension logique aurait été d’inclure d’autre comportement typique des oiseaux:
Une mécanique d'atterrissage au sol après un certain temps de vol, ainsi qu’une mécanique de communication entre les oiseaux de sorte à ce qu’il reprennent leur vol de façon relativement simultanée.
L’ajout d’un prédateur qui pourrait avoir ses mouvements contrôlés par l’utilisateur du programme, ou l’ajout d’obstacles que les oiseaux auraient à éviter.
L’intégration de vents qui viendrait soit aider les oiseaux à rester en vol, ou qui les déstabiliseraient et potentiellement sépareraient les groupes.
La mise en place d’un système reproduisant la loi de Lotka-Volterra sur les variations d’une population en fonction du nombre de prédateurs et de proies (permettrait d’étudier l’intérêt évolutif des formations adoptées par les oiseaux).
Notre projet, bien que convenable, aurait donc pu incorporer une multitude d’éléments venant améliorer le réalisme de notre simulation.

<h2>Optimisation:</h2>
Notre programme, bien que fonctionnel, est loin d’être le plus optimal possible. Actuellement notre projet effectue une conséquente quantité de comparaison toutes les frames. Pour remédier à cela, on pourrait implémenter une structure de données visant à optimiser la recherche spatiale. Dans notre contexte, l'implémentation d’une grille uniforme ou d’un quad-tree aurait grandement réduit le nombre de comparaison devant être eectués, et aurait donc augmenté l’ecacité de notre programme.
