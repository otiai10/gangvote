class AddSportToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :sport, :string
  end
end
