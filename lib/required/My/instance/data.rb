=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  DELIMITER_LINES = '\n'

  ##
  # Quand la donnée est demandée (donc sans '=') et qu'elle n'existe pas,
  # il faut la définir. C'est par ici qu'on passe pour le faire de façon
  # dynamique.
  def define

    # On demande s'il faut vraiment définir cette donnée
    # TODO Il faudrait être plus précis ici et dire jusqu'à quelle clé on
    # connait le whats.
    if !CLI.options[:modifier] # && new_value.nil?
      yesOrNo('Je ne connais pas la donnée %s. Voulez-vous la définir ?' % human_what.inspect) || return
    end

    new_value ||= askFor('Donnée à mémoriser pour « %s »' % human_what)

    new_value != nil || raise('On ne peut pas enregistrer une valeur vide.')
    set(new_value)
    puts ('Valeur "%s" enregistrée avec succès.' % new_value).bleu
    display
  end


  ##
  # On doit donner une nouvelle valeur au whats courant.
  # +new_value+ est toujours un string, mais il sera toujours mis dans
  # un {value: <new value>}
  def set new_value
    # puts "new_value avant = #{new_value.inspect}"
    new_value = new_value.gsub(/\\n/,'__RC__')
    # puts "new_value après = #{new_value.inspect}"
    mynode = node(true)
    mynode.elements['value'].text = new_value
    mynode.elements['updated_at'].text = Time.now.to_i.to_s
    My.save
    display
  end

  # Retourne la valeur de la chose courante, ou nil si elle n'existe pas
  def get_value
    node(false) || (return nil)
    # Attention, l'élément peut exister, mais sans valeur (lorsque c'est le
    # premier what d'une autre chose)
    node(false).elements['value'].text || (return nil)
    v = node(false).elements['value'].text.strip
    v.empty? ? nil : v
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
    node(create_if_unknown)
  end

  # Retourne le nœud courant
  def node create_if_unknown = true
    @node ||= begin
      xmlpath = Array.new(1, '/my/choses')
      this_node = nil
      node = My.xmldoc.root.elements['choses']
      whats.each do |key|
        this_node = nil

        # Soit le nœud a des enfants, soit il n'en a pas
        children = node.elements['children']
        if children.nil?
          if create_if_unknown
            # => On doit créer le noeud
            #    On passe par ici quand la dernière chose n'a pas d'enfants
            # puts "Je dois créer les enfants du noeud courant"
            children = node.add_element('children')
          else
            # => On ne trouve pas l'élément
            return nil
          end
        end
        children.each do |chose|
          if chose.elements['name'].text == key
            this_node = chose
            break
          end
        end
        if this_node.nil?
          # <= Le nœud n'a pas été trouvé
          # => Si on doit le créer, on le crée. Sinon, on retourne null.
          if create_if_unknown
            # puts "Je dois créer le noeud manquant (#{key})"
            node = children.add_element('chose')
            node.add_element('name').text = key
            node.add_element('updated_at').text = Time.now.to_i.to_s
            node.add_element('value').text = ''
            this_node = node
          else
            return nil
          end
        else
          node = this_node
        end
      end
      # Si on passe ici, c'est qu'on n'a rien trouvé
      this_node
    end
  end
  # /node



end #/My
