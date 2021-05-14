# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    sender { nil }
    receiver { nil }
    amount { Faker::Number.within(range: 1..1_000).to_f }
    description { Faker::Lorem.sentence }
    created_at { Faker::Date.backward }
  end
end
