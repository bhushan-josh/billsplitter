# frozen_string_literal: true

module V1
  module UserService
    class Index < V1::Base
      def call
        users = User.all
        success_response(users)
      end
    end
  end
end
