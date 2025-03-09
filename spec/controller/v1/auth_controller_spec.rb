# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe V1::AuthController, type: :request do
#   let(:user) { create(:user) }

#   describe 'POST /v1/login' do
#     context 'with valid credentials' do
#       it 'logs in successfully' do
#         post v1_login_url, params: { email: user.email, password: user.password }
#         expect(response).to have_http_status(:success)
#       end
#     end

#     context 'with invalid credentials' do
#       it 'does not log in' do
#         post v1_login_url, params: { email: user.email, password: 'invalid_password' }
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end

#   describe 'POST /v1/signup' do
#     context 'with valid details' do
#       it 'signs up successfully' do
#         post v1_signup_url, params: {
#           first_name: 'John',
#           last_name: 'Doe',
#           phone: '1234567890',
#           email: 'john.doe@example.com',
#           password: 'password123'
#         }
#         expect(response).to have_http_status(:success)
#       end
#     end

#     context 'with invalid details' do
#       it 'does not sign up' do
#         post v1_signup_url, params: {
#           first_name: 'John',
#           last_name: 'Doe',
#           phone: '1234567890',
#           email: nil,
#           password: 'password123'
#         }
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end
# end
