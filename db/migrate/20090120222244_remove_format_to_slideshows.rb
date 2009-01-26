class RemoveFormatToSlideshows < ActiveRecord::Migration
  def self.up
    remove_column :slideshows, :format
  end

  def self.down
    add_column :slideshows, :format, :string
  end
end
