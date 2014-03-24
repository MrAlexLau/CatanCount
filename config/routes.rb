CatanCount::Application.routes.draw do
  get "home/index"
  get "home/new_game"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout


  resources :games do
    resources :rolls
  end

  delete 'games/:id/undo_last_roll' => 'games#undo_last_roll', as: :undo_last_roll

  root :to => 'home#index'
end
