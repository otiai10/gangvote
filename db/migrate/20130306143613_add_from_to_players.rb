class AddFromToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :from, :string
  end
end
