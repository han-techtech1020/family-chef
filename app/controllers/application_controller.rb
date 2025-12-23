class ApplicationController < ActionController::Base
   # Deviseのコントローラーを使う時だけ、パラメータ設定を許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # サインアップ時(:sign_up)に、nickname も許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
