require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome mail' do
    it 'should contain proper mail message with sender mail' do
      mail = described_class.welcome_mail({name: 'test-user', email: 'test@gmail.com'}.with_indifferent_access)
      expect(mail.to).to eq(['test@gmail.com'])
      expect(mail.from).to eq(['test123@gmail.com'])
      expect(mail.subject).to eq('Welcome to todo app')
    end
  end
end
