
Rails.application.routes.draw do


  # GoodJob
  authenticate :user, ->(user) { user.super? } do
    mount GoodJob::Engine => 'good_job'
  end

  ## Devise/Auth
  # devise_for :users, path_names: { sign_in: 'login', edit: 'profile' }
  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static#index"

  get 'dashboard', to: 'dashboard#index'
  post 'trigger_sample_job', to: 'dashboard#trigger_sample_job', as: 'dashboard_trigger_sample_job'

  post '/stripe/webhooks', to: 'stripe#webhooks'
end
