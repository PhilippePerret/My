class My
  class << self


    def display_all
      puts String::RC*2
      data.each do |what, value|
        what != :updated_at || next
        new(what).simple_display
      end
      puts String::RC*2
    end
    # /display_all

  end #/<< self
end #/My
