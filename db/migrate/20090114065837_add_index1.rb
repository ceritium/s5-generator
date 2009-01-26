class AddIndex1 < ActiveRecord::Migration
  def self.up
    add_index :slideshows, :title
    add_index :slideshows, :user_id
    add_index :slideshows, :slug, :unique => true
    add_index :slideshows, :category_id
    add_index :comments, :slideshow_id
    add_index :slides,  :slideshow_id
    add_index :categories, :name
    add_index :users, :slug, :unique => true
    
  end

  def self.down
    remove_index :slideshows, :title
    remove_index :slideshows, :user_id
    remove_index :slideshows, :slug, :unique => true
    remove_index :slideshows, :category_id
    remove_index :comments, :slideshow_id
    remove_index :slides,  :slideshow_id
    remove_index :categories, :name
    remove_index :users, :slug
  end
end
