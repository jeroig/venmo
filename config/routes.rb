# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      post 'user/:id/payment', to: 'users#payment', as: 'payment'
      get  'user/:id/feed', to: 'users#feed', as: 'feed'
      get  'user/:id/balance', to: 'users#balance', as: 'balance'
    end
  end
end
