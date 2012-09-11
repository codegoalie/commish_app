CommishApp::Application.routes.draw do
  root :to => "home#index"

  resources :players, only: [ :index, :show ]
end
