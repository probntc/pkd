class User < ApplicationRecord
  enum sex: %i(male female).freeze
  LIST_PERMIT_USER = %i(name email password password_confirmation sex).freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_reader :remember_token

  validates :name,  presence: true,
   length: {maximum: Settings.user_model.name_max}
  validates :email, presence: true,
   length: {maximum: Settings.user_model.email_max},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_blank: true,
   length: {minimum: Settings.user_model.password_min}

  has_secure_password

  before_save :downcase_email

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def authenticated? remember_token
    return false if remember_digest.blank?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def current_user? current_user
    self == current_user
  end

  private

  def downcase_email
    email.downcase!
  end
end
