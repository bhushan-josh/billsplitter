# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name[0, 10].ljust(3, 'a') }
    last_name { Faker::Name.last_name[0, 10].ljust(3, 'a') }
    phone { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { :user }

    trait :admin do
      role { :admin }
    end
  end
end
