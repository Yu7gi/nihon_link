class UsersController < ApplicationController

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to mypage_users_path
  end

  def mypage
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :native, :introduction)
  end
end
