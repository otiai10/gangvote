class Adminuser < ActiveRecord::Base
  attr_accessible :info, :name, :password, :team
end
