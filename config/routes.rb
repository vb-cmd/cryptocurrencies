Rails.application.routes.draw do
  root 'coins#index'

  # api
  namespace :api do
    namespace :v1 do
      namespace :coin do
        resources :coins, only: %i[index] do
          resources :histories, only: %i[index]
        end
      end
    end
  end

  # devise
  devise_for :users
end
