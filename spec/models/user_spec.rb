# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:groups).with_foreign_key('creator_id').class_name('Group').dependent(:destroy) }
    it { should have_many(:group_members).with_foreign_key('member_id').class_name('GroupMember').dependent(:destroy) }
    it { should have_many(:expenses).with_foreign_key('payer_id').dependent(:destroy) }
    it { should have_many(:expense_splits_as_payer).with_foreign_key('payer_id').class_name('ExpenseSplit').dependent(:destroy) }
    it { should have_many(:expense_splits_as_payee).with_foreign_key('payee_id').class_name('ExpenseSplit').dependent(:destroy) }
    it { should have_many(:settlements_as_payer).with_foreign_key('payer_id').class_name('Settlement').dependent(:destroy) }
    it { should have_many(:settlements_as_payee).with_foreign_key('payee_id').class_name('Settlement').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:first_name).is_at_least(3).is_at_most(10) }
    it { should validate_length_of(:last_name).is_at_least(3).is_at_most(10) }
  end

  describe '#admin?' do
    it 'should return true if user is admin' do
      role = 'admin'
      user = User.new(role: role)
      expect(user.admin?).to eq(true)
    end
  end
end
