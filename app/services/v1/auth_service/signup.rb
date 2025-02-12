# frozen_string_literal: true

module V1
  module AuthService
    class Signup < V1::Base
      attr_reader :params, :user

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: user.errors) unless create_user

        success_response(message)
      end

      def create_user
        @user = User.new(signup_params)
        unless @user.save
          @message = I18n.t('auth.signup.failure')
          return false
        end
        @message = I18n.t('auth.signup.success')
        true
      end

      def signup_params
        params.permit(:first_name, :last_name, :phone, :email, :password)
      end
    end
  end
end
