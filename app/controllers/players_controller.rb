class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    #@mess = 'indexを通ってきました'
    @user_name = cookies[:user_name]
    @vote_left = cookies[:vote_left]
    @players = Player.find(:all, :order => "points DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, :notice => 'Player was successfully created.' }
        format.json { render :json => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.json { render :json => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, :notice => 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  # POST /players/1/vote
  def vote
    @user_name = cookies[:user_name]
    @vote_left = cookies[:vote_left]
    logger.debug @vote_left
    unless @user_name.nil?
      unless @vote_left.to_i < 1
        _vote
        @mess = '投票しました'
      else
        @mess = '投票回数が0回です'
      end
    else
      @mess = 'まずユーザ登録してください'
    end
    #respond_to do |format|
    #  format.html { redirect_to players_url }
    #  format.json { head :no_content }
    #end
    # messをcookie使ってやり取りするならこの処理はいらん
    @players = Player.find(:all, :order => "points DESC")
    @vote_left = cookies[:vote_left]
    render 'players/index'
  end
end

def _vote()
  @player = Player.find(params[:id])
  points = @player.points
  unless points.nil?
    points = points + 1
  else
    points = 1
  end
  @player.update_attributes( :points => points )
  new_vote_left = @vote_left.to_i - 1
  cookies[:vote_left] = { :value => new_vote_left }
  logger.debug new_vote_left
end
