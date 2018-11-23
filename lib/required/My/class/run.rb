class My
  class << self

    # = main =
    #
    # Après l'initialisation de l'application, on joue la commande.
    #
    def run
      # puts "Commande : #{CLI.command.inspect}"
      # puts "Paramètres : #{CLI.params.inspect}"
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
      my.display_or_define
    end
    # /run
  end #/<< self
end #/My
