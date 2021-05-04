require 'rails_helper'

RSpec.describe 'Tracks', type: :request do
#  Initialize the test data
  let!(:train) { create(:train) }
  let!(:tracks) { create_list(:track, 20, train_id: train.id) }
  let(:train_id) { train.id }
  let(:id) { tracks.first.id }

  # Test suite for GET /trains/:train_id/tracks
  describe 'GET /trains/:train_id/tracks' do
    before { get "/trains/#{train_id}/tracks" }

    context 'when train exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all train tracks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when train does not exist' do
      let(:train_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Train/)
      end
    end
  end

  # Test suite for GET /trains/:train_id/tracks/:id
  describe 'GET /trains/:train_id/tracks/:id' do
    before { get "/trains/#{train_id}/tracks/#{id}" }

    context 'when train track exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when train track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for PUT /trains/:train_id/tracks
  describe 'POST /trains/:train_id/tracks' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/trains/#{train_id}/tracks", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/trains/#{train_id}/tracks", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /trains/:train_id/tracks/:id
  describe 'PUT /trains/:train_id/tracks/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/trains/#{train_id}/tracks/#{id}", params: valid_attributes }

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_track = Track.find(id)
        expect(updated_track.name).to match(/Mozart/)
      end
    end

    context 'when the track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for DELETE /trains/:id
  describe 'DELETE /trains/:id' do
    before { delete "/trains/#{train_id}/tracks/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
