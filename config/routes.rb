Rails.application.routes.draw do
  root 'static_page#home'
  get '/about' => 'static_page#about'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users
  resources :videos,only: [:new,:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
