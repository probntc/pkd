class User < ApplicationRecord
  enum sex: %i(male, female).frezze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save downcase_email

  validates :name,  presence: true,
   length: {maximum: Settings.user_model.name_max}
  validates :email, presence: true,
   length: {maximum: Settings.user_model.email_max},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
   length: {minimum: Settings.user_model.password_min}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
