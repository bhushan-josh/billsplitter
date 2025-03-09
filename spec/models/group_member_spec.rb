# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  describe 'associations' do
    it { should belong_to(:group) }
    it { should belong_to(:member).class_name('User') }
  end

  describe 'validations' do
    subject { create(:group_member) }

    it { should validate_uniqueness_of(:member_id).scoped_to(:group_id) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(member: 0, admin: 1) }
  end
end
