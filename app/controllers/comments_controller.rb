class CommentsController < ApplicationController
  
  before_filter :login_required
  
  def create
    current_user.comments.build(params[:comment]).save
    redirect_to :back
  end
end
