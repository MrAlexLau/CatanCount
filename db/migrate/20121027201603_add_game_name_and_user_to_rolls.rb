class AddGameNameAndUserToRolls < ActiveRecord::Migration
  def change
    add_column :rolls, :user_id, :integer
    add_column :rolls, :game_name, :string
  end
end
