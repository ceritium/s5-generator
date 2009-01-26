class RenameViewsToAllToViewsToSlideshows < ActiveRecord::Migration
  def self.up
    rename_column :slideshows, :views_all_time, :views
    
  end

  def self.down
    rename_column :slideshows, :views, :views_all_time
  end
end
