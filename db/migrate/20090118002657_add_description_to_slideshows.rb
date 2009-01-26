class AddDescriptionToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :description, :string
  end

  def self.down
    remove_column :slideshows, :description
  end
end
