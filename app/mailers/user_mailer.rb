class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("user_mailer.account_activation.activation")
  end

  def password_reset
    @greeting = t("user_mailer.accout_activation.greeting")
    @user = user
    mail to: user.mail, subject: t("user_mailer.accout_activation.password_reset")
  end
end
