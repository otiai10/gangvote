class CreateAdminusers < ActiveRecord::Migration
  def change
    create_table :adminusers do |t|
      t.string :team, :null => false
      t.string :name, :null => false
      t.string :password, :null => false
      t.binary :info

      t.timestamps
    end
  end
end
