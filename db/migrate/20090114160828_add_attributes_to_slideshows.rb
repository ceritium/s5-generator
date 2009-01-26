class AddAttributesToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :foot1, :string
    add_column :slideshows, :foot2, :string
    add_column :slideshows, :content_code, :text
    add_column :slideshows, :content_html, :text
  end

  def self.down
    remove_column :slideshows, :content_html
    remove_column :slideshows, :content_code
    remove_column :slideshows, :foot2
    remove_column :slideshows, :foot1
  end
end
