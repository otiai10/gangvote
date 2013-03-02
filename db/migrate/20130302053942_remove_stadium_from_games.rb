class RemoveStadiumFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :stadium
  end

  def down
    add_column :games, :stadium, :string
  end
end
