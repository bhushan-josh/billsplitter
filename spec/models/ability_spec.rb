# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  describe 'user abilities' do
    subject(:ability) { Ability.new(user) }

    it 'cannot manage all' do
      expect(ability).not_to be_able_to(:manage, :all)
    end
  end

  describe 'admin abilities' do
    subject(:ability) { Ability.new(admin) }

    it 'can manage all' do
      expect(ability).to be_able_to(:manage, :all)
    end
  end
end
