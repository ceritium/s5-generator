class Category < ActiveRecord::Base
  has_many :slideshows
  sluggable_finder :name
  
  named_scope :most_popular, :order => 'slideshows_count desc', :limit => 15
end
