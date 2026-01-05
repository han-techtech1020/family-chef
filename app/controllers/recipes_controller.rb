class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def search
    # 入力画面を表示するだけなので、処理は空でOK
  end

  def generate
    # フォームから送られてきた "request" というパラメータを取得
    user_request = params[:user_request]

    # Serviceを呼ぶとき、第2引数として要望を渡す
    service = MenuGeneratorService.new(current_user, user_request)
    @suggestion = service.call

    # 保存フォーム用に空のインスタンスを用意
    @recipe = Recipe.new

    # 画面表示用に、結果を渡す
    render :generate
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: "献立を保存しました！"
    else
      # エラー時はトップに戻す（簡易対応）
      redirect_to root_path, alert: "保存に失敗しました"
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end
end
