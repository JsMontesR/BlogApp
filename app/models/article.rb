class Article < ApplicationRecord
  include VisibleFeature
  include DateAccessor
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # Comparison between articles
  def equals?(article)
    article.title == title && article.body == body && article.status == status && article.user == user
  end
end
