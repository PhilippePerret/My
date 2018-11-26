class My
  class << self

    # Pour afficher toutes les données mémorisées
    def display_all
      puts String::RC*2
      puts data.to_yaml
      puts String::RC*2
    end
    # /display_all

    # Tout détruire (option --kill_all)
    def destroy_all
      raise_if_no_file_data
      yesOrNo('Voulez-vous vraiment détruire l’intégralité des données ?') || return
      yesOrNo('Toutes les données mémorisées, TOUTES, seront détruites. Voulez-vous vraiment faire ça ?') || return
      yesOrNo('Confirmez une dernière fois la destruction en tapant "n" ("non")'.rouge) && return
      `rm "#{data_path}"`
    end

  end #/<< self
end #/My
