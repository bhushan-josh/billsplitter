# frozen_string_literal: true

FactoryBot.define do
  factory :expense_split do
    amount { Faker::Commerce.price(range: 0..1000.0) }
    association :payer, factory: :user
    association :payee, factory: :user
    status { %i[pending settled].sample }
  end
end
