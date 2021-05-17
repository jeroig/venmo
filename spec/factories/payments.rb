# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  sender_id   :bigint           not null
#  receiver_id :bigint           not null
#  amount      :float
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :payment do
    sender { nil }
    receiver { nil }
    amount { Faker::Number.within(range: 1..1_000).to_f }
    description { Faker::Lorem.sentence }
    created_at { Faker::Date.backward }
  end
end
