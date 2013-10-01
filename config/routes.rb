Alouatta::Application.routes.draw do
  resources :stations, only: [:index, :show] do
    member do
      get :status
      get :link
      get :mini
    end
  end
  match "/:id" => "custom#show"
  root to: "stations#index"
end
