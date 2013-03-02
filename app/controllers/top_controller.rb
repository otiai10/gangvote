class TopController < ApplicationController
  def index
    @user_name = cookies[:user_name]
    @game = Game.last
  end
end
