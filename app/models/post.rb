class Post < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  validates :title, presence: true
  validates :body, presence: true

  # 検索機能設定
  def self.looks(word)
    @post = Post.where("title LIKE?", "%#{word}%")
  end
  
end
