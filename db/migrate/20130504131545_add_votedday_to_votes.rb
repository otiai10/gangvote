class AddVoteddayToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voted_day, :date
  end
end
