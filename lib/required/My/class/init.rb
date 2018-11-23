class My
  class << self

    # Initialisation de l'application (en tout début, chaque fois que
    # la commande est jouée)
    def init
      # Analyse de la ligne de commande
      CLI.analyse_command_line
    end
    # /init

  end #/self
end #/My
