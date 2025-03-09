require 'rails_helper'

RSpec.describe V1::SettlementService::Show, type: :service do
  describe '#call' do
    let(:settlement) { create(:settlement) }
    let(:params) { ActionController::Parameters.new({ id: settlement.id }) }
    subject { described_class.new(params).call }

    context 'when settlement exists' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.show.details', item: 'Settlement'))
        expect(subject[:data]).to eq(V1::SettlementSerializer.new(settlement).serializable_hash)
      end
    end

    context 'when settlement does not exist' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.show.invalid', item: 'Settlement'))
      end
    end
  end
end
