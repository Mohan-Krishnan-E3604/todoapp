require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    context 'When request is valid' do
      it 'returns an authentication token' do
        post '/auth/login', {email: user.email, password: user.password}, headers: headers
        expect(json['authToken']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      it 'returns a failure message' do
        post '/auth/login', {email: "blabla@bla.com", password: "test"}, headers: headers
        expect(json['message']).to match('Invalid credentials')
      end
    end
  end
end