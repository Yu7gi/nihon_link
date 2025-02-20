class Public::PermitsController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]
  
  def create
    @group = Group.find(params[:group_id])
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    flash[:notice] = "Your join request has been sent successfully."
    redirect_to request.referer
  end

  def destroy
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    flash[:alert] = "Your join request has been canceled."
    redirect_to request.referer
  end

  private

  def ensure_guest_user
    if current_user.guest?
      flash[:notice] = "Guest users cannot perform this action."
      redirect_to posts_path
    end
  end
end
