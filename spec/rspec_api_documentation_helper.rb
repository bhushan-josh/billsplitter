# frozen_string_literal: true

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.request_body_formatter = :json
  config.request_headers_to_include = ['Content-Type', 'Authorization'] # Headers to include
  config.response_headers_to_include = ['Content-Type']
  config.request_body_formatter = :json
  config.curl_headers_to_filter = %w[Host Cookie]
  config.curl_host = 'http://api.example.com'
end
