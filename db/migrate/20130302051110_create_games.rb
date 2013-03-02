class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :titile
      t.datetime :date
      t.string :stadium
      t.string :hometeam
      t.string :awayteam

      t.timestamps
    end
  end
end
