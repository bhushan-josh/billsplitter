require 'rails_helper'

RSpec.describe V1::UserService::Show, type: :service do
  describe '#call' do
    let(:user) { create(:user) }
    let(:params) { ActionController::Parameters.new({ id: user.id }) }
    subject { described_class.new(params).call }

    context 'when user exists' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.show.details', item: 'User'))
        expect(subject[:data]).to eq(V1::UserLoginSerializer.new(user).serializable_hash)
      end
    end

    context 'when user does not exist' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.show.invalid', item: 'User'))
      end
    end
  end
end
