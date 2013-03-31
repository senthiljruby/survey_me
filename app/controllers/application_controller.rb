class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  private
  def admin_only
    if current_user && current_user.admin?
      return true
    else
      flash[:notice] = "You are not authorized to view this content,please login as Admin"
      redirect_to root_path
    end
  end
end