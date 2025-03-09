require 'rails_helper'

RSpec.describe 'Settlement', type: :request do
  let(:accept) { 'application/vnd.billsplitter.com; version=1' }
  let(:content_type) { 'application/json' }
  let(:headers) do
    {
      'Accept' => accept,
      'Content-Type' => content_type,
      'Authorization' => @user ? JwtService.encode({ id: @user.id }) : ''
    }
  end

  before(:each) do
    @user = create(:user)
    @settlement = create(:settlement, payer: @user)
  end

  describe 'POST /settlements' do
    let(:payee) { create(:user) }
    let(:valid_attributes) { { payee_id: payee.id } }

    context 'with valid parameters' do
      it 'creates a new settlement' do
        expect do
          post '/settlements', params: { settlement: valid_attributes }, headers: headers
        end
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { {} }

      it 'does not create a new settlement' do
        expect do
          post '/settlements', params: { settlement: invalid_attributes }, headers: headers
        end
      end

      it 'returns an unprocessable entity status' do
        post '/settlements', params: { settlement: invalid_attributes }, headers: headers
        expect(response).to have_http_status(400)
      end

      it 'returns an error message' do
        post '/settlements', params: { settlement: invalid_attributes }, headers: headers
        response_body = JSON.parse(response.body)
        expect(response_body['errors']).to be_present
      end
    end
  end

  describe 'DELETE /settlements/:id' do
    context 'when the settlement exists' do
      it 'deletes the settlement' do
        expect do
          delete "/settlements/#{@settlement.id}", headers: headers
        end.to change(Settlement, :count).by(-1)
      end

      it 'returns a successful response' do
        delete "/settlements/#{@settlement.id}", headers: headers
        expect(response).to have_http_status(200)
      end
    end

    context 'when the settlement does not exist' do
      let(:non_existent_settlement_id) { 9999 }

      it 'returns a not found status' do
        delete "/settlements/#{non_existent_settlement_id}", headers: headers
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        delete "/settlements/#{non_existent_settlement_id}", headers: headers
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.destroy.invalid', item: 'Settlement'))
      end
    end
  end

  describe 'GET /settlements' do
    context 'when fetching a list of settlements' do
      before { get '/settlements', headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns a list of settlements' do
        response_body = JSON.parse(response.body)
        expect(response_body['data']).to be_an_instance_of(Array)
      end
    end
  end

  describe 'GET /settlements/:id' do
    context 'when the settlement exists' do
      before { get "/settlements/#{@settlement.id}", headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns the settlement details' do
        response_body = JSON.parse(response.body)
        expect(response_body['data']['id']).to eq(@settlement.id)
      end
    end

    context 'when the settlement does not exist' do
      let(:non_existent_settlement_id) { 9999 }

      before { get "/settlements/#{non_existent_settlement_id}", headers: headers }

      it 'returns a not found status' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.show.invalid', item: 'Settlement'))
      end
    end
  end
end
