class MainController < ApplicationController
  
  
  def welcome
    @categories = Category.most_popular
    @slideshows = Slideshow.published.find(:all, :limit => 10)
    @slideshow = Slideshow.find(:last, :include => :user)
    render :layout => 'two_columns'
  end
  
  def explore
    @slideshows = Slideshow.find(:all, :group => 'category_id', :include => [:category])
    render :layout => 'little_big'
  end
end
