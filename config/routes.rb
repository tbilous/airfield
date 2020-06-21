require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  resources :plains, only: [:index], defaults: { format: :json } do
    post :take_off
  end

  resource :airfields, only: :show do
    post :init
  end

  root 'airfields#show'
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
end
