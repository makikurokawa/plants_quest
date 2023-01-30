class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: current_user.id)
    @current_user = current_user
    @posts = @user.posts.all
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def confirm
    @user = current_user
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
