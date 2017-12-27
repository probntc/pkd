Rails.application.routes.draw do
 get "/static_pages/:page", to: "static_pages#show", as: "static_pages"

 get "/signup", to: "users#new"

 root "static_pages#show", page: "home"
end
