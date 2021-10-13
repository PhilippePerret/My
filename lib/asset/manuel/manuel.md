# MANUEL DE LA COMMANDE CLI My

# Description

La command CLI `my` permet de définir tout un tas de valeur pour les retrouver de façon très simple, par les deux syntaxes :

        $ my TRUC = "La valeur de mon TRUC."
        # => consigne la valeur de la chose 'TRUC'

Et pour récupérer la valeur (qui est mise aussi dans le presse-papier) :

        $ my TRUC
        # => Affiche "Truc : La valeur de mon TRUC."
        # => Met "La valeur de mon TRUC." dans le presse-papier.


## Définir un nouvel élément personnel (une *chose*)

Un nouvel élément personnel se crée avec le signe égal ou tout simplement en ajoutant son nom après la commande `my` et en jouant entrée.

        $ my chose[ENTRÉE]


Si `My` ne trouve pas "chose" dans ses données, elle demande à créer cette donnée. Il suffit alors de rentrer la valeur et de jouer la touche ENTRÉE.

On peut aussi définir la donnée avec l'opérateur `=` :


        $ my chose = "C'est ma première chose."


Ou même sans les guillemets, mais seulement s'il n'y a pas de guillemets ou en les escapant.


        $ my chose = C\'est ma première chose.


## Afficher une chose


        $ my <chose>


Par exemple, si la chose "travail" est définie :

        $ my travail


### Afficher les "enfants" d'une chose

Pour afficher les enfants, utiliser l'option `-c/--children`. Par exemple :

        $ my travail -c

        # ou

        $ my travail --children


Note : les enfants, ce sont par exemple les choses comme `travail du jour` ou `travail sur Icare`, etc.

## Détruire une chose personnelle

On l'utilise l'option `-k/-kill` pour supprimer un élément. Par exemple :

        $ my chose -k
        # => Détruit 'chose' après confirmation.

Ou :

        $ my work --kill

## Détruire toutes les données


        $ my --kill_all

Attention, cette commande détruit vraiment toutes, toutes, toutes les données, il ne restera plus rien. C'est la raison pour laquelle trois confirmations seront demandées.

### Retours chariot

Pour ajouter des retours chariot, il suffit d'écrire `\\n` (2 balances arrière, la balance arrière — \\ — s'obtient à l'aide de ALT MAJ / sur Mac).


## Ajouter ou supprimer des éléments dans une chose

On ajoute ou on supprime des lignes/éléments à une chose tout simplement avec les opération `+` et `-`. La chose doit être définie avant.

Par exemple :

        $ my work[ENTRÉE]
        $ "Ici mon premier travail"[ENTRÉE]

Ensuite :

        $ my work + Un nouveau travail à faire
        # => Ajoute le nouveau travail

Pour supprimer un élément, on utilise l'opérateur `-` (moins) en indiquant le début de l'élément à supprimer. Par exemple, si ma chose `work` possède 'Aller acheter du pain', il suffit de taper le code suivant pour le supprimer :

        $ my work - Aller acheter


Si deux éléments commencent par le même texte, c'est le premier qui sera éliminer. Pour éliminer seulement le second, allonger la description de la donnée à supprimer.


## Définition d'éléments complexes

On peut définir des éléments complexes qui pourraient se définir comme « ma date de naissance » ou « ma date de déménagement » grâce à un code ressemblant à :

        $ my <chose> <of:|as:> <sous chose> <as:> <type>

Note : pour ne pas confondre une clé avec une chose à plusieurs mots, il suffit de mettre la chose à plusieurs mots entre guillemets. Par exemple :


        $ my "instrument principal"
        # => La chose est "instrument principal"

… alors que :

        $ my intrument principal
        # => La chose est "instrument", "principal" est considéré comme une clé et
        #    génèrera une erreur.
