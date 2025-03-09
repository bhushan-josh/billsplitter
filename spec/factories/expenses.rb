FactoryBot.define do
  factory :expense do
    association :payer, factory: :user
    association :group
    amount { Faker::Commerce.price(range: 0..1000.0) }
    description { Faker::Food.dish }

    transient do
      splits_count { 2 }
    end
  end
end
