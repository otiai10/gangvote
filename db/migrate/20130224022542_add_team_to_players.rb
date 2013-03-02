class AddTeamToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :team, :string
  end
end
