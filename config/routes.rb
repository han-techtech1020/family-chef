Rails.application.routes.draw do
  get 'family_members/index'
  get 'family_members/new'
  get 'family_members/create'
  get 'family_members/edit'
  get 'family_members/update'
  get 'family_members/destroy'
  devise_for :users
  root to: "stocks#index" # トップページを冷蔵庫の中身にする
  resources :stocks, only: [:index, :new, :create, :destroy]
end
