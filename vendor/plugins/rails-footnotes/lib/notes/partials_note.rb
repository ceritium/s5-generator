require "#{File.dirname(__FILE__)}/log_note"

module Footnotes
  module Notes
    class PartialsNote <  LogNote
      def initialize(controller)
        @controller = controller
        @template = controller.instance_variable_get('@template')
        @partials = get_partials
      end
      
      def content
        result = '<ul>'
          @partials.collect.each do |partial|
            full_filename = File.join(File.expand_path(RAILS_ROOT), 'app', 'views', partial.first.to_s)
            result += "<li><a href='#{Footnotes::Filter.prefix}#{full_filename}'>"
            result += "#{partial.last}</a></li>"
          end
        result += '</ul>'
       
       result
      end
      
      def title
        "Partials (#{@partials.length})"        
      end
      
      private
      def get_partials
        partials = escape(log_tail).scan(/Rendered.*\(/).collect{|x| x.gsub('Rendered ', '').gsub('(', '').strip}.uniq
        partials[0..partials.length].collect{|partial| [@template.send(:_pick_template, partial), partial]}
      end

    end
  end
end