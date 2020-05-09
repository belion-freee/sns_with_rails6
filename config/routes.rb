Rails.application.routes.draw do
  resources :blogs do
    resources :comments, only: %w[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
