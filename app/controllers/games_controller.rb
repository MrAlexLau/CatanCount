class GamesController < ApplicationController
  load_and_authorize_resource :game

  def index
    @games = Game.where("user_id = (?)", session[:user_id]).order("created_at DESC")

    if @games.empty?
      @game = Game.get_new_game(session[:user_id])
      redirect_to game_path(@game) and return
    end
  end

  def show
    @game = Game.find(params[:id])
    @actual_series, @expected_series = Roll.get_game_stats(@game.id)
  end

  def new
    # since all of the data for a new game is auto populated (like name, user, etc.)
    # just go ahead and create it
    create
  end

  def create
    @game = Game.get_new_game(session[:user_id])
    redirect_to @game
  end

  def undo_last_roll
    @game = Game.find(params[:id])
    last_roll = @game.rolls.order("created_at DESC").first
    last_roll.destroy if last_roll
    render nothing: true # chart updated automatically in javascript
  end
end
