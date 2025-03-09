# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ExpenseService::Create, type: :service do
  let(:params) do
    ActionController::Parameters.new({
                                       payer_id: 1,
                                       group_id: 1,
                                       amount: 100.0,
                                       description: 'Test expense',
                                       expense_splits_attributes: [
                                         { payer_id: 1, payee_id: 2, amount: 50.0, status: 'pending' },
                                         { payer_id: 1, payee_id: 3, amount: 50.0, status: 'pending' }
                                       ]
                                     })
  end

  subject { described_class.new(params).call }
  describe '#call' do
    context 'when expense is successfully created' do
      it 'returns a success response' do
        allow_any_instance_of(Expense).to receive(:save).and_return(true)
        response = subject

        expect(response[:success]).to be(true)
        expect(response[:message]).to eq(I18n.t('message.create.success', item: 'Expense'))
        expect(response[:data]).to be_a(Expense)
        expect(response[:data].amount).to eq(100.0)
      end
    end

    context 'when expense creation fails' do
      let(:params) do
        ActionController::Parameters.new({
                                           payer_id: 1,
                                           group_id: 1,
                                           amount: nil,
                                           description: 'Test expense',
                                           expense_splits_attributes: [
                                             { payer_id: 1, payee_id: 2, amount: 50.0, status: 'pending' },
                                             { payer_id: 1, payee_id: 3, amount: 50.0, status: 'pending' }
                                           ]
                                         })
      end

      it 'returns a failure response' do
        allow_any_instance_of(Expense).to receive(:save).and_return(false)
        response = subject

        expect(response[:success]).to be(false)
        expect(response[:message]).to eq(I18n.t('message.create.failure', item: 'Expense'))
        expect(response[:errors]).to be_present
      end
    end
  end

  describe '#create_expense' do
    subject { described_class.new(params) }

    context 'when expense is valid' do
      it 'saves the expense and returns true' do
        expense = instance_double('Expense', save: true)
        allow(Expense).to receive(:new).and_return(expense)

        expect(subject.create_expense).to be true
        expect(subject.instance_variable_get(:@message)).to eq(I18n.t('message.create.success', item: 'Expense'))
      end
    end

    context 'when expense is invalid' do
      it 'does not save the expense and returns false' do
        expense = instance_double('Expense', save: false, errors: {})
        allow(Expense).to receive(:new).and_return(expense)

        expect(subject.create_expense).to be false
        expect(subject.instance_variable_get(:@message)).to eq(I18n.t('message.create.failure', item: 'Expense'))
      end
    end
  end
end
