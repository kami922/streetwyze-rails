Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get "survey", to: "surveys#new"
  # post "survey", to: "surveys#create"
  resources :surveys
  get "new_release",to: 'surveys#new_release', as: :new_release



  # resources :posts do
  #   collection do
  #     get :filter
  #   end
  # end


  resources :posts do
    resources :stories, only: [:new, :create] # Nested routes for stories under posts
  end

  resources :stories, only: [] do
    collection do
      get :export, format: :csv
    end
  end

  get "assets", to: "main#index", type: "assets"
  get "stories", to: "main#index", type: "stories"
  post "filter_main_index", to: "main#index", as: :filter_main_index


  root to: "main#index"

end


