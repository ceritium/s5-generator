class SlideshowsController < ApplicationController
  
  before_filter :login_required, :only => [:edit, :update, :create, :new]
  before_filter :get_slideshow, :only => [:play, :update, :present, :edit]
  after_filter  :update_views, :only => :play
  
  layout 'two_columns'
  
  in_place_edit_for :slideshow, :title
  in_place_edit_for :slideshow, :status

  
  
  
  def play
    render :layout => 'slideshow'
  end

  
  def index
   #if params[:time] == 'today'
   #  conditions = {:created_at => (Time.now-1.day..Time.now)}
   #elsif %w[this-week this-month].include? params[:time]
   #  conditions =  {:created_at => (Time.now-eval("1.#{params[:time].split('-').last}")...Time.now)}
   #else 
   #  conditions = ''
   #end
    order = ORDER[params[:order].gsub('-','_').to_sym].first
    time = params[:time].gsub('-','_')
    ordering = time == 'all_time' ? order : order + '_' + time
    @slideshows = Slideshow.paginate(:all, :page => params[:page], :per_page => 20, :order =>  ordering + ' desc', :include => [:user, :category])
    
    
    render :layout => 'big_little'
  end
  
  def show
    @slideshow = Slideshow.find(params[:id], :include => [:user])
    @slideshows = @slideshow.category.slideshows.find(:all, :limit => 3)
    @comments = @slideshow.comments.last_published.paginate(:page => params[:page])
    @comment = Comment.new
  end
  
  def edit
    @slides = @slideshow.slides.ordered
    render :layout => 'two_columns'
  end
  
  
  def new  
    @slideshow = Slideshow.new
    render :layout => 'big_little'
  end
  
  def create
    @slideshow = current_user.slideshows.build(params[:slideshow])
    if @slideshow.save
      flash[:notice] = 'Slideshow creado'
      redirect_to edit_user_slideshow_path(current_user, @slideshow)
    else
      flash[:error] = 'Problemas al crear el slideshow'
      render :action => :new
    end
  end
  
  def update
    if @slideshow.update_attributes(params[:slideshow])
      flash[:notice] = 'Datos actualizados correctamente'
    else
      flash[:error] = 'Hubo problemas al salvar los datos'
    end
    redirect_to edit_slideshow_path @slideshow
  end
  protected
  
    def update_views
      Slideshow.increment_counter(:views ,Slideshow.find(params[:id]).id)
    end
    def get_slideshow
      @slideshow = Slideshow.find params[:id]
    end

end
