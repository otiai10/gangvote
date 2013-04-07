class LotteryController < ApplicationController
  def index
    if isJoined
      @user_name = cookies[:user_name]
      @vote_left = cookies[:vote_left]

      @game = session[:game]
      @lottery = session[:lottery]
      respond_to do |format|
        format.html
      end
    end
  end
end
