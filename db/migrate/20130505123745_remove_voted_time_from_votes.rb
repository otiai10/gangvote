class RemoveVotedTimeFromVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :voted_time
  end

  def down
    add_column :votes, :voted_time, :datetime
  end
end
