class Game < ActiveRecord::Base
  has_many :rolls
  attr_accessible :game_name, :user_id


  def self.get_new_game(user_id)
    g = Game.new
    g.user_id = user_id
    g.create_date = Date.today

    u = User.find(user_id)
    if u && !u.is_guest?
      users_games_today = Game.where("user_id = (?) and create_date = (?)", user_id, Date.today).order("created_at DESC").count
      g.game_name = Date.today.to_s + " Game " + (users_games_today + 1).to_s
    end

    g.save()
    return g
  end

end
