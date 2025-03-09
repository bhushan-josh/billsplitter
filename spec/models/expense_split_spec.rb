# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpenseSplit, type: :model do
  describe 'associations' do
    it { should belong_to(:payer).class_name('User') }
    it { should belong_to(:payee).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:payer) }
    it { should validate_presence_of(:payee) }
    it { should validate_presence_of(:amount) }
  end

  describe 'enums' do
    it {
      should define_enum_for(:status).with_values(%i[pending
                                                     settled])
    }
  end
end
