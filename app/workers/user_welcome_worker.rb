class UserWelcomeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user)
    UserMailer.welcome_mail(user).deliver_now
  end
end
