# 開発環境なら、データをリセットしてから投入（IDズレ防止のため、本番では注意）
if Rails.env.development?
  RecipeIngredient.destroy_all
  Stock.destroy_all
  Ingredient.destroy_all
end

# カテゴリーごとの食材リスト
ingredients_data = {
  "野菜" => %w[キャベツ 人参 玉ねぎ じゃがいも レタス トマト きゅうり ほうれん草 小松菜 白菜 大根 ねぎ ピーマン なす ブロッコリー かぼちゃ ごぼう れんこん もやし 生姜 にんにく アボカド],
  "肉" => %w[豚バラ肉 豚こま肉 豚ひき肉 鶏もも肉 鶏むね肉 鶏ささみ 鶏ひき肉 牛バラ肉 牛こま肉 牛ひき肉 合い挽き肉 ハム ベーコン ソーセージ],
  "魚介" => %w[鮭 鯖 ぶり あじ さんま 鯛 マグロ えび いか たこ あさり シーフードミックス ツナ缶],
  "卵・乳製品" => %w[卵 牛乳 ヨーグルト チーズ バター 生クリーム 豆乳],
  "大豆・加工品" => %w[豆腐 油揚げ 納豆 厚揚げ こんにゃく ちくわ かまぼこ],
  "乾物・粉類" => %w[パスタ うどん そば 米 パン粉 小麦粉 片栗粉 海苔 わかめ かつお節],
  "調味料" => %w[醤油 味噌 塩 砂糖 酢 みりん 料理酒 マヨネーズ ケチャップ ソース オリーブオイル ごま油 コンソメ 中華だし 和風だし カレー粉]
}

ingredients_data.each do |category, names|
  names.each do |name|
    Ingredient.find_or_create_by!(name: name, category: category)
  end
end

puts "食材マスタの投入が完了しました！(合計: #{Ingredient.count}件)"
