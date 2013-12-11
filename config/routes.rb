Alouatta::Application.routes.draw do
  resources :stations, only: [:index, :show] do
    member do
      get :status
      get :link
      get :mini
    end
  end
  get "/", to: "custom#show", defaults: {id: "riffx"}, constraints: {subdomain: "riffx"}
  get "/:id", to: "custom#show"
  root to: "stations#index"
end
