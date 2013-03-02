class Game < ActiveRecord::Base
  attr_accessible :awayteam, :date, :hometeam, :stadium, :title, :imgurl
end
