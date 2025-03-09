# frozen_string_literal: true

require 'rails_helper'

resource 'Auth' do
  before(:each) do
    add_request_headers
  end

  post '/login' do
    parameter :email, "User's email", required: true
    parameter :password, "User's password", required: true

    let(:user) { create(:user) }

    example 'User login' do
      request_param = {
        email: user.email,
        password: user.password
      }

      do_request(request_param)
      expect(status).to eq(200)
    end

    example 'User login with invalid credentials' do
      request_param = {
        email: user.email,
        password: 'invalid_password'
      }

      do_request(request_param)
      expect(status).to eq(422)
    end
  end

  post '/signup' do
    parameter :first_name, "User's first name", required: true
    parameter :last_name, "User's last name", required: true
    parameter :phone, "User's phone number", required: true
    parameter :email, "User's email", required: true
    parameter :password, "User's password", required: true

    example 'User signup' do
      request_param = {
        first_name: 'kuhsh',
        last_name: 'nagpure',
        phone: '9850060439',
        email: 'khushnn@gmail.com',
        password: 'qwertyuiop'
      }

      do_request(request_param)
      expect(status).to eq(200)
    end

    example 'User signup with invalid credentials' do
      request_param = {
        first_name: 'aman',
        last_name: 'pathan',
        phone: '9850060439',
        email: nil,
        password: 'qwertyuiop'
      }
      do_request(request_param)
      expect(status).to eq(422)
    end
  end
end
