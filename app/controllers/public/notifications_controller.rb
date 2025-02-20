class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path, notice: "All notifications have been deleted."
  end
end
