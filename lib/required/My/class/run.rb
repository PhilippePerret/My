class My
  class << self

    # = main =
    #
    # Après l'initialisation de l'application, on joue la commande.
    #
    def run

      # # Juste pour voir ce qui rentre
      # puts "Commande : #{CLI.command.inspect}"
      # puts "Paramètres : #{CLI.params.inspect}"
      # return

      param1 = CLI.params[1] # peut être '+' ou '-' par exemple

      case CLI.command
      when nil, 'help'
        puts "Bientôt ici : l'affichage de l'aide."
        return
      when 'all', 'tous'
        display_all
        return
      when 'code'
        # C'est un code à obtenir
        what = 'code_%s' % CLI.params[1]
      else
        # Sinon, on cherche si la commande comme l'élément à obtenir.
        # Par exemple `my iban` doit retourner l'IBAN.
        what = CLI.command
      end
      my = new(what)
      if CLI.options[:kill]
        my.ask_for_destroy
      else
        case param1
        when '='
          # => Définition d'une nouvelle chose
          my.define(CLI.params[2..-1].join(' '))
        when '+', '-'
          # On doit ajouter ou retirer quelque chose à what. Par exemple
          # 'my work + Un nouveau travail' ajoute 'Un nouveau travail' à work
          methode = param1 == '+' ? :add : :sup
          ajout_or_retrait = CLI.params[2..-1].join(' ')
          my.send(methode, ajout_or_retrait)
        else
          my.display_or_define
        end
      end
    end
    # /run
  end #/<< self
end #/My
