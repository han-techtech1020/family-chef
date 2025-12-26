Rails.application.routes.draw do
  devise_for :users
  root to: "stocks#index" # トップページを冷蔵庫の中身にする
  resources :stocks, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :family_members, only: [:index, :new, :create, :edit, :update, :destroy]
  # AI提案用のルートを追加
  resources :recipes, only: [:index, :create] do
    collection do
      get :generate # カスタムアクション：「AI提案画面」を表示
    end
  end
end
