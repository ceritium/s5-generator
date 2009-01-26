class AddSlideshowsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :slideshows_count, :integer, :default => 0
    Category.reset_column_information
    Category.find(:all).each do |p|
      Category.update_counters p.id, :slideshows_count => p.slideshows.length
    end
  end

  def self.down
    remove_column :categories, :slideshows_count
  end
end
