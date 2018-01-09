class User < ApplicationRecord
  enum sex: %i(male female).freeze
  LIST_PERMIT_USER = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true,
   length: {maximum: Settings.user_model.name_max}
  validates :email, presence: true,
   length: {maximum: Settings.user_model.email_max},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
   length: {minimum: Settings.user_model.password_min}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
