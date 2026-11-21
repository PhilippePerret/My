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
    get_value && IO.popen('pbcopy', 'w') { |io| io.write(get_value.gsub(/__RC__/, "\n").strip) }
  end
  # /display

  # Affiche la donnée puis attend l'action suivante
  def display_and_wait
    display
    wait_for_action
  end

  def wait_for_action
    case getc('m = modifier la donnée / a = autre donnée / q = finir', expected_keys: ['m','a','q'])
    when 'm'
      modify
    when 'a'
      My.choose_from_list
    end
  end

  # Demande une nouvelle valeur pour la donnée
  def modify
    new_name = askFor('Nouveau nom', whats.last)
    rename(new_name.downcase) if new_name != whats.last
    current = get_value.to_s.gsub(/__RC__/, '\\n')
    new_value = askFor('Nouvelle valeur pour « %s »' % human_what, current)
    current_desc = description
    new_desc = askFor('Nouvelle description pour « %s »' % human_what, current_desc)
    save_description(new_desc) if new_desc != current_desc
    new_value != current ? set(new_value) : display
    wait_for_action
  end

  # Change le nom (dernier mot) de la donnée
  def rename(new_name)
    node(false).elements['name'].text = new_name
    My.save
    @whats = whats[0..-2] + [new_name]
    @what  = whats.first
    @human_what = nil
  end

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
