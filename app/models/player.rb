class Player < ActiveRecord::Base
  attr_accessible :from, :grade, :imgurl, :info, :introduction, :kana, :name, :number, :positiom, :points
end