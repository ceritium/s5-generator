class AddOrderToSlides < ActiveRecord::Migration
  def self.up
    add_column :slides, :order_play, :integer
  end

  def self.down
    remove_column :slides, :order_play
  end
end
