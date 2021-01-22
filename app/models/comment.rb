class Comment < ApplicationRecord

  include VisibleFeature
  include DateAccessor
  belongs_to :article
  belongs_to :user

  validates_presence_of :body
end
