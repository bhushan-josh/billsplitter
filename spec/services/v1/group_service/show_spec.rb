require 'rails_helper'

RSpec.describe V1::GroupService::Show, type: :service do
  describe '#call' do
    let(:group) { create(:group) }
    let(:params) { ActionController::Parameters.new({ id: group.id }) }
    subject { described_class.new(params).call }

    context 'when group exists' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.show.details', item: 'Group'))
        expect(subject[:data]).to eq(V1::GroupSerializer.new(group).serializable_hash)
      end
    end

    context 'when group does not exist' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.show.invalid', item: 'Group'))
      end
    end
  end
end
