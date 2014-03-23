class Game < ActiveRecord::Base
  has_many :rolls
  attr_accessible :game_name, :user_id
  
  
  def self.get_new_game(user_id)
    g = Game.new
    g.user_id = user_id
    g.save()
    return g
  end
  
end
