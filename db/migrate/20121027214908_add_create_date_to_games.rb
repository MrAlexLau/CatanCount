class AddCreateDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :create_date, :date
  end
end
