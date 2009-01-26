class AddCategoryIdToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :category_id, :integer, :null => false
  end

  def self.down
    remove_column :slideshows, :category_id
  end
end
