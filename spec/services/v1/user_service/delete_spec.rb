# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UserService::Delete, type: :service do
  describe '#call' do
    let(:user) { create(:user) }
    let(:params) { ActionController::Parameters.new({ id: user.id }) }
    subject { described_class.new(params).call }

    context 'when user is successfully deleted' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.delete.success', item: 'User'))
      end
    end

    context 'when user is not found' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { described_class.new(params).call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
