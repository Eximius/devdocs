module Docs
  class Factorio
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        name = at_css('h1').content
      end

      def get_type
        type = 'Overview'
        type = 'Classes' if at_css('h1')['data-type'] == 'Classes' or slug.end_with? 'Common'

        type
      end

      # INDEX = Set.new

      # def include_default_entry?
      #   false
      #   # INDEX.add?([name, type].join(';')) ? true : false # ¯\_(ツ)_/¯
      # end

      def additional_entries
        return [] if root_page?

        class_page = (at_css('h1')['data-type'] == 'Classes' or slug.end_with? 'Common')
        @name = get_name

        if class_page
          type = 'Methods'
        else
          type = @name
        end


        if type == 'Events'
          # Buggy page?
          css('.element .element').map do |node|
            [node['id'], node['id'], type]
          end
        else
          css('.element').each_with_object [] do |node, entries|
            elem_name = node.at_css('.element-name')
            if class_page and not elem_name.nil?
              name = @name + '.' + elem_name
            else
              name = node['id']
            end
            entries << [name, node['id'], type] if node['id'] != @name
          end
        end
      end

      private

      # def mod
      #   return @mod if defined?(@mod)
      #   @mod = slug[/api\/([\w\-\.]+)\//, 1]
      #   @mod.remove! 'angular2.' if @mod
      #   @mod
      # end
    end
  end
end
