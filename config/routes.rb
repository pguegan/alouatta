Alouatta::Application.routes.draw do
  match "/:id" => "custom#show"
  resources :stations, only: [:index, :show] do
    member do
      get :status
      get :link
    end
  end
  root to: "stations#index"
end
