Rails.application.routes.draw do

  root 'help#show'

  get '/help' => 'help#show'

  resources :orders
  resources :products

  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get  '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'

end
