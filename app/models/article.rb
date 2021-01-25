class Article < ApplicationRecord
  include Visible
  include DateAccessor
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

end