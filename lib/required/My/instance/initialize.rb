=begin

  Instance My.
  Un 'my', c'est une information personnelle

=end

class My

  # Désignateur de la chose. +what+ est le premier élément. Par exemple,
  # si on tape `my work`, what est `work`. C'est la chose.
  # Quand on désigne la chose de façon plus précise on ajoute des
  # éléments, ils sont consignés dans le +whats+. Par exemple, si on tape
  # `my work of day`, whats vaudra ['work', 'of', 'day'].
  # En interne, la donnée sera conservée dans :
  #   <my Created_at="..." Updated_at="...now...">
  #     <choses>
  #       <children>
  #         <chose Name="work">
  #           <children>
  #             <chose Name="of">
  #               <children>
  #                 <chose Name="day" Updated_at="...now...">
  #                   <value>"La valeur donnée ou à donner"</value>
  #                 </chose>
  #               </children>
  #             </chose>
  #           ...
  #   }}}
  attr_reader :what
  attr_reader :whats

  def initialize whats
    @whats  = whats
    @what   =  whats.first
    @what || raise('Impossible que @what soit nil…')
  end

  def reset
    @node     = nil
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
  end
  # /display_or_define

  # Note : thing_value retourne toujours une valeur, mais c'est un Hash
  # vide si la donnée n'existe pas.
  def exist?
    !get(create_if_unknown = false).nil?
  end

end #/My
