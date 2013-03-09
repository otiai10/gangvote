class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::UnknownAction, :with => :error_404

  def error404
    render :template => '/shared/error_404', :status => 404
  end

  def authenticate()
    if session[:login_user].nil?
      redirect_to :controller => 'admin', :action => 'login'
      return false
    else
      return true
    end
  end

  def isJoined()
    if session[:game].nil? || cookies[:user_name].nil?
      redirect_to :controller => 'top'
      return false
    else
      return true
    end
  end

end
