
module Docs
  class Factorio < UrlScraper
	self.name = 'Factorio'
    self.type = 'simple'
    self.links = {
      home: 'https://factorio.com',
      code: 'https://lua-api.factorio.com'
    }

    self.release = 'latest'
    self.base_url = 'https://lua-api.factorio.com/' + self.release + '/'

    html_filters.push 'factorio/clean_html', 'factorio/entries'

    # options[:trailing_slash] = false
    # options[:container] = 'body'
    # options[:skip] = %w(guides development tutorial versions all)
    # options[:skip_patterns] = [/\/history\z/]
    # options[:replace_paths] = {
    #   'api/web-view-tag' => 'api/webview-tag'
    # }

    options[:max_image_size] = 256_000

    options[:attribution] = <<-HTML
      Copyright &copy; 2015&ndash;2019 Wube Software - all rights reserved.
    HTML

  end
end
