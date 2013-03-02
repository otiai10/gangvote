class AddImgurlToGames < ActiveRecord::Migration
  def change
    add_column :games, :imgurl, :string
  end
end
