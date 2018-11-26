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

      what = Array.new

      case CLI.command
      when 'help'
        puts "Bientôt ici : l'affichage du manuel."
        return
      when 'all', 'tous'
        display_all
        return
      else
        # Sinon, on cherche si la commande comme l'élément à obtenir.
        # Par exemple `my adresse` doit retourner l'adresse personnelle.
        whats = [CLI.command]
      end

      # Les options qui interrompent tout
      case
      when CLI.options[:kill_all]
        My.destroy_all
        return
      when CLI.options[:help] || CLI.command.nil?
        puts "Affichage du manuel"
        return
      end

      # Pour trouver le what, maintenant que la donnée peut être complexe,
      # donc, en profondeur, il faut prendre les paramètres jusqu'à trouver
      # un opérateur ou la fin.
      iparam = 1
      until !CLI.params[iparam] || ['-', '+', '='].include?(CLI.params[iparam])
        whats << CLI.params[iparam]
        iparam += 1
      end
      CLI.dbg("--- [CLI] whats dans ligne commande : #{whats.inspect} (#{CLI.params.inspect})", __FILE__, __LINE__)

      if CLI.params[iparam]
        operateur = CLI.params[iparam]
        iparam += 1
      end
      CLI.dbg('--- [CLI] operateur : %s ' % operateur, __FILE__, __LINE__)

      if CLI.params[iparam]
        full_value = CLI.params[iparam..-1].join(' ')
      end
      CLI.dbg('--- [CLI] full value : %s' % full_value, __FILE__, __LINE__)

      # Instanciation de la chose à partir de son +whats+ c'est-à-dire
      # son XPath sous forme d'array.
      my = new(whats)


      if CLI.options[:kill]
        my.ask_for_destroy
      else
        case operateur
        when '='
          # => Définition d'une nouvelle chose
          my.set(full_value)
        when '+'
          # Ajout d'une ligne à une chose
          my.add(full_value)
        when '-'
          # Retrait d'une ligne à une chose
          my.sup(full_value)
        else
          # Dans tous les autres cas, c'est soit un affichage (si la chose
          # existe) soit une demande de création (si la chose n'existe pas)
          my.display_or_define
        end
      end
    end
    # /run
  end #/<< self
end #/My
