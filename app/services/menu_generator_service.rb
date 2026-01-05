class MenuGeneratorService
  def initialize(user)
    @user = user
    @client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
  end

  def call
    # 1. ユーザーの在庫情報を取得（賞味期限が近い順）
    stocks = @user.stocks.includes(:ingredient).order(:expiration_date).limit(10)

    # Rubyのデータを「文字列」に変換
    # Before: [<Stock id:1...>, <Stock id:2...>] （プログラム用データ）
    # After: "人参 (2個) - 期限:2024-01-01, 豚肉 (300g) - 期限:2024-01-03" （AIが読める文章）
    stock_list = stocks.map { |s| "#{s.ingredient.name} (#{s.quantity}個) - 期限:#{s.expiration_date}" }.join(", ")

    # 2. 家族の情報を取得
    family_members = @user.family_members
    family_status = family_members.map { |f| "#{f.name}: #{f.status} (アレルギー: #{f.allergy_info})" }.join("\n")

    # 3. AIへの命令文（プロンプト）を作成
    prompt = <<~TEXT
      あなたはプロの栄養管理士兼、節約料理研究家です。
      以下の「冷蔵庫の在庫」と「家族の状況」を考慮して、最適な夕食の献立（主菜・副菜）を1つ提案してください。

      【冷蔵庫の在庫（賞味期限が近い順）】
      #{stock_list}

      【家族の状況（考慮必須）】
      #{family_status}

      【条件】
      - 在庫にあるものを優先的に使うこと（食品ロス削減）。
      - 家族のアレルギー食材は絶対に使わないこと。
      - 家族の体調（授乳中など）に合わせた栄養素を含めること。
      - 出力は以下のフォーマットのみを返してください。余計な挨拶は不要です。

      【タイトル】料理名
      【食材】使用する食材リスト
      【説明】なぜこの料理にしたか（栄養と節約の観点から）
    TEXT

    # 4. APIへの送信（Request）
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini", # または gpt-4（賢いが高い）
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    # 5. 返事の取り出し（Response）
    response.dig("choices", 0, "message", "content")
  end
end
