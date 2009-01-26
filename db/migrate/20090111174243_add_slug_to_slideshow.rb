class AddSlugToSlideshow < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :slug, :string
  end

  def self.down
    remove_column :slideshows, :slug
  end
end
