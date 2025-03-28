class Public::MessagesController < ApplicationController
  before_action :reject_guest_user

  def index
    @rooms = current_user.rooms.includes(:messages).page(params[:page]).per(10)
    @rooms.each do |room|
      partner = room.users.where.not(id: current_user.id).first
      if partner.nil?
        room.destroy
      end
    end
  end

  def show
    @user = User.find(params[:id])

    if current_user.id == @user.id
      redirect_to messages_path, alert: "You cannot view your own messages."
      return
    end

    rooms = current_user.room_users.pluck(:room_id)
    room_users = RoomUser.find_by(user_id: @user.id, room_id: rooms)
    unless room_users.nil?
      @room = room_users.room
    else
      @room = Room.new
      @room.save
      RoomUser.create(user_id: current_user.id, room_id: @room.id)
      RoomUser.create(user_id: @user.id, room_id: @room.id)
    end
    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      render :create
    else
      render :validate
    end
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy
  end

  private

  def reject_guest_user
    if current_user.guest?
      flash[:alert] = "Guest users cannot access the DM feature."
      redirect_to mypage_users_path
    end
  end

  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end
