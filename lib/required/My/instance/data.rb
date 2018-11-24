=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  DELIMITER_LINES = '\n'

  def define new_value = nil
    if !CLI.options[:modifier] && new_value.nil?
      yesOrNo('Je ne connais pas la donnée %s. Voulez-vous la définir ?' % what.inspect) || return
    end

    # Ici, il faut voir si c'est une donnée complexe, en consultant les
    # autres paramètres.
    

    new_value ||= askFor('Donnée à enregistrer pour « %s »' % human_what)
    new_value != nil || raise('On ne peut pas enregistrer une valeur vide.')
    if yesOrNo('Je dois donc donner la valeur %s à %s ?' % [new_value.inspect, human_what.inspect])
      set(new_value)
      puts "Valeur enregistrée avec succès.".bleu
    end
  end
  # /define

  def set new_value
    My.set(what, new_value)
  end

  # Retourne la valeur sous forme de liste
  def as_list
    @as_list ||= value.split(DELIMITER_LINES)
  end

end #/My
