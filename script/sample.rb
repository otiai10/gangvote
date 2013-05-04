# require 'rubygems'
# require 'active_record'

require 'app/models/player'
require 'app/models/vote'

#@players = ActiveRecord::Base.connection.execute("select *, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id AND voted_day='now') AS score, (SELECT count(*) FROM votes WHERE votes.voted_id=players.id) AS total_score FROM players ORDER BY score DESC, total_score DESC, number ASC")

@players = Player.find(:all)
p @players
