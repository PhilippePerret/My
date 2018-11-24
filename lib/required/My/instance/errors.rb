class My

  def raise_if_not_exists ajout_msg = nil
    exist? || begin
      err_msg = 'Je ne connais pas l’élément %s. %s' % [what.inspect, ajout_msg || '']
      err_msg += String::RC*2 + ('Pour le créer : `my %s[ENTER]`' % what)
      raise err_msg
    end
  rescue Exception => e
    puts e.message.rouge
  end

end #/my
