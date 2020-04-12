require 'rails_helper'

RSpec.describe 'Items API' do

  let!(:list) { create(:list) }
  let!(:items) { create_list(:item, 10, list_id: list.id) }
  let(:list_id) { list.id }
  let(:id) { items.first.id }

  describe 'GET /lists/:list_id/items/:id' do

    context 'when items available' do
      it 'should return item list' do
        get "/lists/#{list_id}/items"
        expect(json.size).to eq(10)
        expect(response).to have_http_status(200)
      end
    end

    context 'when items not available' do
      it 'should return status code 404' do
        get "/lists/123/items"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /lists/:list_id/items/:id' do
    context 'when list available' do
      it 'should return 200 status' do
        get "/lists/#{list_id}/items/#{id}"
        expect(response).to have_http_status(200)
        expect(json['id']).to eq(id)
      end
    end

    context 'when list data not available' do
      it 'should return 404 status' do
        get '/lists/123/items/123'
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /lists/:list_id/items' do

    context 'when payload is valid' do
      it 'should return 200 status' do
        post "/lists/#{list_id}/items", {name: "Test item"}
        expect(response).to have_http_status(201)
        expect(json['name']).to eq('Test item')
      end
    end

    context 'when payload is not valid' do
      it 'should return 422 status' do
        post "/lists/#{list_id}/items", {}
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Validation failed: Name can't be blank")
      end
    end
  end

  describe 'PATCH /lists/:list_id/items/:id' do
    context 'when record is available' do
      it 'should return 200 status' do
        patch "/lists/#{list_id}/items/#{id}", {completed: true}
        expect(response).to have_http_status(204)
      end
    end
    context 'when record is not available' do
      it 'should return 404 status' do
        patch "/lists/#{list_id}/items/123", {completed: true}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /lists/:list_id/items/:id' do
    context 'when record is available' do
      it 'should return 204' do
        delete "/lists/#{list_id}/items/#{id}"
        expect(response).to have_http_status(204)
      end
    end
  end
end
