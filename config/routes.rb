Rails.application.routes.draw do
  get 'recipes/index'
  devise_for :users
  root to: "stocks#index" # トップページを冷蔵庫の中身にする
  resources :stocks, only: [:index, :new, :create, :destroy]
  resources :family_members, only: [:index, :new, :create, :edit, :update, :destroy]
  # AI提案用のルートを追加
  resources :recipes, only: [:index, :create] do
    collection do
      get :generate # 「AIで提案する」画面
    end
  end
end
