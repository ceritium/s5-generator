class CategoriesController < ApplicationController
  
  
  def index
    @categories = Category.find :all
  end
  
  def show
    @categories = Category.find :all
    @category = Category.find params[:id]
    @slideshows = @category.slideshows.paginate :page => params[:page], :include => [:user, :category]
    render :layout => 'little_big'
  end
end
