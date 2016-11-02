Rails.application.routes.draw do
  get "/", to: redirect("/docs/index.html")
  post "/auth/login", to: "authentication#login"
  get "/auth/logout", to: "authentication#logout"

  resources :users, except: [:new, :edit, :index]
  namespace :api do
    namespace :v1 do
      resources :bucketlists, except: [:new, :edit] do
        resources :items, except: [:new, :edit]
      end
    end
  end
end
