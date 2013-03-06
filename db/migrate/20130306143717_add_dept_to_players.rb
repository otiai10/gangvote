class AddDeptToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :dept, :string
  end
end
