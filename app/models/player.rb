class Player < ActiveRecord::Base
  attr_accessible :from, :grade, :imgurl, :info, :introduction, :kana, :name, :number, :position, :points, :team, :dept, :sport
end
