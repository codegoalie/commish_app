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
  match "injuries/update-all/:week" => 'injuries#update_all', as: :update_all_injuries
  match "injuries(/:week)" => 'injuries#index', as: :injuries

  root :to => "home#index"
end
