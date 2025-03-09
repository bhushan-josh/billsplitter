# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settlement, type: :model do
  describe 'associations' do
    it { should belong_to(:payer).class_name('User') }
    it { should belong_to(:payee).class_name('User') }
  end

  describe 'validations' do
    subject { build(:settlement) }

    it { should validate_presence_of(:payer) }
    it { should validate_presence_of(:payee) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    it 'validates that payer and payee are different' do
      user = create(:user)
      settlement = build(:settlement, payer: user, payee: user)
      expect(settlement).not_to be_valid
      expect(settlement.errors[:payee]).to include("can't be the same as payer")
    end
  end
end
