class Recipe < ApplicationRecord
  belongs_to :user

  # 中間テーブルとの関係
  has_many :recipe_ingredients, dependent: :destroy
  # 食材との多対多の関係（ここがポイント！）
  has_many :ingredients, through: :recipe_ingredients
end
