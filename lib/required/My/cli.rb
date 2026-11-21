# Analyse minimale de la ligne de commande
class CLI

  DIM_OPT_TO_REAL_OPT = {
    'c'  => 'children',
    'd'  => 'description',
    'h'  => 'help',
    'k'  => 'kill',
    'm'  => 'modifier',
    'vb' => 'verbose',
  }

  class << self

    attr_accessor :command, :params, :options

    def analyse_command_line(argv = ARGV)
      self.command = nil
      self.options = {}
      self.params  = [nil]
      argv.each do |arg|
        if arg.start_with?('-') && arg != '-'
          traite_option(arg)
        elsif command.nil?
          self.command = arg.gsub(/\-/, '_')
        else
          params << arg
        end
      end
    end

    def traite_option(arg)
      if arg.start_with?('--')
        opt, val = arg[2..-1].strip.split('=')
        opt = opt.gsub(/-/, '_')
      else
        dim, val = arg[1..-1].strip.split('=')
        opt = DIM_OPT_TO_REAL_OPT[dim] || begin
          puts "L'option #{dim.inspect} est inconnue.".rouge
          return
        end
      end
      options[opt.to_sym] = val.nil? ? true : val
    end

    def dbg(msg, file = nil, line = nil)
      options[:verbose] || return
      file && msg = '%s (%s%s)' % [msg, file.sub(/#{APPFOLDER}\//, ''), line ? ":#{line}" : '']
      puts msg
    end

    # Mode test : touches fournies par --keys_mode_test="y;;;n"
    def mode_interactif?
      options[:keys_mode_test].nil?
    end

    def next_key_mode_test
      @keys_mode_test ||= options[:keys_mode_test].split(';;;')
      @keys_mode_test.shift
    end

  end #/<< self
end #/CLI
