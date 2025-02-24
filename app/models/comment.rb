class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length: {maximum:250}

  after_create :create_notification_comment

  private

  def create_notification_comment
    if self.user.id != self.post.user.id
      Notification.create(
        visitor_id: self.user.id,
        visited_id: self.post.user.id,
        comment_id: self.id,
        action: 'comment'
      )
    end
  end
end
