# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :rooms, only: %i[ show ]

  get '/join', to: 'user_session#new'
  post 'join', to: 'user_session#create'

  root 'home#index'
end
