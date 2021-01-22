# The User model
class User < ApplicationRecord
  attr_accessor :old_password

  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :followers,
                          class_name: 'User',
                          join_table: 'followers',
                          foreign_key: "followed_id",
                          association_foreign_key: "follower_id"

  has_secure_password # password_digest field needs to be encrypted
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, on: :create
  validates :password, confirmation: true, on: :create
  validates :password, confirmation: true, unless: -> { password.blank? }, on: :update
  validate :correct_old_password?, on: :update

  def correct_old_password?
    # For some unknown reason self.authenticate always return false,
    # so it is necessary to re-instantiate a fresh model of the user
    errors.add(:old_password, :invalid, message: 'Incorrect password') unless User.find(id).authenticate(old_password)
  end

  # Allow this user to follow another user
  def follow(user)
    user.followers << self
  end

  # Allow another user to follow self
  def add_follower(user)
    followers << user
  end

  # Allow this user to unfollow another user
  def unfollow(user)
    user.followers.delete(self)
  end

  # Allow another user to unfollow self
  def delete_follower(user)
    followers.delete(user)
  end

  # Know if the user passed as parameter is a follower of self
  def followed?(user)
    followers.include?(user)
  end

  # Know if self is a follower of the param user
  def follower?(user)
    user.followers.include?(self)
  end

end
