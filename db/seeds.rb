# 既存データをクリア（開発用）
Ingredient.destroy_all

# 野菜
Ingredient.create!([
  { name: 'キャベツ', category: '野菜' },
  { name: '人参', category: '野菜' },
  { name: '玉ねぎ', category: '野菜' },
  { name: 'じゃがいも', category: '野菜' }
])

# 肉
Ingredient.create!([
  { name: '豚肉', category: '肉' },
  { name: '鶏肉', category: '肉' },
  { name: '牛肉', category: '肉' }
])

# 調味料など
Ingredient.create!([
  { name: '醤油', category: '調味料' },
  { name: '味噌', category: '調味料' },
  { name: '卵', category: '卵・乳製品' }
])

puts "初期データの投入に成功しました！"