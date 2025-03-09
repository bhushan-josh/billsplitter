# frozen_string_literal: true

require 'rspec'
require_relative '../../../app/services/v1/base'

RSpec.describe V1::Base do
  let(:base) { described_class.new }

  describe '#initialize' do
    it 'initializes with empty data, message, and errors' do
      expect(base.data).to eq([])
      expect(base.message).to eq('')
      expect(base.errors).to eq([])
    end
  end

  describe '#success_response' do
    it 'returns a success response with message and data' do
      response = base.success_response('Success', [1, 2, 3])
      expect(response).to eq({ success: true, message: 'Success', data: [1, 2, 3] })
    end

    it 'returns a success response with default values' do
      response = base.success_response
      expect(response).to eq({ success: true, message: nil, data: nil })
    end
  end

  describe '#failure_response' do
    it 'returns a failure response with message and errors' do
      response = base.failure_response('Error', ['error1', 'error2'])
      expect(response).to eq({ success: false, message: 'Error', errors: ['error1', 'error2'] })
    end

    it 'returns a failure response with default values' do
      response = base.failure_response
      expect(response).to eq({ success: false, message: nil, errors: [] })
    end
  end
end
