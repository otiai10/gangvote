# require 'rubygems'
# require 'active_record'

require 'app/models/player'
require 'app/models/vote'

@players = Player.find(:all)
@players.each do |player|
  player.points.to_i.times do
    vote = Vote.new
    vote[:voted_id]  = player.id
    vote[:voted_day] = '2013 4-14'
    result = vote.save
    p vote
    p result
  end
end
