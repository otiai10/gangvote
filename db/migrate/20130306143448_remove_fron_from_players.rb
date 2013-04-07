class RemoveFronFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :fron
  end

  def down
    add_column :players, :fron, :string
  end
end
