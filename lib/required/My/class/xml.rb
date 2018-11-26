=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
require "rexml/document"
class My

  class << self

    def save
      xmldoc.root.attributes['Updated_at'] = Time.now
      xmldoc.write(output: file_data_ref, indent: 2, transitive: true)
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
      
      xdoc.write(output: file_data_ref, indent: 2, transitive: true)
      return xdoc
    end
    # /build_my_xml

    def file_data_ref
      @file_data_ref ||= File.open(data_path, 'wb')
    end
    def data_path
      @data_path ||= File.expand_path(File.join(Dir.home,'.my.xml'))
    end

  end #/<< self
end#/ My
