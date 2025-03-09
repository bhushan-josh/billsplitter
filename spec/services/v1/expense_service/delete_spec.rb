require 'rails_helper'

RSpec.describe V1::ExpenseService::Delete, type: :service do
  describe '#call' do
    let(:expense) { create(:expense) }
    let(:params) { ActionController::Parameters.new({ id: expense.id }) }
    subject { described_class.new(params).call }

    context 'when expense is successfully deleted' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.delete.success', item: 'Expense'))
      end
    end

    context 'when expense is not found' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { described_class.new(params).call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when expense deletion fails' do
      before do
        allow_any_instance_of(Expense).to receive(:destroy).and_return(false)
        allow_any_instance_of(Expense).to receive_message_chain(:errors, :full_messages).and_return(['Error message'])
      end

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.delete.failure', item: 'Expense'))
        expect(subject[:errors]).to include('Error message')
      end
    end
  end
end
