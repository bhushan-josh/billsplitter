# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthService::Login, type: :service do
  let(:user) { create(:user, password: 'password') }

  # Wrap parameters in ActionController::Parameters to mimic controller behavior
  let(:valid_params) { ActionController::Parameters.new(email: user.email, password: 'password') }
  let(:invalid_params) { ActionController::Parameters.new(email: user.email, password: 'wrong_password') }
  let(:nonexistent_user_params) { ActionController::Parameters.new(email: Faker::Internet.email, password: 'password') }

  describe 'Login#call' do
    context 'when user is valid' do
      it 'returns a success response' do
        service = described_class.new(valid_params)
        response = service.call

        expect(response[:success]).to be(true)
        expect(response[:message]).to eq(I18n.t('auth.login.success'))
        expect(response[:data]).to be_present
      end
    end

    context 'when user does not exist' do
      it 'returns a failure response' do
        service = described_class.new(nonexistent_user_params)
        response = service.call

        expect(response[:success]).to be(false)
        expect(response[:message]).to eq(I18n.t('auth.login.user_invalid'))
      end
    end

    context 'when the password is incorrect' do
      it 'returns a failure response' do
        service = described_class.new(invalid_params)
        response = service.call

        expect(response[:success]).to be(false)
        expect(response[:message]).to eq(I18n.t('auth.login.failure'))
      end
    end
  end
end
