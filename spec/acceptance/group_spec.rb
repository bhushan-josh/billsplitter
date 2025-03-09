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
    @group = create(:group)
  end

  describe 'GET /groups' do
    context 'when fetching a list of groups' do
      before { get '/groups', headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /groups/:id' do
    context 'when the group exists' do
      before { get "/groups/#{@group.id}", headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns the group details' do
        response_body = JSON.parse(response.body)
        expect(response_body['data']['id']).to eq(@group.id)
      end
    end

    context 'when the group does not exist' do
      let(:non_existent_group_id) { 9999 }

      before { get "/groups/#{non_existent_group_id}", headers: headers }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.show.invalid', item: 'Group'))
      end
    end
  end
end
