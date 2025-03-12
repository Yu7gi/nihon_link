class Public::NotificationsController < ApplicationController
  before_action :ensure_guest_user, only: [:index, :destroy_all]

  def index
    @notifications = current_user.passive_notifications
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    case @notification.action
    when "dm"
      message = Message.find_by(id: @notification.message_id)
      redirect_to message_path(message.user_id)
    when "comment"
      redirect_to post_path(@notification.comment.post_id)
    end
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
