class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout '100'
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge, :show, :change_password_update]
  
  def show
    @published_slideshows = @user.slideshows.published.find(:all, :limit => 9)
    if current_user == @user
      @drafted_slideshows = @user.slideshows.drafted.find(:all, :limit => 9)
    end  
    render :layout => 'little_big'
  end
  

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    redirect_to profile_path
  end
  # render new.rhtml
  def new
    @user = User.new
  end
  
  
  
  def change_password_update
      if User.authenticate(@user.login, params[:old_password])
          if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
              @user.password_confirmation = params[:password_confirmation]
              @user.password = params[:password]
              
              if current_user.save!
                  flash[:notice] = "Password successfully updated"
                  redirect_to profile_path
              else
                  flash[:alert] = "Password not changed"
                  render :action => 'edit'
              end
               
          else
              flash[:alert] = "New Password mismatch" 
              render :action => 'edit'
          end
      else
          flash[:alert] = "Old password incorrect" 
          render :action => 'edit'
      end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = verify_recaptcha && @user && @user.valid?
    @user.register! if success
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  



  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
