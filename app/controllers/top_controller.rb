class TopController < ApplicationController
  def index
    @user_name = cookies[:user_name]
    @games = Game.all
    @game  = Game.last
    @game_join  = session[:game]

    @vote_left = cookies[:vote_left]
    if @vote_left.nil?
      @vote_left = 0
    end

  end
end
