Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "signup", to: "registrations#new"
  # post "signup", to: "registrations#create"

  # get "signin", to: "sessions#new"
  # post "signin", to: "sessions#create"

  # get "password", to: "profiles#edit" ,as: :edit_password
  # patch "password", to: "profiles#update"

  get "survey", to: "surveys#new"
  post "survey", to: "surveys#create"

  get "new_release",to: 'surveys#new_release', as: :new_release

  delete "logout", to: "sessions#destroy"



  resources :posts do
    collection do
      get :filter
    end
  end


  root to: "posts#index"

end


