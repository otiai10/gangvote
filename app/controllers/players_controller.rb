class PlayersController < ApplicationController

  # GET /players
  # GET /players.json
  def index
    if isJoined
      @mess      = cookies[:mess]
      @user_name = cookies[:user_name]
      @vote_left = cookies[:vote_left]
      if @vote_left.nil?
        @vote_left = 0
      end
      cookies[:mess] = { :value => '' }

      @game = session[:game]

      @players = ActiveRecord::Base.connection.execute("select *, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id AND voted_day=date('" + Date.today.to_s + "')) AS score, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id) AS total_score FROM players ORDER BY score DESC, total_score DESC, number ASC")
      @players.each do |player|
        player['point_big'] = player['score'].to_i.div(STAR_COMPRESS_NUM)
        player['point_one'] = player['score'].to_i.%STAR_COMPRESS_NUM
        player['point_total'] = player['total_score'].to_i
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @players }
      end
    end
  end

  # ほぼindexと同じ
  def home
    if isJoined
      @mess      = cookies[:mess]
      @user_name = cookies[:user_name]
      @vote_left = cookies[:vote_left]
      if @vote_left.nil?
        @vote_left = 0
      end
      cookies[:mess] = { :value => '' }

      @game = session[:game]

      @players = ActiveRecord::Base.connection.execute("select *, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id AND voted_day=date('" + Date.today.to_s + "')) AS score, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id) AS total_score FROM players ORDER BY number ASC")
      @players.each do |player|
        player['point_big'] = player['score'].to_i.div(STAR_COMPRESS_NUM)
        player['point_one'] = player['score'].to_i.%STAR_COMPRESS_NUM
        player['point_total'] = player['total_score'].to_i
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @players }
      end
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    if isJoined

      @game = session[:game]

      @player = Player.find(params[:id])
      today_votes = Vote.count(:conditions => { :voted_id => @player.id, :voted_day => Date.today })
      total_votes = Vote.count(:conditions => { :voted_id => @player.id })
      @user_name = cookies[:user_name]
      @vote_left = cookies[:vote_left]
      @player[:point_big] = today_votes.to_i.div(STAR_COMPRESS_NUM)
      @player[:point_one] = today_votes.to_i.%STAR_COMPRESS_NUM
      @player[:today_votes] = today_votes
      @player[:total_votes] = total_votes
      respond_to do |format|
        format.html { render :layout => true }
        format.json { render :json => @player }
      end
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
    if authenticate()
      @player = Player.new(params[:player])

      # create new file path
      f_name = params[:player][:team] + '_' + params[:player][:number] + '.' + IMG_EXTENTION
      # pick up param
      file = params[:file]
      unless file.nil?
        # save file binary
        File.open(RAILS_ROOT + '/app/assets/images/prof/' + f_name, 'w') do |opened|
          opened.write(file.read)
        end
      end

      # set imgurl
      @player[:imgurl] = 'prof/' + f_name

      respond_to do |format|
        if @player.save
          #format.html { redirect_to @player, :notice => 'Player was successfully created.' }
          format.html { redirect_to :controller => 'admin', :action => 'players' }
          format.json { render :json => @player, :status => :created, :location => @player }
        else
          format.html { render :action => "new" }
          format.json { render :json => @player.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    if authenticate()
      @player = Player.find(params[:id])

      # create new file path
      f_name = params[:player][:team] + '_' + params[:player][:number]
      # pick up param
      file = params[:file]
      unless file.nil?
        # save file binary
        File.open(RAILS_ROOT + '/app/assets/images/prof/' + f_name, 'w') do |opened|
          opened.write(file.read)
        end
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
  end

  # DELETE /players/delete/1
  def delete
    if authenticate()
      @player = Player.find(params[:id])
      res = @player.delete

      respond_to do |format|
        format.html { redirect_to :controller => 'admin', :action => 'players' }
        format.json { head :no_content }
      end
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
  end
end

def _vote()
  @vote = Vote.new
  @vote.voted_id   = params[:id]
  @vote.voted_day  = Date.today
  new_vote_left = @vote_left.to_i - 1
  cookies[:vote_left] = { :value => new_vote_left }
#  logger.debug new_vote_left
  return @vote.save
end
