require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UserWelcomeWorker, type: :worker do
  describe '#perform' do
    it 'should call UserMailer welcome method' do
      user = {name: 'test', email: 'test@test.com'}
      message_delivery = instance_double(ActionMailer::MessageDelivery)
      expect(UserMailer).to receive(:welcome_mail).with(user).and_return(message_delivery)
      allow(message_delivery).to receive(:deliver_now)
      described_class.new.perform(user)
    end
  end
end
