class Public::PermitsController < ApplicationController
  
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
end
