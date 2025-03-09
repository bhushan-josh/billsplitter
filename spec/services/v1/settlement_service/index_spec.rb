require 'rails_helper'

RSpec.describe V1::SettlementService::Index, type: :service do
  let(:user) { create(:user) }
  let(:settlements) { create_list(:settlement, 3, payer: user) }
  let(:service) { described_class.new(user) }

  describe '#call' do
    context 'when settlements exist for the active user' do
      before do
        allow(Settlement).to receive(:where).with(payer_id: user.id).and_return(Settlement.where(id: settlements.map(&:id)))
        allow(Settlement).to receive(:where).with(payee_id: user.id).and_return(Settlement.none)
      end

      it 'returns a success response with settlements' do
        result = service.call
        expect(result[:success]).to be true
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Settlement'))
        expect(result[:data]).to match_array(settlements)
      end
    end

    context 'when no settlements exist for the active user' do
      before do
        allow(Settlement).to receive(:where).with(payer_id: user.id).and_return(Settlement.none)
        allow(Settlement).to receive(:where).with(payee_id: user.id).and_return(Settlement.none)
      end

      it 'returns a success response with an empty array' do
        result = service.call
        expect(result[:success]).to be true
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Settlement'))
        expect(result[:data]).to be_empty
      end
    end
  end
end
