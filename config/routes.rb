Rails.application.routes.draw do
  resources :advertisments
  post 'auth/login' => 'user_token#create'
  get 'users/me' => 'users#me'
  resources :users, :company
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
