class RemoveTsFromVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :ts
  end

  def down
    add_column :votes, :ts, :datetime
  end
end
