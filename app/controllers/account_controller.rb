class AccountController < ApplicationController
  def login
    cookies[:user_name] = { :value => params[:user_name], :expires => COOKIE_EXPIRE_HOUR.hour.from_now }
    cookies[:vote_left] = { :value => MAX_VOTE_TIME, :expires => COOKIE_EXPIRE_HOUR.hour.from_now }
    redirect_to players_url
  end

  def adminsignin
    @adminuser = Adminuser.find(:first, :conditions => {:name => params[:name], :team => params[:team], :password => params[:password]})
    unless @adminuser.nil?
      cookies[:mess] = 'サインインしました'
      session[:login_user] = @adminuser
      redirect_to :controller => 'admin', :action => 'game'
    else
      cookies[:mess] = 'チーム名、管理者名、パスワードの組み合わせが不正です'
      redirect_to :controller => 'admin', :action => 'login'
    end
  end

  def adminsignout
    cookies[:mess] = 'サインアウトしました'
    session[:login_user] = nil
    redirect_to :controller => 'admin', :action => 'login'
  end
end
