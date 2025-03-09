require 'rails_helper'

RSpec.describe V1::SettlementService::Delete, type: :service do
  describe '#call' do
    let(:settlement) { create(:settlement) }
    let(:params) { ActionController::Parameters.new({ id: settlement.id }) }
    subject { described_class.new(params).call }

    context 'when settlement is successfully deleted' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.delete.success', item: 'Settlement'))
      end
    end

    context 'when settlement is not found' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { described_class.new(params).call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when settlement deletion fails' do
      before do
        allow_any_instance_of(Settlement).to receive(:destroy).and_return(false)
        allow_any_instance_of(Settlement).to receive_message_chain(:errors, :full_messages).and_return(['Error message'])
      end

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.delete.failure', item: 'Settlement'))
        expect(subject[:errors]).to include('Error message')
      end
    end
  end
end
