class My

  # Ajouter l'élément +that+
  def add that
    raise_if_not_exists('Il faut le définir avant d’y ajouter des éléments.')
    set(get_value + '\n' + that)
    reset_and_display
  end

  # Retirer l'élément qui commence par +that+
  def sup that
    raise_if_not_exists('Impossible d’en retirer des éléments.')
    found = false
    new_list = self.as_list.collect do |item|
      if item.start_with?(that)
        found = item
        nil
      else
        item
      end
    end.compact

    if found
      if yesOrNo('Dois-je supprimer l’élément %s ?' % found.inspect)
        set new_list.join('\n')
        reset_and_display
      end
    else
      puts ('Impossible de trouver un élément qui commence par %s.' % that.inspect).rouge
    end
  end
  # /sup

  # Méthode appelée pour détruire la donnée
  #
  # Mais comme ça peut détruire beaucoup de choses en cascade, il faut
  # faire une vérification et demander confirmation lorsque des sous-éléments
  # seront détruits
  #
  def ask_for_destroy
    raise_if_not_exists('Impossible de le détruire.')
    confirm_if_cascade || return
    My.destroy(self)
  end
  # /ask_for_destroy

  # Méthode appelée quand on veut détruire le nœud courant.
  def confirm_if_cascade
    if node.elements['children'].nil?
      yesOrNo('Voulez-vous vraiment détruire %s' % human_what.inspect)
    else
      nombre_enfants = node.elements['children'].elements['chose'].count
      msg = ['Cette chose contient %i sous-choses qui seront détruites si vous détruisez celle-ci.' % nombre_enfants]
      msg << ASK_TABULATION+'Pour voir ses enfants, ajoutez l’option `-c`.'
      msg << ASK_TABULATION+'Voulez-vous vraiment procéder à cette destruction ?'
      yesOrNo(msg.join(String::RC))
    end
  end

end #/My
