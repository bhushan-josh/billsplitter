# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'associations' do
    it { should belong_to(:group) }
    it { should belong_to(:payer).class_name('User') }
    it { should have_many(:expense_splits).dependent(:destroy) }
    it { should accept_nested_attributes_for(:expense_splits).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
