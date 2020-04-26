require 'rails_helper'
require 'redis'

RSpec.describe 'Items API' do
  include RedisHelper

  let(:user) { create(:user) }
  let(:board) { create(:board) }
  let!(:list) { create(:list, created_by: user.id, board_id: board.id) }
  let!(:items) { create_list(:item, 10, list_id: list.id, user_id: user.id) }
  let(:list_id) { list.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  describe 'GET /items/:id' do

    context 'when items available' do
      it 'should return item list' do
        get "/items", {}, headers
        expect(json.size).to eq(10)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /items/:id' do
    context 'when list available' do
      it 'should return 200 status' do
        get "/items/#{id}", {}, headers
        expect(response).to have_http_status(200)
        expect(json['id']).to eq(id)
      end
    end

    context 'when list data not available' do
      it 'should return 404 status' do
        get '/items/123', {}, headers
        expect(response).to have_http_status(404)
      end
    end

    context 'use redis cache if available' do
      it 'should return item' do
        expect(REDIS).to receive(:get).with(todo_item_key(id)).and_return(items.first.to_json)
        expect(REDIS).not_to receive(:setex)
        get "/items/#{id}", {}, headers
      end
    end

    context 'use db cache is not available' do
      it 'should set redis cache' do
        expect(REDIS).to receive(:setex).with(todo_item_key(id), 10.hour.to_i, items.first.to_json)
        get "/items/#{id}", {}, headers
      end
    end

  end

  describe 'POST /items' do

    context 'when payload is valid' do
      it 'should return 200 status' do
        post "/items", {name: "Test item", listId: list_id}.to_json, headers
        expect(response).to have_http_status(201)
        expect(json['name']).to eq('Test item')
      end
    end

    context 'when payload is not valid' do
      it 'should return 422 status' do
        post "/items", {listId: list_id}.to_json, headers
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Validation failed: Name can't be blank")
      end
    end
  end

  describe 'PATCH /items/:id' do
    context 'when record is available' do
      it 'should return 200 status' do
        patch "/items/#{id}", {listId: list_id, completed: true}.to_json, headers
        expect(response).to have_http_status(204)
      end
    end
    context 'when record is not available' do
      it 'should return 404 status' do
        patch "/items/123", {completed: true}.to_json, headers
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /items/:id' do
    context 'when record is available' do
      it 'should return 204' do
        delete "/items/#{id}", {}, headers
        expect(response).to have_http_status(204)
      end
    end
  end
end
