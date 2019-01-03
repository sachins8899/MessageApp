class ApplicationController < ActionController::Base
  
  helper_method :current_user, :loged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def loged_in?
    !!current_user
  end
  
  def require_user
    if !loged_in?
      flash[:error] = "Please! login whit your account for this action"
      redirect_to root_path
    end
  end
end
