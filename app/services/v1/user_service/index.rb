# frozen_string_literal: true

module V1
  module UserService
    class Index < V1::Base
      def call
        users = User.all
        message = I18n.t('message.index', item: 'User')
        success_response(message, users)
      end
    end
  end
end
