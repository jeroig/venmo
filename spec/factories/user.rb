# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    nick     { Faker::Name.first_name }
    balance  { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
