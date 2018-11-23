class My


  def human_what
    @human_what ||= what.split('_').join(' ')
  end


end #/My
