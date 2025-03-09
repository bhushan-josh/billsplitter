require 'rails_helper'

RSpec.describe V1::GroupService::Index do
  let(:user) { create(:user) }
  let!(:groups) { create_list(:group, 3) }
  let!(:group_memberships) { groups.each { |group| create(:group_member, group: group, member: user) } }

  describe '#call' do
    context 'when user is a member of groups' do
      it 'returns all groups the user is a member of' do
        service = V1::GroupService::Index.new(user)
        result = service.call

        expect(result[:data]).to match_array(groups)
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Group'))
        expect(result[:status]).to eq(:success)
      end
    end

    context 'when user is not a member of any groups' do
      let(:user_without_groups) { create(:user) }

      it 'returns an empty array' do
        service = V1::GroupService::Index.new(user_without_groups)
        result = service.call

        expect(result[:data]).to be_empty
        expect(result[:message]).to eq(I18n.t('message.index', item: 'Group'))
        expect(result[:status]).to eq(:success)
      end
    end
  end
end
