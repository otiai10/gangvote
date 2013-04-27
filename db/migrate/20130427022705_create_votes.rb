class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voted_id
      t.datetime :voted_time
      t.timestamp :ts
      t.text :voted_by
      t.text :message

      t.timestamps
    end
  end
end
