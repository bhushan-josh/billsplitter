# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtService do
  let(:payload) { { user_id: 1 } }
  let(:token) { JwtService.encode(payload) }

  describe '.encode' do
    it 'returns a JWT token' do
      expect(token).to be_a(String)
    end

    it 'encodes the payload correctly' do
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: JwtService::JWT_ALGORITHM)
      expect(decoded_token.first['user_id']).to eq(payload[:user_id])
    end
  end

  describe '.decode' do
    it 'decodes the token correctly' do
      decoded_token = JwtService.decode(token)
      expect(decoded_token.first['user_id']).to eq(payload[:user_id])
    end

    it 'raises an error for an invalid token' do
      expect { JwtService.decode('invalid_token') }.to raise_error(JWT::DecodeError)
    end
  end
end
