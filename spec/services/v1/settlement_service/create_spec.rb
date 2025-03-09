require 'rails_helper'

RSpec.describe V1::SettlementService::Create, type: :service do
  describe '#call' do
    let(:active_user) { create(:user) }
    let(:payee) { create(:user) }
    let(:params) do
      ActionController::Parameters.new({
                                         settlement: {
                                           payee_id: payee.id
                                         }
                                       })
    end
    subject { described_class.new(params, active_user).call }

    context 'when settlement is created successfully' do
      before do
        create(:expense_split, payer: active_user, payee: payee, amount: 100, status: :pending)
      end

      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.create.success', item: 'Settlement'))
        expect(Settlement.count).to eq(1)
        expect(Settlement.first.amount).to eq(100)
      end
    end

    context 'when there is no balance to settle' do
      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('settlement.create.other.no_balance', item: 'Settlement'))
      end
    end

    context 'when settlement creation fails' do
      before do
        allow_any_instance_of(Settlement).to receive(:save).and_return(false)
      end

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.create.failure', item: 'Settlement'))
        expect(subject[:errors]).to be_present
      end
    end
  end
end
