class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
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

  # 検索機能設定
  def self.looks(word)
    @user = User.where("name LIKE?", "%#{word}%")
  end

end