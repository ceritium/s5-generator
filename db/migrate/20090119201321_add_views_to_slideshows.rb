class AddViewsToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :views_today, :integer, :default => 0
    add_column :slideshows, :views_this_week, :integer, :default => 0
    add_column :slideshows, :views_this_month, :integer, :default => 0
  end

  def self.down
    remove_column :slideshows, :views_this_month
    remove_column :slideshows, :views_this_week
    remove_column :slideshows, :views_today
  end
end
