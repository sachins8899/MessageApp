Rails.application.routes.draw do
  root 'roots#new'
  get 'login',to: 'sessions#login'
  post 'login', to: 'sessions#auth'
  get 'signup', to: 'sessions#signup'
  post 'signup',to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :messages
  
  mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
