class AccountController < ApplicationController
  def login
    cookies[:user_name] = { :value => params[:user_name], :expires => 10.hour.from_now }
    cookies[:vote_left] = { :value => 4, :expires => 10.hour.from_now }
    redirect_to players_url
  end

  def adminlogin
    redirect_to adminmenue_url
  end
end
