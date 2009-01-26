class RenamePrintsToViewsToSlideshows < ActiveRecord::Migration
  def self.up
    rename_column :slideshows, :prints, :views_all_time
  end

  def self.down
    rename_column :slideshows, :views_all_time, :prints
  end
end
