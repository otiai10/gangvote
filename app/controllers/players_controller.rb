class PlayersController < ApplicationController

  def init
    if Player.update_all("points=0")
      cookies[:mess] = '得票を初期化しました'
    end
    redirect_to :controller => 'admin', :action => 'players'
  end

  # GET /players
  # GET /players.json
  def index
    @mess      = cookies[:mess]
    @user_name = cookies[:user_name]
    @vote_left = cookies[:vote_left]
    cookies[:mess] = { :value => '' }

    @players = Player.find(:all, :order => "points DESC")
    @players.each do |player|
      player[:p_twenty] = player.points.to_i.div(20)
      player[:p_under_twenty] = player.points.to_i.%20
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])
    @user_name = cookies[:user_name]
    @vote_left = cookies[:vote_left]
    @player[:p_twenty] = @player.points.to_i.div(20)
    @player[:p_under_twenty] = @player.points.to_i.%20
    respond_to do |format|
      format.html { render :layout => true }
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

    # pick up param
    file = params[:file]
    # create new file path
    f_name = params[:player][:team] + '_' + params[:player][:number]
    # save file binary
    File.open(RAILS_ROOT + '/app/assets/images/prof/' + f_name, 'w') do |opened|
      opened.write(file.read)
    end
    # set imgurl
    #@player[:imgrul] = 'prof/' + f_name # この書き方だと、update_attributesで上書きされるくさい
    params[:player][:imgurl] = 'prof/' + f_name

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to :controller => 'admin', :action => 'players' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/delete/1
  def delete
    @player = Player.find(params[:id])
    res = @player.delete

    respond_to do |format|
      format.html { redirect_to :controller => 'admin', :action => 'players' }
      format.json { head :no_content }
    end
  end

  # POST /players/1/vote
  def vote
    @player = Player.find(params[:id])
    @user_name = cookies[:user_name]
    @vote_left = cookies[:vote_left]
    logger.debug @vote_left
    unless @user_name.nil?
      unless @vote_left.to_i < 1
        _vote
        #@mess = '投票しました'
        cookies[:mess] = { :value => @player.number.to_s + 'に★しました' }
      else
        #@mess = '投票回数が0回です'
        cookies[:mess] = { :value => '投票回数が０回です' }
      end
    else
      #@mess = 'まずユーザ登録してください'
      cookies[:mess] = { :value => 'まずはユーザ名を決めて参加してください' }
    end
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
    ## messをcookie使ってやり取りするならこの処理はいらん
    #@players = Player.find(:all, :order => "points DESC")
    #@vote_left = cookies[:vote_left]
    #render 'players/index'
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
