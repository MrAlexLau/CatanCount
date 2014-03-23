class RollsController < ApplicationController  
  load_and_authorize_resource :game
  load_and_authorize_resource :roll, :through => :game
  
  # GET /rolls
  # GET /rolls.json
  def index
    #@rolls = Roll.all

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
      
    @roll.game_id = session[:game_id]  

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roll }
    end
  end
  
  # GET /rolls/overview
  def overview
    @game_id = session[:game_id]
    
    @actual_series, @expected_series = Roll.get_game_stats(@game_id)
    
    @rolls = Roll.where("game_id = (?)", @game_id).paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    #@rolls = @rolls
    
    @roll = Roll.new
    @roll.game_id = @game_id
    

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
    @roll = Roll.new
    @roll.total = params['value']
    @roll.game_id = params[:game_id]
    @roll.save
    
    # respond_to do |format|
    #   if @roll.save
    #     format.html { redirect_to rolls_overview_path, notice: 'Roll was successfully created.' }
    #     format.json { render json: rolls_overview_path, status: :created, location: @roll }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @roll.errors, status: :unprocessable_entity }
    #   end
    # end

    redirect_to @game
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
    @roll.destroy
    respond_to do |format|
      format.html { redirect_to game_path(@game), notice: 'Roll was deleted.' }
      format.json { render json: game_path(@game), status: :created, location: @roll }
    end
  end
  
end
