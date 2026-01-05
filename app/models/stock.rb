class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient

  # デフォルトは「冷蔵(fridge)」にしておくと便利
  enum :storage, { fridge: 0, freezer: 1, room: 2 }

  # 日本語化のためのメソッド（ビューで使う）
  def storage_text
    case storage
    when "fridge" then "冷蔵"
    when "freezer" then "冷凍"
    when "room"    then "常温"
    end
  end
end
