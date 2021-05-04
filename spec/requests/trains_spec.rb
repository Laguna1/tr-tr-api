require 'rails_helper'

RSpec.describe 'Trains API', type: :request do
  # initialize test data
  let!(:trains) { create_list(:train, 10) }
  let(:train_id) { trains.first.id }

  # Test suite for GET /trains
  describe 'GET /trains' do
    # make HTTP get request before each example
    before { get '/trains' }

    it 'returns trains' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /trains/:id
  describe 'GET /trains/:id' do
    before { get "/trains/#{train_id}" }

    context 'when the record exists' do
      it 'returns the train' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(train_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:train_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Train/)
      end
    end
  end

  # Test suite for POST /trains
  describe 'POST /trains' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', description: 'Lorem lorem' } }

    context 'when the request is valid' do
      before { post '/trains', params: valid_attributes }

      it 'creates a train' do
        expect(json['name']).to eq('Learn Elm')
        expect(json['description']).to eq('Lorem lorem')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/trains', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /trains/:id
  describe 'PUT /trains/:id' do
    let(:valid_attributes) { { name: 'Running' } }

    context 'when the record exists' do
      before { put "/trains/#{train_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /trains/:id
  describe 'DELETE /trains/:id' do
    before { delete "/trains/#{train_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
