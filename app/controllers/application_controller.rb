class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::UnknownAction, :with => :error_404

  def error404
    render :template => '/shared/error_404', :status => 404
  end
end
