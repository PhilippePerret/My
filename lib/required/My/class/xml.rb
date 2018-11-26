=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
class My

  class << self

    def save_data
      xmldoc.write(output: File.open(data_path, 'wb'), indent: 2, transitive: true)
    end

    def xmldoc
      @xmldoc ||= REXML::Document.new(File.new(data_path))
    end

    def data_path
      @data_path ||= File.expand_path(File.join(Dir.home,'.my.xml'))
    end

  end #/<< self
end#/ My
