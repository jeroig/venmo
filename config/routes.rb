# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :user, only: [] do
        member do
          post :payment
          get  :feed
          get  :balance
        end
      end
    end
  end
end
