class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :permits, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: {minimum:2,maximum:20}
  validates :native, presence: true

  # ゲストログイン機能設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "Guest"
      user.native = "English"
      user.introduction = "(=^・^=)"
    end
  end

  def guest?
    email == 'guest@example.com'
  end

  # 検索機能設定
  def self.looks(word)
    @user = User.where("name LIKE?", "%#{word}%")
  end
end