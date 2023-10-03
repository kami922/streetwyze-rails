Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "survey", to: "surveys#new"
  post "survey", to: "surveys#create"
  # resources :surveys

  get "new_release",to: 'surveys#new_release', as: :new_release

  delete "logout", to: "sessions#destroy"


  resources :posts do
    collection do
      get :filter
    end
  end


  resources :posts do
    resources :stories, only: [:new, :create] # Nested routes for stories under posts
  end



  root to: "main#index"

end


