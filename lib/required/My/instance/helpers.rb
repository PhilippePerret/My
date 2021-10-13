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
  # + mise dans le clipboard
  def display
    puts String::RC*2
    affichage_formated
    puts String::RC*2
    cette_valeur = CLI.options[:children] ? 'une de ces valeurs' : 'cette valeur'
    puts '(pour modifier %s, utilisez l’option -m/--modifier)' % [cette_valeur]
    get_value && `echo "#{get_value.gsub(/\\n/, String::RC).strip}" | pbcopy`
  end
  # /display

  def affichage_formated
    mef = mef_lib_and_value
    unless mef.nil?
      puts mef.bleu
    end
    if CLI.options[:children] && children?
      node.elements['children'].each do |child_node|
        child = My.new(whats + [child_node.elements['name'].text])
        child.affichage_formated
      end
    end
  end

  def mef_lib_and_value
    lib = human_what.capitalize
    full_lib = '     %s : ' % lib
    full_lib_len = full_lib.length
    formated_value(full_lib_len) || (return nil)
    return full_lib + formated_value(full_lib_len)
  end

  def formated_value(nombre_espaces)
    @formated_value ||= begin
      headline = String::RC + ' ' * nombre_espaces
      if get_value
        get_value.gsub(/__RC__/, headline)
      end
    end
  end

end #/My
