class AddFavoriteAndReasonToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :favorite, :string
    add_column :players, :reason, :string
  end
end
