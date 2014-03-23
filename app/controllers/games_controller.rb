class GamesController < ApplicationController
  load_and_authorize_resource :game
  def index
    @games = Game.where("user_id = (?)", session[:user_id]).order("created_at DESC")

    if @games.empty?
      @game = set_up_new_game
      @game.save
      redirect_to game_path(@game) and return
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    @actual_series, @expected_series = Roll.get_game_stats(@game.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roll }
    end
  end

  def new
    @game = set_up_new_game
    @game.save

    redirect_to @game
  end

  # POST /games
  # POST /games.json
  def create
    @game = set_up_new_game
    @game.save

    redirect_to @game
  end


  def undo_last_roll
    @game = Game.find(params[:id])
    last_roll = @game.rolls.order("created_at DESC").first
    last_roll.destroy if last_roll
    render nothing: true
  end

  private

  def set_up_new_game
    game = Game.new()
    game.create_date = Date.today
    game.user_id = session[:user_id]

    if current_user && !current_user.is_guest?
      users_games_today = Game.where("user_id = (?) and create_date = (?)", session[:user_id], Date.today).order("created_at DESC")
      game.game_name = Date.today.to_s + " Game " + (users_games_today.length + 1).to_s
    end

    return game
  end

end
