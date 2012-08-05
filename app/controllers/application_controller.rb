class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user  
    
  private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else 
      nil
    end
  end
  
  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Projects }
    end
  end
  
end
