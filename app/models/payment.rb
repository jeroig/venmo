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
class Payment < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :amount, numericality: { greater_than: 0, less_than: 1_000 }
  validates :amount, presence: true

  scope :by_newest, -> { order(created_at: :desc) }

  def title
    "#{sender.nick} paid #{receiver.nick} on #{created_at} - #{description}"
  end

  def self.activity_feed(user)
    users_ids = user.my_friends.pluck(:id) + user.friends_of_my_friends.pluck(:id)
    users_ids << user.id
    includes(:sender, :receiver).where('sender_id in (?)', users_ids)
  end
end
