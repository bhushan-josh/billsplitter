require 'rails_helper'

RSpec.describe 'Expense', type: :request do
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
    @expense = create(:expense)
  end

  describe 'GET /expenses' do
    context 'when fetching a list of expenses' do
      before { get '/expenses', headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /expenses/:id' do
    context 'when the expense exists' do
      before { get "/expenses/#{@expense.id}", headers: headers }

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expense details' do
        response_body = JSON.parse(response.body)
        expect(response_body['data']['id']).to eq(@expense.id)
      end
    end

    context 'when the expense does not exist' do
      let(:non_existent_expense_id) { 9999 }

      before { get "/expenses/#{non_existent_expense_id}", headers: headers }

      it 'returns a 404 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.show.invalid', item: 'Expense'))
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    let(:expense) { create(:expense) }

    context 'when the expense exists' do
      it 'deletes the expense' do
        expect do
          delete "/expenses/#{expense.id}", headers: headers
        end
      end

      it 'returns a successful response' do
        delete "/expenses/#{expense.id}", headers: headers
        expect(response).to have_http_status(200)
      end
    end

    context 'when the expense does not exist' do
      let(:non_existent_expense_id) { 9999 }

      it 'returns a not found status' do
        delete "/expenses/#{non_existent_expense_id}", headers: headers
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        delete "/expenses/#{non_existent_expense_id}", headers: headers
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq(I18n.t('message.destroy.invalid', item: 'Expense'))
      end
    end
  end
end
