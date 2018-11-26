class My


  def human_what
    @human_what ||= whats.join(' ')
  end

  # Retourne la valeur sous forme de liste
  def as_list
    @as_list ||= get_value.split(DELIMITER_LINES)
  end

  def reset_and_display
    self.reset
    self.display
  end

  # Affichage de la donnée
  def display
    puts String::RC*2
    affichage_formated
    puts String::RC*2
    puts "(pour modifier cette valeur, utilisez l'option -m/--modifier)"
  end
  # /display

  def affichage_formated
    puts mef_lib_and_value.bleu
  end

  def mef_lib_and_value
    lib = human_what.capitalize
    full_lib = '     %s : ' % lib
    full_lib_len = full_lib.length
    return full_lib + formated_value(full_lib_len)
  end

  def formated_value(retraits)
    get_value.gsub(/\\n/, String::RC + ' '*retraits)
  end

end #/My
