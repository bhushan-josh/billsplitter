require 'rails_helper'

RSpec.describe V1::ExpenseService::Index do
  let(:user) { create(:user) }
  let!(:expenses) { create_list(:expense, 3, user: user) }
  describe '#call' do
    context 'when user has expenses' do
      it 'returns all expenses' do
        service = V1::ExpenseService::Index.new(user)
        result = service.call

        expect(result[:data]).to match_array(expenses)
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Expense'))
        expect(result[:status]).to eq(:success)
      end
    end

    context 'when user has no expenses' do
      let(:user_without_expenses) { create(:user) }

      it 'returns an empty array' do
        service = V1::ExpenseService::Index.new(user_without_expenses)
        result = service.call

        expect(result[:data]).to be_empty
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Expense'))
        expect(result[:status]).to eq(:success)
      end
    end
  end
end
