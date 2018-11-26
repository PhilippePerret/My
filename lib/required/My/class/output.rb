require 'kramdown'
class My
  class << self

    # Pour afficher toutes les données mémorisées
    def display_all
      puts String::RC*2
      CLI.options.merge!(children: true) # pour afficher les enfants
      xmldoc.root.elements['choses'].elements['children'].each do |chose|
        puts String::RC*2
        name = chose.elements['name'].text
        imy = new([name])
        imy.affichage_formated
      end
      puts String::RC*2
    end
    # /display_all

    # Affichage du manuel
    def display_manuel
      manuel_uptodate? || rebuild_manuel
      `open "#{manuel_html_path}"`
    end


  end #/<< self
end #/My
