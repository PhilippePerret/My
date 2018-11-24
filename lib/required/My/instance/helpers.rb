class My


  def human_what
    @human_what ||= what.split('_').join(' ')
  end

  def reset_and_display
    self.reset
    self.display
  end
  def display
    puts String::RC*2
    simple_display
    puts String::RC*2
    puts "(pour modifier cette valeur, utilisez l'option -m/--modifier)"
  end
  # /display

  def simple_display
    puts mef_lib_and_value.bleu
  end

  def mef_lib_and_value
    lib = human_what.capitalize
    full_lib = '     %s : ' % lib
    full_lib_len = full_lib.length
    return full_lib + formated_value(full_lib_len)
  end

  def formated_value(retraits)
    value.gsub(/\\n/, String::RC + ' '*retraits)
  end

end #/My
