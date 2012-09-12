CommishApp::Application.routes.draw do
  devise_for :users

  resources :players, only: [ :index, :show ]
  resources :weeks,   only: [ :index, :show ]
  resources :fantasy_teams do
    member do
      get :update_roster, path: 'update-roster'
    end
  end
  resources :fantasy_leagues do
    member do
      get :update_rosters, path: 'update-rosters'
    end
  end

  root :to => "home#index"
end
