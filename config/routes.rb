require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  resource :plains, only: [:index], defaults: { format: :json } do
    get :take_off
  end
  resource :airfields, only: :show

  root 'airfields#show'
end
