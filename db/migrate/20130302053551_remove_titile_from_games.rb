class RemoveTitileFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :titile
  end

  def down
    add_column :games, :titile, :string
  end
end
