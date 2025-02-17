class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.page(params[:page]).per(7)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end
end
