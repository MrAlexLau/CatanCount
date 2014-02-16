class SeparateGameIntoNewTable < ActiveRecord::Migration
  def change
    rename_column :rolls, :game_number, :game_id
    remove_column :rolls, :game_name
    remove_column :rolls, :user_id
  end
end
