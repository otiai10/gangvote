class AdminController < ApplicationController
  def login
    @mess = cookies[:mess]
    @login_name = session[:login_name]
    cookies[:mess] = ''
    respond_to do |format|
      format.html  { render :layout => false }
    end
  end

  def game
    if authenticate()
      respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def players
    if authenticate()
      @players = Player.all
      respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def authenticate()
    if session[:login_name].nil?
      redirect_to :controller => 'adminmenue', :action => 'index'
      return false
    else
      return true
    end
  end
end
