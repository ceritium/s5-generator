class AddChangeDefaultOrderToSlides < ActiveRecord::Migration
  def self.up
    change_column_default :slides, :order_play, 0
  end

  def self.down
    change_column_default :slides, :order_play, nil
  end
end
