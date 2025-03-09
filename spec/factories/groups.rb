FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    association :creator, factory: :user

    transient do
      members_count { 2 }
    end
  end
end
