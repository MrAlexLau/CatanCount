class HomeController < ApplicationController
  def index
  end
  
  def new_game  
    session[:game_id] = Roll.get_game_id()
    redirect_to rolls_overview_path(), :action => 'overview'
  end
  
  def existing_game
    session[:game_id] = params[:game_id]
    redirect_to rolls_overview_path(), :action => 'overview'
  end
  
end
