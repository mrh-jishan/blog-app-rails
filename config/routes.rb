Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :users, only: [:create]
      post '/login', to: 'users#login'
      get '/current_user', to: 'users#current_user'
      resources :posts
    end
  end
  match '*path', :to => 'application#routing_error', via: :all
end
