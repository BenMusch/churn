Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root to: "links#new"

  resources :links, only: %i[new create]
end
