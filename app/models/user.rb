# The User model
class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password # password_digest field needs to be encrypted
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, on: :create
  validates :password, confirmation: true, on: :create
  validates :password, confirmation: true, unless: -> { password.blank? }, on: :update
  validate :correct_old_password?, on: :update

  def correct_old_password?
    # For some unknown reason self.authenticate always return false,
    # so it was necessary to re-instantiate a fresh model of the user
    errors.add(:old_password, :invalid, message: 'Incorrect password') unless User.find(id).authenticate(old_password)
  end

end
