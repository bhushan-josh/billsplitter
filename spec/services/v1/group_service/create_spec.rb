require 'rails_helper'

RSpec.describe V1::GroupService::Create, type: :service do
  describe '#call' do
    let(:creator) { create(:user) }
    let(:params) do
      ActionController::Parameters.new({
                                         name: 'Test Group',
                                         creator_id: creator.id,
                                         description: 'A test group',
                                         group_members_attributes: [{ member_id: creator.id, role: 'admin' }]
                                       })
    end
    subject { described_class.new(params).call }

    context 'when group is created successfully' do
      it 'returns a success response' do
        expect(subject[:success]).to be(true)
        expect(subject[:message]).to eq(I18n.t('message.create.success', item: 'Group'))
        expect(subject[:data]).to be_a(Group)
        expect(subject[:data].name).to eq('Test Group')
      end
    end

    context 'when group creation fails' do
      let(:params) do
        ActionController::Parameters.new({
                                           name: '',
                                           creator_id: creator.id,
                                           description: 'A test group',
                                           group_members_attributes: [{ member_id: creator.id, role: 'admin' }]
                                         })
      end

      it 'returns a failure response' do
        expect(subject[:success]).to be(false)
        expect(subject[:message]).to eq(I18n.t('message.create.failure', item: 'Group'))
        expect(subject[:errors]).to be_present
      end
    end
  end
end
