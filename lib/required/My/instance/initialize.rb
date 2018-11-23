=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  attr_reader :what
  def initialize what
    @what = what.downcase
  end

  # = main =
  #
  # méthode principale quand l'élément est demandé. S'il est défini, on
  # l'affiche, sinon, on demande à le définir.
  #
  def display_or_define
    if exist? && !CLI.options[:modifier]
      puts String::RC*2 + ('     %s : %s' % [human_what.capitalize, value]).bleu + String::RC*2
      puts "(pour modifier cette valeur, utilisez l'option -m/--modifier)"
    else
      unless CLI.options[:modifier]
        yesOrNo('Je ne connais pas cette donnée. Voulez-vous la définir ?') || return
      end
      value = askFor('Donnée à enregistrer pour « %s »' % human_what)
      value != nil || raise('On ne peut pas enregistrer une valeur vide.')
      if yesOrNo('Je dois donc donner la valeur %s à %s ?' % [value.inspect, human_what.inspect])
        My.set(what, value)
        puts "Valeur enregistrée avec succès.".bleu
      end
    end
    # puts "---- data : #{self.class.data.inspect}"
  end

  def exist?
    value != nil
  end

  def value
    @value ||= self.class.data[what]
  end

end #/My
