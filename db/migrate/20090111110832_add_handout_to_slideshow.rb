class AddHandoutToSlideshow < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :handout_code, :text
    add_column :slideshows, :handout_html, :text
  end

  def self.down
    remove_column :slideshows, :handout_html
    remove_column :slideshows, :handout_code
  end
end
