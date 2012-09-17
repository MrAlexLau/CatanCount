class RollsController < ApplicationController
  
  # GET /rolls
  # GET /rolls.json
  def index
    @rolls = Roll.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rolls }
    end
  end

  # GET /rolls/1
  # GET /rolls/1.json
  def show
    @roll = Roll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roll }
    end
  end

  # GET /rolls/new
  # GET /rolls/new.json
  def new
    @roll = Roll.new
      
    @roll.game_number = session[:game_id]  

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roll }
    end
  end
  
  # GET /rolls/overview
  def overview
    @game_id = session[:game_id]
    
    @actual_series, @expected_series, @rolls = Roll.get_game_stats(@game_id)
    
    @roll = Roll.new
    @roll.game_number = @game_id

    respond_to do |format|
      format.html # overview.html.erb
    end
  end

  # GET /rolls/1/edit
  def edit
    @roll = Roll.find(params[:id])
  end

  # POST /rolls
  # POST /rolls.json
  def create
    @roll = Roll.new(params[:roll])

    @roll.game_number = session[:game_id]
    @roll.total = get_dice_roll_value()
    
    respond_to do |format|
      if @roll.save
        format.html { redirect_to rolls_overview_path, notice: 'Roll was successfully created.' }
        format.json { render json: rolls_overview_path, status: :created, location: @roll }
      else
        format.html { render action: "new" }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rolls/1
  # PUT /rolls/1.json
  def update
    @roll = Roll.find(params[:id])

    respond_to do |format|
      if @roll.update_attributes(params[:roll])
        format.html { redirect_to @roll, notice: 'Roll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rolls/1
  # DELETE /rolls/1.json
  def destroy
    @roll = Roll.find(params[:id])
    @roll.destroy

    respond_to do |format|
      format.html { redirect_to rolls_url }
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
    end
  end
end
