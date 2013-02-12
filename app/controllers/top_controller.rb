class TopController < ApplicationController
  def index
    @test = Player.all
  end
end
