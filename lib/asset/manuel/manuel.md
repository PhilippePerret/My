# Commande My

## Définir un nouvel élément personnel

Un nouvel élément personnel se crée tout simplement en ajoutant son nom après la commande `my` et en jouant entrée.

```bash
> my chose[ENTRÉE]
```

Si `My` ne trouve pas "chose" dans ses données, elle demande à créer cette donnée. Il suffit alors de rentrer la valeur et de jouer la touche ENTRÉE.

On peut aussi définir la donnée avec l'opérateur `=` :

```bash
> my chose = "C'est ma première chose."
```

Ou même sans les guillemets, mais seulement s'il n'y a pas de guillemets ou en les escapant.

```bash
> my chose = C\'est ma première chose.
```


## Détruire une chose personnelle

On l'utilise l'option `-k/-kill` pour supprimer un élément. Par exemple :

```bash
my chose -k
# Détruit 'chose' après confirmation.
```

Ou :

```bash
my work --kill
```

## Détruire toutes les données

```bash
> my --kill_all
```

Attention, cette commande détruit vraiment toutes, toutes, toutes les données, il ne restera plus rien. C'est la raison pour laquelle trois confirmations seront demandées.

### Retours chariot

Pour ajouter des retours chariot, il suffit d'écrire `\n` (la balance arrière — \\ — s'obtient à l'aide de ALT MAJ / sur Mac).


## Ajouter ou supprimer des éléments dans une chose

On ajoute ou on supprime des lignes/éléments à une chose tout simplement avec les opération `+` et `-`. La chose doit être définie avant.

Par exemple :

```bash
> my work[ENTRÉE]
> "Ici mon premier travail"[ENTRÉE]
```

Ensuite :

```bash
> my work + Un nouveau travail à faire
# => Ajoute le nouveau travail
```

Pour supprimer un élément, on utilise l'opérateur `-` (moins) en indiquant le début de l'élément à supprimer. Par exemple, si ma chose `work` possède 'Aller acheter du pain', il suffit de taper le code suivant pour le supprimer :

```bash
> my work - Aller acheter
```


Si deux éléments commencent par le même texte, c'est le premier qui sera éliminer. Pour éliminer seulement le second, allonger la description de la donnée à supprimer.


## Définition d'éléments complexes

On peut définir des éléments complexes qui pourraient se définir comme « ma date de naissance » ou « ma date de déménagement » grâce à un code ressemblant à :

```bash

> my <chose> <of:|as:> <sous chose> <as:> <type>

```

Note : pour ne pas confondre une clé avec une chose à plusieurs mots, il suffit de mettre la chose à plusieurs mots entre guillemets. Par exemple :

```bash

> my "instrument principal"
# => La chose est "instrument principal"
```

… alors que :

```bash

> my intrument principal
# => La chose est "instrument", "principal" est considéré comme une clé et
#    génèrera une erreur.

```
