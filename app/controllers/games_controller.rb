class GamesController < ApplicationController
  def create
    if authenticate()
      @game = Game.new(params[:game])

      # create new file path
      f_name = params[:game][:hometeam] + '_' + params[:game][:awayteam] + IMG_EXTENTION
      # pick up param
      file = params[:file]
      unless file.nil?
        # save file binary
        File.open(RAILS_ROOT + '/app/assets/images/game/' + f_name, 'w') do |opened|
          opened.write(file.read)
        end
      end

      # set imgurl
      @game[:imgurl] = 'game/' + f_name

      respond_to do |format|
        if @game.save
          format.html { redirect_to :controller => 'admin', :action => 'game' }
        else
          format.html { render :controller => "admin", :action => 'game' }
        end
      end
    end
  end

  def authenticate()
    if session[:login_user].nil?
      redirect_to :controller => 'admin', :action => 'login'
      return false
    else
      return true
    end
  end

end
