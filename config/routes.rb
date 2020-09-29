Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :users, only: [:create]
      post "/login", to: "users#login"
      post "/auto_login", to: "users#auto_login"
      resources :posts
    end
  end
  match '*path', :to => 'application#routing_error', via: :all
end
