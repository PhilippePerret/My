=begin

  Script pour requérir toutes les choses indispensables à commencer
  par l'application elle-même.

=end

APPFOLDER = File.dirname(__dir__)

Dir["#{APPFOLDER}/lib/required/**/*.rb"].each { |m|require m }
