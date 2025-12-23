Rails.application.routes.draw do
  devise_for :users
  root to: "stocks#index" # トップページを冷蔵庫の中身にする
  resources :stocks, only: [:index, :new, :create, :destroy]
end
