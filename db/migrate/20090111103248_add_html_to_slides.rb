class AddHtmlToSlides < ActiveRecord::Migration
  def self.up
    add_column :slides, :content_html, :text
    add_column :slides, :handout_html, :text
    
  end

  def self.down
    remove_column :slides, :content_html
    remove_column :slides, :handout_html
    
  end
end
