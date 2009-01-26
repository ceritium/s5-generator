class Comment < ActiveRecord::Base
  
  cattr_reader :per_page
  @@per_page = 5
  
  belongs_to :slideshow, :counter_cache => true
  belongs_to :user
  
  named_scope :last_published, :include => :user, :order => 'created_at desc'
  
end
