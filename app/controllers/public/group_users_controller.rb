class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy
    redirect_to request.referer
  end

  def destroy
    @group = Group.find(params[:group_id])
    if params[:permit_id].present?
      @permit = Permit.find(params[:permit_id])
      @permit.destroy
      flash[:alert] = "Request has been rejected."
    else
      group_user = current_user.group_users.find_by(group_id: @group.id)
      group_user.destroy
      flash[:notice] = "You have left the group."
    end
    redirect_to request.referer
  end
end
