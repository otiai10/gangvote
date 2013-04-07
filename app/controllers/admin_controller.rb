class AdminController < ApplicationController
  def login
    @mess = cookies[:mess]
    cookies[:mess] = ''
    respond_to do |format|
      format.html  { render :layout => false }
    end
  end

  def game
    if authenticate()
      @newgame = Game.new
      @game = Game.last
      respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def players
    if authenticate()
      @players = Player.find(:all, :order => "number")
      respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def newplayer
    if authenticate()
      @player = Player.new
      respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def csv
    if authenticate()
       respond_to do |format|
        format.html { render :layout => false }
      end
    end
  end

  def authenticate()
    if session[:login_user].nil?
      redirect_to :controller => 'admin', :action => 'login'
      return false
    else
      return true
    end
  end

end
