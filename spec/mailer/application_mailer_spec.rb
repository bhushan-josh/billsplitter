require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'default settings' do
    it 'sets the default from email' do
      mail = ApplicationMailer.default[:from]
      expect(mail).to eq('from@example.com')
    end

    it 'uses the mailer layout' do
      mailer = ApplicationMailer.new
    end
  end
end
