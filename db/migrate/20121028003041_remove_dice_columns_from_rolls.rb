class RemoveDiceColumnsFromRolls < ActiveRecord::Migration
  def change
    remove_columns :rolls, :dice1
    remove_columns :rolls, :dice2
  end
end
