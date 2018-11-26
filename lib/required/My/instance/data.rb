=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  DELIMITER_LINES = '\n'

  # Quand la donnée est demandée (donc sans '=') et qu'elle n'existe pas,
  # il faut la définir. C'est par ici qu'on passe pour le faire de façon
  # dynamique.
  def define

    # On demande s'il faut vraiment définir cette donnée
    # TODO Il faudrait être plus précis ici et dire jusqu'à quelle clé on
    # connait le what.
    if !CLI.options[:modifier] # && new_value.nil?
      yesOrNo('Je ne connais pas la donnée %s. Voulez-vous la définir ?' % human_what.inspect) || return
    end

    new_value ||= askFor('Donnée à mémoriser pour « %s »' % human_what)

    new_value != nil || raise('On ne peut pas enregistrer une valeur vide.')
    if yesOrNo('Je dois donc donner la valeur %s à %s ?' % [new_value.inspect, human_what.inspect])
      set(new_value)
      puts ('Valeur "%s" enregistrée avec succès.' % new_value).bleu
      display
    end
  end


  # def define new_value = nil
  #
  #
  # end
  # # /define

  # On doit donner une nouvelle valeur au whats courant.
  # +new_value+ est toujours un string, mais il sera toujours mis dans
  # un {value: <new value>}
  def set new_value
    cur_value  = get # cela crée les clés au besoin
    cur_value.merge!(value: new_value)
    CLI.dbg('---- [set] Donnée finale : %s' % thing_value.inspect, __FILE__, __LINE__)
    # My.set(what, thing_value)
    My.set(whats, {value: new_value})
  end

  # Retourne le hash qui contient la valeur actuelle de la cible.
  # Rappel : la valeur est toujours dans un {value: "<valeur string>"}
  #
  # Si la clé n'existe pas, on le signale ? mais on crée la donnée qui
  # contiendra cette clé. Sauf si create_if_unknown est false (true par défaut
  # dans lequel cas on retourne nil — pour le test de l'existence de la
  # donnée par exemple)
  #
  def get create_if_unknown = true
    cur_value = thing_value
    whats.each do |key|
      cur_value.key?(key) || begin
        if create_if_unknown
          cur_value.merge!(key => Hash.new)
        else
          return nil
        end
      end
      cur_value = cur_value[key]
    end
    # Quelle que soit la valeur, c'est toujours un hash qui est retourné
    CLI.dbg('-- [get] cur_value : %s' % cur_value.inspect, __FILE__, __LINE__)
    return cur_value
  end

  # Retourne la valeur de la chose iniitiale sous forme de Hash
  # C'est le Hash qui correspond à la première clé de whats
  #
  # Attention, cette valeur doit retourner NIL lorsque la chose n'existe
  # pas, car c'est cette méthode qui sert pour exist?
  def thing_value
    @thing_value ||= My.get(what) || Hash.new
  end

  # Retourne la valeur sous forme de liste
  def as_list
    @as_list ||= get.split(DELIMITER_LINES)
  end

end #/My
