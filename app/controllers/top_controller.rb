class TopController < ApplicationController
  def index
    @user_name = cookies[:user_name]
    @games = Game.all
    @game  = Game.last
  end
end
