require "rails_helper"

RSpec.describe ApplicationController, type: :controller do

  let!(:user) { create(:user) }
  let(:headers) { {'Authorization' => token_generator(user.id)} }
  let(:invalid_headers) { {'Authorization' => nil} }

  describe "#authorize_request" do
    context "when auth token is passed" do
      it "sets the current user" do
        allow(request).to receive(:headers).and_return(headers)
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context "when auth token is not passed" do
      it "raises MissingToken error" do
        allow(request).to receive(:headers).and_return(invalid_headers)
        expect { subject.instance_eval { authorize_request } }.to raise_error(ExceptionHandler::MissingToken, 'Missing token')
      end
    end
  end

  describe '#set_locale' do
    context 'when locale available in url params' do
      it 'should return url param locale' do
        allow(controller).to receive(:params).and_return({locale: 'pt'})
        expect(subject.send(:set_locale)).to eq('pt')
      end
    end
    context 'when locale not available in url params' do
      it 'should return default locale' do
        allow(controller).to receive(:params).and_return({})
        expect(subject.send(:set_locale)).to eq(I18n.default_locale)
      end
    end
    context 'when given locale is not defined in application' do
      it 'should return default locale' do
        allow(controller).to receive(:params).and_return({locale: 'es'})
        expect(subject.send(:set_locale)).to eq(I18n.default_locale)
      end
    end
  end

end