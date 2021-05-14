# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    nick  { Faker::Name.first_name }
  end
end
