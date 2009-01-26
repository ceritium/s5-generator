class AddCommentsCountToSlideshow < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :comments_count, :integer, :default => 0
    Slideshow.reset_column_information
    Slideshow.find(:all).each do |p|
      Slideshow.update_counters p.id, :comments_count => p.comments.length
    end
    
  end

  def self.down
    remove_column :slideshows, :comments_count
  end
end
