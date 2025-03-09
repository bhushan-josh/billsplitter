require 'rails_helper'

RSpec.describe V1::ExpenseService::Show, type: :service do
  describe '#call' do
    let(:expense) { create(:expense) }
    let(:params) { ActionController::Parameters.new({ id: expense.id }) }
    subject { described_class.new(params).call }

    context 'when expense exists' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.show.details', item: 'Expense'))
        expect(subject[:data]).to eq(V1::ExpenseSerializer.new(expense).serializable_hash)
      end
    end

    context 'when expense does not exist' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.show.invalid', item: 'Expense'))
      end
    end
  end
end
