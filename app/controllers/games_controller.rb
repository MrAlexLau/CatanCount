class GamesController < ApplicationController
  load_and_authorize_resource :game
  def index
    @games = Game.where("user_id = (?)", session[:user_id]).order("created_at DESC")
        
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rolls }
    end
  end
  
  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    @actual_series, @expected_series = Roll.get_game_stats(@game.id)
    
    @rolls = @game.rolls.paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roll }
    end
  end
  
  def new
    @game = Game.new()
    @game.create_date = Date.today
    @game.user_id = session[:user_id]
    
    users_games_today = Game.where("user_id = (?) and create_date = (?)", session[:user_id], Date.today).order("created_at DESC")
    @game.game_name = Date.today.to_s + " Game " + (users_games_today.length + 1).to_s
    
    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Game was successfully created.' }
        format.json { render json: games_path, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_roll
    @game = Game.find(params[:id])
    
    dice_roll = get_dice_roll_value()  
    if dice_roll > 0
      @roll = Roll.new
      @roll.game_id = @game.id
      @roll.total = dice_roll
      @roll.save
    end
    
    respond_to do |format|
        format.html { redirect_to @game, notice: 'Roll was successfully updated.' }
        format.json { head :no_content }
    end
  end
    
  def get_dice_roll_value
    if params[:one_button] == "1"
      return 1
    elsif params[:two_button] == "2"
      return 2
    elsif params[:three_button] == "3"
      return 3
    elsif params[:four_button] == "4"
      return 4
    elsif params[:five_button] == "5"
      return 5
    elsif params[:six_button] == "6"
      return 6
    elsif params[:seven_button] == "7"
      return 7
    elsif params[:eight_button] == "8"
      return 8
    elsif params[:nine_button] == "9"
      return 9
    elsif params[:ten_button] == "10"
      return 10
    elsif params[:eleven_button] == "11"
      return 11
    elsif params[:twelve_button] == "12"
      return 12
    else
      return -1
    end
  end
  
end
