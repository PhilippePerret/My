=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
class My

  class << self

    # Détruit la chose +my+, c'est-à-dire le nœud dans la racine
    # Note : une confirmation a été demandée, dans l'instance, quand beaucoup
    # de choses vont être détruites par cascade
    def destroy my
      # raise 'La destruction du nœud n’est pas encore implémentée'
      my.node.parent.delete(my.node)
      save
      puts "#{my.human_what.inspect} a été détruit avec succès.".bleu
    end

  end #/<< self
end#/ My
