require "#{File.dirname(__FILE__)}/abstract_note"

module Footnotes
  module Notes
    class LayoutNote < AbstractNote
      def initialize(controller)
        @controller = controller
        @template = @controller.instance_variable_get('@template')
      end

      def row
        :edit
      end

      def link
        escape(Footnotes::Filter.prefix(filename, 1, 1))
      end

      def valid?
        prefix? && @controller.active_layout
      end

      protected
        def filename
          file = @template.send(:_pick_template, @controller.active_layout)
          File.join(File.expand_path(RAILS_ROOT), 'app', 'views', file.to_s)          
        end
    end
  end
end
