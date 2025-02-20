class Public::NotificationsController < ApplicationController
  before_action :ensure_guest_user, only: [:index, :destroy_all]

  def index
    @notifications = current_user.passive_notifications
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path, notice: "All notifications have been deleted."
  end

  private

  def ensure_guest_user
    if current_user.guest?
      flash[:notice] = "Guest users cannot perform this action."
      redirect_to posts_path
    end
  end
end
