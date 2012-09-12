CommishApp::Application.routes.draw do
  devise_for :users

  resources :players, only: [ :index, :show ]
  resources :weeks,   only: [ :index, :show ]
  resources :fantasy_teams, :fantasy_leagues

  root :to => "home#index"
end
