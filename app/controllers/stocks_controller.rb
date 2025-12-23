class StocksController < ApplicationController
  def index
    # N+1問題対策：食材データも一緒に取ってくる！
    @stocks = current_user.stocks.includes(:ingredient).order(expiration_date: :asc)
  end

  def new
    @stock = Stock.new
    # プルダウンで選べるように、全食材データを取得
    @ingredients = Ingredient.all
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

  def destroy
    stock = current_user.stocks.find(params[:id])
    stock.destroy
    redirect_to stocks_path, notice: "食材を使い切りました"
  end
end
