class SlidesController < ApplicationController
  
  before_filter :login_required
  before_filter :get_slideshow, :only => [:new, :create, :edit, :show, :update, :destroy, :order]
  before_filter :get_slide, :only => [:edit, :update, :show, :destroy, :preview]  
  
  in_place_edit_for :slide, :title
  in_place_edit_for :slide, :status
  
  def preview
    render :update do |page|
        page.replace_html  "slide_#{@slide.id}", :partial => 'preview'
    end
  end
  
  def order
    i = 1
    params[:slides].reverse_each do |slide|
      item = Slide.find(slide)
      item.order_play = i
      item.save
      i += 1
    end
    render :nothing => true
  end
    
  
  def new
   @slide = Slide.new
   @title_page = 'New Slide'
   render :layout => 'two_columns'
  end
  
  def edit    
    render :layout => 'two_columns'
  end
  
  def create
    @slide = @slideshow.slides.build(params[:slide])
    if @slide.save
      flash[:notice] = 'Creado slide'
      redirect_to new_slideshow_slide_path(@slideshow)
    else
      flash[:error] = 'Error al crear'
      render :action => :new
    end
  end
  
  def update
    if @slide.update_attributes(params[:slide])
      flash[:notice] = 'Slide actualizada correctamente'
      redirect_to edit_slideshow_slide_path(@slideshow, @slide)
    else
      flash[:error] = 'No se actualizó correctamente'
      render :action => :edit
    end
  end
  
  def destroy
    @slide.destroy
    flash[:notice] = 'Borrado correctamente'
    redirect_to new_slideshow_slide_path(@slideshow)  
  end
  
  protected
  def get_slideshow
    @slideshow = current_user.slideshows.find params[:slideshow_id]
    @slides = @slideshow.slides.ordered
  end
  
  def get_slide
    @slide = @slideshow.slides.find params[:id]
  end

  
 
end