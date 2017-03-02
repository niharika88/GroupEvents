Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "home#index"
  namespace :api do
    namespace :v1 do
      resources :groupevents do
        post :publish, on: :member
      end
    end
  end
end
