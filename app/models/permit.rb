class Permit < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :notifications, dependent: :destroy

  after_create :create_notification_permit

  private

  def create_notification_permit
    Notification.create(
      visitor_id: self.user.id,
      visited_id: self.group.owner_id,
      permit_id: self.id,
      action: 'group_request'
    )
  end
end
