require 'kramdown'
class My
  class << self

    def rebuild_manuel
      code = <<-HTML
<!DOCTYPE html>
<html lang="fr" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Manuel de la commande CLI `My`</title>
  </head>
  <body>
    #{Kramdown::Document.new(File.read(manuel_md_path)).to_html}
  </body>
</html>
      HTML
      File.open(manuel_html_path,'wb'){|f| f.write code}
    end
    def manuel_uptodate?
      File.exist?(manuel_html_path) && File.stat(manuel_html_path).mtime > File.stat(manuel_md_path).mtime
    end

    def manuel_md_path
      @manuel_md_path ||= File.join(APPFOLDER,'lib','asset','manuel','manuel.md')
    end
    def manuel_html_path
      @manuel_html_path ||= File.join(APPFOLDER,'lib','asset','manuel','manuel.html')
    end

  end #/<< self
end #/My
