require 'rails_helper'

RSpec.describe V1::ExpenseService::Update, type: :service do
  describe '#call' do
    let(:expense) { create(:expense) }
    let(:params) { ActionController::Parameters.new(id: expense.id, payer_id: 1, expense_id: 1, amount: 100.0, description: 'Updated description') }
    subject { described_class.new(params).call }

    context 'when update is successful' do
      before do
        allow(Expense).to receive(:find).and_return(expense)
        allow(expense).to receive(:update).and_return(true)
      end

      it 'returns a success response' do
        expect(subject[:success]).to eq(true)
        expect(subject[:message]).to eq(I18n.t('message.update.success', item: 'Expense'))
      end
    end

    context 'when update fails' do
      before do
        allow(Expense).to receive(:find).and_return(expense)
        allow(expense).to receive(:update).and_return(false)
        allow(expense).to receive(:errors).and_return(double(full_messages: ['Error']))
      end

      it 'returns a failure response' do
        expect(subject[:success]).to eq(false)
        expect(subject[:message]).to eq(I18n.t('message.update.failure', item: 'Expense'))
        expect(subject[:errors]).to eq(expense.errors.full_messages)
      end
    end
  end

  describe '#update_params' do
    let(:params) do
      ActionController::Parameters.new(id: 1, payer_id: 1, expense_id: 1, amount: 100.0, description: 'Updated description',
                                       expense_splits_attributes: [{ payer_id: 1, payee_id: 2, amount: 50.0, status: 'pending' }])
    end
    let(:service) { described_class.new(params) }

    it 'permits the correct parameters' do
      expect(service.update_params).to eq(params.permit(:id, :payer_id, :expense_id, :amount, :description, expense_splits_attributes: %i[payer_id payee_id amount status]))
    end
  end
end
