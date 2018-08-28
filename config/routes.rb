Rails.application.routes.draw do
  match '*all', to: proc { [204, {}, ['']] }, via: :options
  defaults format: :json do  
    post 'auth/login' => 'user_token#create'
    get 'users/me' => 'users#me'
    resources :users, :advertisements
    resources :company do ||
      resources :photos
    end
    resources :subscriptions
    resources :plans
    post 'webhook' => 'webhook#create'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
