# frozen_string_literal: true

module V1
  class Base
    attr_reader :message, :data, :errors

    def initialize
      @data = []
      @message = ''
      @errors = []
    end

    def success_response(message = nil, data = [])
      { success: true, message:, data: data.presence }
    end

    def failure_response(message = nil, errors = [])
      { success: false, message:, errors: }
    end
  end
end
