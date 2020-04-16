class UserMailer < ApplicationMailer

  layout 'user_mailer/welcome_mail'

  def welcome_mail(user)
    @user = user
    mail(to: @user['email'], subject: "Welcome to todo app")
  end
end
