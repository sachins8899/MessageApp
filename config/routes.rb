Rails.application.routes.draw do
  root 'roots#new'
  get 'login',to: 'sessions#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
