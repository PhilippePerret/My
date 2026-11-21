require 'tty-prompt'
require 'tty-screen'
class My
  class << self

    # Affiche la liste filtrable de toutes les choses mémorisées et
    # affiche (et copie dans le presse-papier) celle choisie.
    def choose_from_list(items = all_things, modifier = false)
      if items.empty?
        puts 'Aucune chose mémorisée pour le moment.'.rouge
        return
      end
      max_len = TTY::Screen.width - 4
      choices = items.map do |whats, value, description|
        name = '%s : %s' % [whats.join(' '), value.gsub(/__RC__/, ' / ')]
        description.empty? || name += ' — ' + description
        name = name[0, max_len - 1] + '…' if name.length > max_len
        {name: name, value: whats}
      end
      whats = TTY::Prompt.new.select('Afficher…'.jaune, choices, filter: true, per_page: 20)
      modifier ? new(whats).modify : new(whats).display_and_wait
    rescue TTY::Reader::InputInterrupt
      puts ''
    end

    # Cherche les choses les plus proches de +expr+. Affiche la chose si
    # elle est seule, propose la liste sinon. Retourne false si aucune.
    def search_and_display(expr, modifier = false)
      found = search(expr)
      case found.count
      when 0 then return false
      when 1 then modifier ? new(found.first[0]).modify : new(found.first[0]).display_and_wait
      else choose_from_list(found, modifier)
      end
      true
    end

    # Retourne les choses proches de +expr+, les plus proches en premier
    def search(expr)
      mots = normalize(expr).split(/\s+/)
      all_things.map do |item|
        whats, _value, description = item
        noms  = whats.map { |w| normalize(w) }
        desc  = normalize(description)
        score = mots.sum do |mot|
          if noms.include?(mot)                           then 4
          elsif noms.any? { |n| n.include?(mot) || (n.length > 2 && mot.include?(n)) } then 3
          elsif desc.include?(mot)                        then 2
          elsif noms.any? { |n| levenshtein(n, mot) <= [1, mot.length / 4].max } then 1
          else 0
          end
        end
        [item, score]
      end.select { |_, score| score > 0 }.sort_by { |_, score| -score }.map(&:first)
    end

    def normalize(str)
      str.to_s.unicode_normalize(:nfd).gsub(/\p{Mn}/, '').downcase.strip
    end

    def levenshtein(a, b)
      prev = (0..b.length).to_a
      a.each_char.with_index(1) do |ca, i|
        cur = [i]
        b.each_char.with_index(1) do |cb, j|
          cur << [prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + (ca == cb ? 0 : 1)].min
        end
        prev = cur
      end
      prev.last
    end

    # Retourne la liste [[whats], value, description] de toutes les choses
    # qui possèdent une valeur, en profondeur.
    def all_things(node = xmldoc.root.elements['choses'], parents = [])
      list = []
      children = node.elements['children'] || (return list)
      children.each_element('chose') do |chose|
        whats = parents + [chose.elements['name'].text]
        value = chose.elements['value']&.text.to_s.strip
        description = chose.elements['description']&.text.to_s.strip
        list << [whats, value, description] unless value.empty?
        list.concat(all_things(chose, whats))
      end
      list
    end

  end #/<< self
end #/My
