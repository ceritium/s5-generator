class AddPrintsToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :prints, :integer, :default => 0
  end

  def self.down
    remove_column :slideshows, :prints
  end
end
