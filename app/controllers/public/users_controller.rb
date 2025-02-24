class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]

  def show
    @posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User information edited successfully'
      redirect_to mypage_users_path
    else
      render :edit
    end
  end

  def mypage
    @user = User.find(current_user.id)
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def destroy
    @user.destroy
    flash[:notice] = 'Account Successfully Deleted'
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :native, :introduction, :email)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_users_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_guest_user
    if current_user.guest?
      flash[:notice] = "Guest users cannot perform this action."
      redirect_to posts_path
    end
  end
end
