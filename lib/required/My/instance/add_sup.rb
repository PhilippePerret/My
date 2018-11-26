class My

  # Ajouter l'élément +that+
  def add that
    raise_if_not_exists('Il faut le définir avant d’y ajouter des éléments.')
    set(get + '\n' + that)
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
  # TODO Il faut traiter le cas d'une sous-valeur car ici ça détruit toute
  # la donnée
  def ask_for_destroy
    raise_if_not_exists('Impossible de le détruire.')
    yesOrNo('Voulez-vous vraiment détruire %s' % what.inspect) || return
    My.destroy(self)
  end
  # /ask_for_destroy

end #/My
