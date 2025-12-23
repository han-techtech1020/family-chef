class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   # 「ユーザーは、たくさんの在庫を持っている」
  has_many :stocks, dependent: :destroy
  # レシピなども
  has_many :recipes, dependent: :destroy
  has_many :family_members, dependent: :destroy
end
