class Ingredient < ApplicationRecord
  has_many :stocks
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
end
