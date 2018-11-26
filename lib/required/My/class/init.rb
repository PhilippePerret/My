class My
  class << self

    # Initialisation de l'application (en tout début, chaque fois que
    # la commande est jouée)
    def init
      # Analyse de la ligne de commande
      CLI.analyse_command_line
    end
    # /init


    def raise_if_no_file_data
      File.exist?(data_path) || raise('Aucun fichier de donnée n’existe pour le moment.')
    end

  end #/self
end #/My
