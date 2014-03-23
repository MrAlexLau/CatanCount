class HomeController < ApplicationController
  def index
    if !session[:user_id].nil? && current_user && !current_user.is_guest?
      redirect_to games_path()
    end
  end
  
  def new_game  
    guest = User.get_guest()
    session[:user_id] = guest.id
    
    new_game = Game.get_new_game(guest.id)
    session[:game_id] = new_game.id
    
    redirect_to game_path(new_game), :action => 'show'
  end
    
end
