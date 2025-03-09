# frozen_string_literal: true

FactoryBot.define do
  factory :group_member do
    association :group
    association :member, factory: :user
    role { %i[member admin].sample }
  end
end
