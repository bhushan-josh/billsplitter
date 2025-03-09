require 'rails_helper'

RSpec.describe V1::UserService::Update, type: :service do
  describe '#call' do
    let(:user) { create(:user) }
    let(:params) { ActionController::Parameters.new(id: user.id, first_name: 'New', last_name: 'Name', email: 'new@example.com') }
    subject { described_class.new(params).call }

    context 'when update is successful' do
      before do
        allow(User).to receive(:find).and_return(user)
        allow(user).to receive(:update).and_return(true)
      end

      it 'returns a success response' do
        expect(subject[:success]).to eq(true)
        expect(subject[:message]).to eq(I18n.t('message.update.success', item: 'User'))
      end
    end

    context 'when update fails' do
      before do
        allow(User).to receive(:find).and_return(user)
        allow(user).to receive(:update).and_return(false)
        allow(user).to receive(:errors).and_return(double(full_messages: ['Error']))
      end

      it 'returns a failure response' do
        expect(subject[:success]).to eq(false)
        expect(subject[:message]).to eq(I18n.t('message.update.failure', item: 'User'))
        expect(subject[:errors]).to eq(user.errors.full_messages)
      end
    end
  end

  describe '#update_params' do
    let(:params) { ActionController::Parameters.new(id: 1, first_name: 'New', last_name: 'Name', email: 'new@example.com', password: 'password') }
    let(:service) { described_class.new(params) }

    it 'permits the correct parameters' do
      expect(service.update_params).to eq(params.permit(:id, :first_name, :last_name, :phone, :email, :password))
    end
  end
end
