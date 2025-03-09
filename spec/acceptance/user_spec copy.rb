require 'rails_helper'

RSpec.describe 'User', type: :request do
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
  end

  describe 'GET /users' do
    context 'when fetching a list of users' do
      before { get '/users', headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /users/:id' do
    context 'when the user exists' do
      before { get "/users/#{@user.id}", headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user details' do
        response_body = JSON.parse(response.body)
        expect(response_body['data']['id']).to eq(@user.id)
      end
    end

    context 'when the user does not exist' do
      let(:non_existent_user_id) { 9999 }

      before { get "/users/#{non_existent_user_id}", headers: headers }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.show.invalid', item: 'User'))
      end
    end
  end
end
