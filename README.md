# My

CLI application to remember our things.

## To build de `my` command

* Start your Mac,
* clone this folder,
* run the ./bin/build_command.rb's file.

## Help

```bash

> my

# OR

> my help

# OR

> my -h

```

## Utilisation

Examples :

```bash

> my IBAN
# => Display our IBAN code (or ask to remember it)
# => copy it in the clipboard

```


```bash

> my code Facebook
# => Display Facebook code (or ask to remember it)

> my pseudo Facebook
# => Display Facebook pseudo (or ask to remember it)

```

## To modify a thing

```bash

> my Thing = "New value"

# OR

> my Thing -m
# => As to change it

```


## Remember a thing with return(s)

Use `\\n` (2 returns).

For example:

```bash

> my address
...
> My street\\nMy building\\nMy zipcode My Town

```

## To see all things

```bash

> my all

```

## To add as a list

```bash

> my liste = "First thing"

> my liste + "Second thing"
> my liste + "Third thing"
> my liste
# =>
#    liste : First thing
#            Second thing
#            Third thing

```


## Tout détruire

```bash

> my --kill-all

```
