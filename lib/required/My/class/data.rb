=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
class My
  class << self

    def set what, value
      data.merge!(what => value)
      save
    end
    def get what
      data[what]
    end

    def destroy what
      data.delete(what)
      save
    end

    def save
      data
      @data.merge!(updated_at: Time.now)
      save_data
    end

    # Les données du compte courant. Pour le moment, un seul compte peut
    # être utilisé, celui de l'utilisateur courant. Son fichier est enregistré
    # en caché à la racine de son bureau (~/.my)
    def data
      @data ||= begin
        if File.exist?(data_path)
          load_data
        else
          Hash.new
        end
      end
    end
    # /data

    def save_data
      File.open(data_path,'wb'){|f| Marshal.dump(data, f)}
    end

    def load_data
      File.open(data_path,'rb'){|f| Marshal.load(f)}
    end

    def data_path
      @data_path ||= File.expand_path(File.join(Dir.home,'.my'))
    end

  end #/<< self
end#/ My
