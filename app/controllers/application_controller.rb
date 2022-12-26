class ApplicationController < ActionController::Base
  def check_guest
    email = resource&.email || params[:public][:email].dowucase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは更新・削除はできません。'
    end
  end
end
