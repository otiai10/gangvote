class TopController < ApplicationController
  def index
    @user_name = cookies[:user_name]
  end
end
