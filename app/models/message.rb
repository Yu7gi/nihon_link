class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_many :notifications, dependent: :destroy

  validates :message, presence: true

  after_create :create_notification_message

  def create_notification_message
    recipient = room.users.where.not(id: user.id).first

    Notification.create(
      visitor_id: self.user.id,
      visited_id: recipient.id,
      message_id: self.id,
      action: 'dm'
    )
  end
end
