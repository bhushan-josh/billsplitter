# frozen_string_literal: true

module V1
  module AuthService
    class Login < V1::Base
      attr_reader :params, :user

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message) unless validate_user
        return failure_response(message) unless authenticate_user

        set_data
        success_response(message, data)
      end

      def validate_user
        @user = User.where(email: login_params['email']).first
        return true if user

        @message = I18n.t('auth.login.user_invalid')
        false
      end

      def authenticate_user
        return true if user.valid_password?(login_params['password'])

        @message = I18n.t('auth.login.failure')
        false
      end

      def set_data
        @data = V1::UserLoginSerializer.new(user).serializable_hash[:data]
        @message = I18n.t('auth.login.success')
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
