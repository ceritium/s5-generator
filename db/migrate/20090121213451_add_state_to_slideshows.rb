class AddStateToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :status, :string, :default => 'drafted'
  end

  def self.down
    remove_column :slideshows, :status
  end
end
