module CategoriesHelper


  def category_link(category, current_category)
      html = '<li id="' +  (category.id == current_category.id ? "current" : category.name) + '">'
      html += link_to category.name, category_path(category) 
      html += "</li>"
  end  
end
