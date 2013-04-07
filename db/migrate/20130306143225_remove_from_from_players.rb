class RemoveFromFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :from
  end

  def down
    add_column :players, :from, :integer
  end
end
