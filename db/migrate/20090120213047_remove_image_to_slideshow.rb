class RemoveImageToSlideshow < ActiveRecord::Migration
  def self.up
    remove_column :slideshows, :image_file_name
    remove_column :slideshows, :image_content_type
    remove_column :slideshows, :image_file_size
    remove_column :slideshows, :image_updated_at
  end

  def self.down
    add_column :slideshows, :image_file_name,    :string
    add_column :slideshows, :image_content_type, :string
    add_column :slideshows, :image_file_size,    :integer
    add_column :slideshows, :image_updated_at,   :datetime
  end
end
