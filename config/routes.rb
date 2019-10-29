Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do

    post "/sessions" => "sessions#create"
    
    # get "/users" => "users#index"
    get "/users/me" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    get "/bookings" => "bookings#index"
    get "/bookings/:id" => "bookings#show"
    # post "/bookings" => "bookings#create"
    # patch "/bookings/:id" => "bookings#update"
    delete "/bookings/:id" => "bookings#destroy"

    get "/cravings" => "cravings#index"
    # get "/cravings/:id" => "cravings#show"
    post "/cravings" => "cravings#create"
    patch "/cravings/:id" => "cravings#update"
    delete "/cravings/:id" => "cravings#destroy"
  end
end
