CommishApp::Application.routes.draw do
  devise_for :users

  resources :players, only: [ :index, :show ]

  root :to => "home#index"
end
