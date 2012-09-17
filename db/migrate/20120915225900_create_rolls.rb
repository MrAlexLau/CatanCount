class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.integer :game_number
      t.integer :dice1
      t.integer :dice2
      t.integer :total

      t.timestamps
    end
  end
end
