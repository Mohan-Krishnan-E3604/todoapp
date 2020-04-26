require 'rails_helper'

RSpec.describe 'Todo List API', type: :request, elasticsearch: true do

  let(:user) { create(:user) }
  let!(:boards) { create_list(:board, 10, user_id: user.id) }
  let(:board_id) { boards.first.id }
  let(:headers) { valid_headers }

  describe 'GET /boards' do
    before { get '/boards', {}, headers }

    it 'should return todo boards' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /boards/:id' do
    before { get "/boards/#{board_id}", {}, headers }

    context 'when the record exists' do
      it 'should return a board' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(board_id)
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record not exists' do
      let(:board_id) { 123 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
        expect(json['message']).to eq("Couldn't find Board with [WHERE \"boards\".\"user_id\" = ? AND \"boards\".\"id\" = ?]")
      end
    end
  end

  describe 'POST /board' do

    context 'when params is valid' do

      before { post '/boards', {name: 'Test', created_by: user.id.to_s}.to_json, headers }

      it 'should create a board' do
        expect(response).to have_http_status(200)
        expect(json['name']).to eq('Test')
      end
    end

    context 'when params is invalid' do
      before { post '/boards', {}.to_json, headers }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Validation failed: Name can't be blank")
      end
    end
  end

  describe 'PUT /boards/:id' do
    let(:update_params) { {name: 'LalaLand'}.to_json }

    context 'when record is available' do
      before { put "/boards/#{board_id}", update_params, headers }

      it 'should update the record and return 204 status code' do
        expect(response.body).to be_empty
        expect(response).to have_http_status(204)
      end
    end

    context 'when record is not available' do
      before { put "/boards/123", update_params, headers }

      it 'should return 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /boards/:id' do
    it 'should return 204 status code' do
      delete "/boards/#{board_id}", {}, headers
      expect(response).to have_http_status(204)
    end
  end

end