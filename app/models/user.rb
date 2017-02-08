class User < ApplicationRecord

  has_secure_token
  has_secure_password
  acts_as_paranoid

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

end
