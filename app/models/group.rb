class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: "owner_id"
  has_many :users, through: :group_users, source: :user
  has_many :permits, dependent: :destroy

  validates :name, length: {minimum:1,maximum:20}
  validates :introduction, presence: true

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end
