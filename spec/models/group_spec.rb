# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name('User').optional }
    it { should have_many(:group_members).dependent(:destroy) }
    it { should have_many(:members).through(:group_members).source(:member) }
    it { should have_many(:expenses).dependent(:destroy) }
    it { should accept_nested_attributes_for(:group_members).allow_destroy(true) }
  end

  describe 'validations' do
    subject { create(:group) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe '#add_creator_as_member' do
    let(:user) { create(:user) }

    it 'adds the creator as a member after group creation' do
      group = create(:group, creator: user)
      expect(group.members).to include(user)
    end

    it 'does not create duplicate membership for the creator' do
      group = create(:group, creator: user)
      group.reload
      expect(group.group_members.where(member: user).count).to eq(1)
    end
  end
end
