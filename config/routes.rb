Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/join', to: 'user_session#new'
  root 'home#index'
end
