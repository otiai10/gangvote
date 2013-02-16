class AccountController < ApplicationController
  def login
    cookies[:user_name] = { :value => params[:user_name] }
    cookies[:vote_left] = { :value => 4 }
    redirect_to players_url
  end
end
