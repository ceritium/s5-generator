class AddIndex2 < ActiveRecord::Migration
  def self.up
    add_index :slideshows, :created_at
    add_index :categories, :slideshows_count
    add_index :slideshows, :views_today
    add_index :slideshows, :views_this_week
    add_index :slideshows, :views_this_month
    add_index :slideshows, :views
    
  end

  def self.down
    remove_index :slideshows, :created_at
    remove_index :categories, :slideshows_count
    remove_index :slideshows, :views_today
    remove_index :slideshows, :views_this_week
    remove_index :slideshows, :views_this_month
    remove_index :slideshows, :views
    
  end
end
