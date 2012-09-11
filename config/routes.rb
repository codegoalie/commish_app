CommishApp::Application.routes.draw do
  resources :players, only: [ :index, :show ]

  root :to => "home#index"
end
