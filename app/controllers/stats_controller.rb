class StatsController < ApplicationController
  def index
    ensure_logged_in

    games = Game.where("user_id = (?)", session[:user_id])

    @games_played = games.count
    @total_rolls = games.inject(0) { |sum, g| sum + g.rolls.count }

    @actual_series, @expected_series = Roll.get_game_stats(games.map{|g| g.id})
  end
end
