Rails.application.routes.draw do

  devise_for :users

  resources :books, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:new, :index, :show, :edit, :create, :update]

root to: "homes#top"
get "/home/about" => "homes#about", as: "about"
end
