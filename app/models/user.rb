class User < ApplicationRecord

  has_secure_token
  has_secure_password
  acts_as_paranoid

  scope :deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  after_create	:send_welcome_mail

  def send_welcome_mail
    UserNotifier.send_signup_email(self)
  end

end
