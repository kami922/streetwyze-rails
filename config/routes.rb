Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"

  get "password", to: "profiles#edit" ,as: :edit_password
  patch "password", to: "profiles#update"

  get "survey", to: "surveys#new"
  post "survey", to: "surveys#create"

  delete "logout", to: "sessions#destroy"

  root to: "main#index"

end
