class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :number
      t.string :name
      t.string :kana
      t.integer :position
      t.integer :grade
      t.string :imgurl
      t.string :introduction
      t.integer :from
      t.binary :info

      t.timestamps
    end
  end
end
