Alouatta::Application.routes.draw do
  resources :stations, only: [:index, :show] do
    member do
      get :status
    end
  end
  root to: "stations#index"
end
