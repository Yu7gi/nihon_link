class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: "owner_id"
  has_many :users, through: :group_users, source: :user
  has_many :permits, dependent: :destroy

  validates :name, presence: true, length: {maximum:35}
  validates :introduction, presence: true, length: {maximum:235}

  #オーナー設定
  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

  # 検索機能設定
  def self.looks(word)
    @group = Group.where("name LIKE?", "%#{word}%")
  end
end
