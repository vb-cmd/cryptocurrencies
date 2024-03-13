Rails.application.routes.draw do
  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :coin do
        resources :coins, only: %i[index] do
          resource :histories, only: %i[show]
        end
      end
    end
  end
end
