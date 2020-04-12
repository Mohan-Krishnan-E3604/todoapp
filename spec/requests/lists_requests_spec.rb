require 'rails_helper'

RSpec.describe 'Todo List API', type: :request do

  let!(:lists) { create_list(:list, 10) }
  let(:list_id) { lists.first.id }

  describe 'GET /lists' do
    before { get '/lists' }

    it 'should return todo lists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/lists/#{list_id}" }

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

      before { post '/lists', {title: 'Test', created_by: '123'} }

      it 'should create a list' do
        expect(response).to have_http_status(200)
        expect(json['title']).to eq('Test')
      end
    end

    context 'when params is invalid' do
      before { post '/lists', {title: 'blabla'} }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Validation failed: Created by can't be blank")
      end
    end
  end

  describe 'PUT /lists/:id' do
    let(:update_params) { {title: 'LalaLand'} }

    context 'when record is available' do
      before { put "/lists/#{list_id}", update_params }

      it 'should update the record and return 204 status code' do
        expect(response.body).to be_empty
        expect(response).to have_http_status(204)
      end
    end

    context 'when record is not available' do
      before { put "/lists/123", update_params }

      it 'should return 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    it 'should return 204 status code' do
      delete "/lists/#{list_id}"
      expect(response).to have_http_status(204)
    end
  end
end