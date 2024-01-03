require 'sidekiq/web'

Rails.application.routes.draw do

  ## Devise/Auth
  # devise_for :users, path_names: { sign_in: 'login', edit: 'profile' }
  devise_for :users

  ## Sidekiq
  # devise_scope :user do
    # authenticate :user, lambda { |user| user.super? } do
      mount Sidekiq::Web => '/sidekiq'
    # end
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static#index"
end
