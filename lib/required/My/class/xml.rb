=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
require "rexml/document"
class My

  class << self

    def save
      xmldoc.root.attributes['Updated_at'] = Time.now
      write_xml(xmldoc)
    end

    # Écrit le document dans un fichier temporaire puis le renomme, pour
    # ne jamais laisser un fichier vide ou partiel.
    def write_xml(doc)
      out = +''
      doc.write(output: out, indent: 2, transitive: true)
      tmp = data_path + '.tmp'
      File.write(tmp, out)
      File.rename(tmp, data_path)
    end

    def xmldoc
      @xmldoc ||= begin
        if File.exist?(data_path)
          REXML::Document.new(File.new(data_path))
        else
          build_my_xml
        end
      end
    end

    # Méthode pour construire la base du fichier .my.xml qui va contenir
    # toutes les données
    def build_my_xml
      CLI.dbg("---> build_my_xml (création du document XML nécessaire)", __FILE__, __LINE__)
      xdoc = REXML::Document.new
      xdoc << REXML::XMLDecl.new
      xdoc.add_element('my')
      racine = xdoc.root
      racine.attributes['Created_at'] = Time.now
      racine.attributes['Updated_at'] = Time.now
      racine.add_element('choses')
      racine.elements['choses'].add_element('children')

      # # Pour pouvoir essayer tout de suite une valeur
      # chose = racine.elements['choses'].elements['children'].add_element('chose')
      # chose.add_element('name').text = 'travail'
      # chose.add_element('value').text = 'Sa bonne valeur dans le fichier.\nSeconde ligne de valeur.'
      # chose.add_element('updated_at').text = Time.now.to_i.to_s
      # puts xdoc.to_s
      
      write_xml(xdoc)
      return xdoc
    end
    # /build_my_xml

    def data_path
      @data_path ||= File.expand_path(File.join(Dir.home,'.my.xml'))
    end

  end #/<< self
end#/ My
