require 'rails_helper'

RSpec.describe 'Todo List API', type: :request, elasticsearch: true do

  let(:user) { create(:user) }
  let!(:lists) { create_list(:list, 10, created_by: user.id) }
  let(:list_id) { lists.first.id }
  let(:headers) { valid_headers }

  describe 'GET /lists' do
    before { get '/lists', {}, headers }

    it 'should return todo lists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/lists/#{list_id}", {}, headers }

    context 'when the record exists' do
      it 'should return a list' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(list_id)
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record not exists' do
      let(:list_id) { 123 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
        expect(json['message']).to eq("Couldn't find List with 'id'=123")
      end
    end
  end

  describe 'POST /list' do

    context 'when params is valid' do

      before { post '/lists', {title: 'Test', created_by: user.id.to_s}.to_json, headers }

      it 'should create a list' do
        expect(response).to have_http_status(200)
        expect(json['title']).to eq('Test')
      end
    end

    context 'when params is invalid' do
      before { post '/lists', {}.to_json, headers }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Validation failed: Title can't be blank")
      end
    end
  end

  describe 'PUT /lists/:id' do
    let(:update_params) { {title: 'LalaLand'}.to_json }

    context 'when record is available' do
      before { put "/lists/#{list_id}", update_params, headers }

      it 'should update the record and return 204 status code' do
        expect(response.body).to be_empty
        expect(response).to have_http_status(204)
      end
    end

    context 'when record is not available' do
      before { put "/lists/123", update_params, headers }

      it 'should return 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    it 'should return 204 status code' do
      delete "/lists/#{list_id}", {}, headers
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET /lists/search' do
    it 'should return lists' do
      get "/lists/search?query=list", {}, headers
      expect(response).to have_http_status(200)
    end
  end

end