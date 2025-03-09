# frozen_string_literal: true

module CommonMethods
  def add_request_headers(user: nil)
    header 'Accept', 'application/vnd.billsplitter.com; version=1'
    header 'Content-Type', 'application/json'
    header 'Authorization', user ? JwtService.encode(id: user[:id]) : ''
  end

  def add_headers(request: nil, user: nil)
    request.headers['Accept'] = 'application/vnd.billsplitter.com; version=1'
    request.headers['Content-Type'] = 'application/json'
    request.headers['Authorization'] = user ? JwtService.encode(id: user[:id]) : ''
  end
end
