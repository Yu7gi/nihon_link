class Public::GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def index
    @group = Group.new
    @groups = Group.page(params[:page]).per(7)
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, method: :post
    else
      @groups = Group.page(params[:page]).per(7)
      render :index
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page]).per(10)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      flash[:notice] = "Only the group owner can perform this action."
      redirect_to groups_path
    end
  end
end
