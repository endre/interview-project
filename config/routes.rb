Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, format: :json do
    namespace :frontend do
      resources :weather, only: %i[index] do
        collection do
          post :refresh
        end
      end
    end
  end

  resources :locations, only: %i[new create]
  root to: 'weather#index'
end
