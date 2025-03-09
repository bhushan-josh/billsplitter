require 'rails_helper'

RSpec.describe V1::GroupService::Delete, type: :service do
  describe '#call' do
    let(:group) { create(:group) }
    let(:params) { ActionController::Parameters.new({ id: group.id }) }
    subject { described_class.new(params).call }

    context 'when group is successfully deleted' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('group.delete.success'))
      end
    end

    context 'when group is not found' do
      let(:params) { ActionController::Parameters.new({ id: -1 }) }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { described_class.new(params).call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when group deletion fails' do
      before do
        allow_any_instance_of(Group).to receive(:destroy).and_return(false)
        allow_any_instance_of(Group).to receive_message_chain(:errors, :full_messages).and_return(['Error message'])
      end

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.delete.failure', item: 'Group'))
        expect(subject[:errors]).to include('Error message')
      end
    end
  end
end
