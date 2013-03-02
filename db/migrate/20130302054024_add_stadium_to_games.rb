class AddStadiumToGames < ActiveRecord::Migration
  def change
    add_column :games, :stadium, :integer
  end
end
