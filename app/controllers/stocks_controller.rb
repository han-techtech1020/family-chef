class StocksController < ApplicationController
   # ログインしていないと見れないようにする（Deviseの機能）
  before_action :authenticate_user!
   # update, destroy, edit のときに @stock をセットする
  before_action :set_stock, only: [:edit, :update, :destroy]

  def index
    # 在庫を取得し、さらに「食材のカテゴリー」でグループ化する
    @grouped_stocks = current_user.stocks.includes(:ingredient)
                                  .order(:expiration_date)
                                  .group_by { |stock| stock.ingredient.category }
                                  
    # カテゴリーの表示順序を固定したい場合（野菜→肉→魚...）
    @category_order = ["野菜", "肉", "魚介", "卵・乳製品", "大豆・加工品", "調味料", "乾物・粉類"]
  end

  def new
    @stock = Stock.new
    # カテゴリーでグループ化して取得
    # { "野菜" => [人参, 玉ねぎ...], "肉" => [豚肉, 牛肉...] } の形にする
    @ingredients = Ingredient.all.group_by(&:category)
  end

  def create
    # ログインユーザーに紐付いた在庫として作成
    @stock = current_user.stocks.new(stock_params)
    
    if @stock.save
      redirect_to stocks_path, notice: "冷蔵庫に食材を追加しました！"
    else
      # エラー時はもう一度入力画面へ（食材リストも再取得）
      @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @stock は before_action でセット済み
    # 食材名を表示したいので ingredient も取得
  end

  def update
    if @stock.update(stock_params)
      redirect_to stocks_path, notice: "在庫を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.destroy
    redirect_to stocks_path, notice: "食材を使い切りました"
  end

  private

  def set_stock
    @stock = current_user.stocks.find(params[:id])
  end

  def stock_params
    # ingredient_id（食材のID）と quantity（個数）, expiration_date（期限）,storage（保存場所） を許可
    params.require(:stock).permit(:ingredient_id, :quantity, :expiration_date, :storage)
  end
end
