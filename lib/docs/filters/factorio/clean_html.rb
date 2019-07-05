module Docs
  class Factorio
    class CleanHtmlFilter < Filter
      def call
        # css('*[layout]').remove_attr('layout')
        # css('*[layout-xs]').remove_attr('layout-xs')
        # css('*[flex]').remove_attr('flex')
        # css('*[flex-xs]').remove_attr('flex-xs')
        # css('*[ng-class]').remove_attr('ng-class')
        # css('*[align]').remove_attr('align')
        # css('h1, h2, h3').remove_attr('class')

        last_nav = css('.navigation-bar a').last
        class_page = class_page = (not last_nav.nil? and last_nav.content == 'Classes' or slug.end_with? 'Common')
        at_css('h1')['data-type'] = last_nav.content if not last_nav.nil?
        css('.navigation-bar').remove

        if slug.end_with? 'Classes'
          # Remove from classes overview the repeated class overviews
          css('.brief-listing .brief-listing').remove
        elsif class_page
          # We are in a class page
          element = at_css('.element')

          at_css('h1')['id'] = element['id']
          element.remove_attribute 'id'
          element.remove_class 'element'
          element.children.before "<h2>Members:</h2>"+at_css('.brief-listing .brief-listing table').to_html

          at_css('.brief-listing .brief-listing').remove
        else
          # Pages like Concepts

          css('.brief-listing .brief-listing').each do |node|
            struct = node.children[0]
            name = node.at_css('.type-name')
            table = node.at_css('table')

            node.inner_html = ""
            node << '<h3>'+struct.content+'</h3>'
            node.children[0] << name
            node << table.to_html
          end
        end


        css('.element-header').each do |node|
          node.name = 'h3'
        end


        css('.detail-header').each do |node|
          node.name = 'h4'
        end

        css('.example-header').each do |node|
          node.name = 'h4'
        end

        css('.example').each do |node|
          node.css('.block').each do |code|
            code.name = 'pre'
            code['data-language'] = 'lua'
          end
        end
        doc
      end
    end
  end
end
