=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  attr_reader :what
  def initialize what
    @what = what.downcase
  end

  def reset
    @value    = nil
    @as_list  = nil
  end

  # = main =
  #
  # méthode principale quand l'élément est demandé. S'il est défini, on
  # l'affiche, sinon, on demande à le définir.
  #
  def display_or_define
    if exist? && !CLI.options[:modifier]
      display
    else
      define
    end
    # puts "---- data : #{self.class.data.inspect}"
  end
  # /display_or_define

  def exist?
    value != nil
  end

  def value
    @value ||= My.get(what)
  end

end #/My
