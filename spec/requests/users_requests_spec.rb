require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      it 'creates a new user and queue one job in UserWelcomeWorker' do
        post '/signup', valid_attributes, headers: headers
        expect(response).to have_http_status(201)
        expect(json['message']).to match('Account Created Successfully')
        expect(json['auth_token']).not_to be_nil
        expect(UserWelcomeWorker.jobs.size).to eq(1)
      end
    end

    context 'when invalid request' do
      it 'does not create a new user' do
        post '/signup', {}, headers: headers
        expect(response).to have_http_status(422)
        expect(json['message']).to match("Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank")
      end
    end
  end
end