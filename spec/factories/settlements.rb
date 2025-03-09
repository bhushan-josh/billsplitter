# frozen_string_literal: true

FactoryBot.define do
  factory :settlement do
    amount { Faker::Commerce.price(range: 0..1000.0) }
    association :payer, factory: :user
    association :payee, factory: :user
  end
end
