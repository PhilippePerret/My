=begin

  Tout ce qui concerne les données générales My, donc d'un compte

=end
class My

  class << self

    def set whats, value
      CLI.dbg('--- [My::set] what: %s, value: %s' % [whats.inspect, value.inspect], __FILE__, __LINE__)
      now = Time.now
      value.merge!(updated_at: now)
      data.merge!(updated_at: now)
      curthing = data
      whats.each do |key|
        curthing.key?(key) || curthing.merge!(key => Hash.new)
        puts "-- data = #{data.inspect}"
        curthing = curthing[key]
        puts "-- curthing = #{curthing.inspect}"
      end
      # On enregistre enfin la valeur
      # curthing = value
      curthing.merge!(value)

      puts data.to_yaml
      return

      save
    end

    def get what
      data[what]
    end

    # Détruit la chose +my+
    def destroy my
      curthing = my.thing_value
      my.whats[0..-2].each do |key|
        curthing = curthing[key]
      end
      curthing.delete(my.whats.last)
      save
      puts "#{my.human_what.inspect} détruit avec succès.".bleu
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

  end #/<< self
end#/ My
