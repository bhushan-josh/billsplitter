require 'rails_helper'

RSpec.describe V1::GroupService::Update, type: :service do
  describe '#call' do
    let(:group) { create(:group) }
    let(:params) { ActionController::Parameters.new(id: group.id, name: 'New Group', creator_id: group.creator_id, description: 'New Description') }
    subject { described_class.new(params).call }

    context 'when update is successful' do
      before do
        allow(Group).to receive(:find).and_return(group)
        allow(group).to receive(:update).and_return(true)
      end

      it 'returns a success response' do
        expect(subject[:success]).to eq(true)
        expect(subject[:message]).to eq(I18n.t('message.update.success', item: 'Group'))
      end
    end

    context 'when update fails' do
      before do
        allow(Group).to receive(:find).and_return(group)
        allow(group).to receive(:update).and_return(false)
        allow(group).to receive(:errors).and_return(double(full_messages: ['Error']))
      end

      it 'returns a failure response' do
        expect(subject[:success]).to eq(false)
        expect(subject[:message]).to eq(I18n.t('message.update.failure', item: 'Group'))
        expect(subject[:errors]).to eq(group.errors.full_messages)
      end
    end
  end

  describe '#update_params' do
    let(:params) do
      ActionController::Parameters.new(id: 1, name: 'New Group', creator_id: 1, description: 'New Description',
                                       group_members_attributes: [{ id: 1, member_id: 2, role: 'admin', _destroy: false }])
    end
    let(:service) { described_class.new(params) }

    it 'permits the correct parameters' do
      expect(service.update_params).to eq(params.permit(:id, :name, :creator_id, :description, group_members_attributes: %i[id member_id role _destroy]))
    end
  end
end
