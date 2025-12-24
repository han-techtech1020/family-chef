class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end
  
  def generate
    # AIサービスを呼び出す
    service = MenuGeneratorService.new(current_user)
    @suggestion = service.call
    
    # 画面表示用に、結果を渡す
    render :generate
  end
end
