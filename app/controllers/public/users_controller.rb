class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to users_my_page_path
  end

  def confirm
  end

  def destroy
    user = current_user
    user.update(is_deleted: true)
    sign_out current_user
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :nickname, :introduction, :password, :email)
    end
end
