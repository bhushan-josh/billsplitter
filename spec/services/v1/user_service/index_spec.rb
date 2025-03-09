require 'rails_helper'

RSpec.describe V1::UserService::Index, type: :service do
  describe '#call' do
    let!(:users) { create_list(:user, 3) }
    let(:service) { described_class.new }

    it 'returns a success response' do
      result = service.call
      expect(result[:success]).to eq(true)
    end

    it 'returns the correct message' do
      result = service.call
      expect(result[:message]).to eq(I18n.t('message.index', item: 'User'))
    end

    it 'returns all users' do
      result = service.call
      expect(result[:data]).to match_array(users)
    end
  end
end
