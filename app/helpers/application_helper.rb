# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "flash-#{msg}", :class => msg) unless flash[msg.to_sym].blank?
    end
    messages
  end
  
  
  def nav_main(text, url, options)
    if options[:controller] && !options[:action]
      name = @controller.controller_name == options[:controller] ? "current" : options[:controller]
    elsif options[:controller] && options[:action]
      name = (@controller.controller_name == options[:controller] && options[:action].include?(@controller.action_name) ) ? "current" : "#{options[:controller]}_#{options[:action]}"
    end
      html = '<li id="' +  name + '">'
      html += link_to(text,url)
      html += "</li>"
  end
  
  def array_select(array, target)
    result = array.select{ |x| x.first == target}.flatten
    if result
      result.last
    else
      array.last.flatten
    end
  end
  
end
