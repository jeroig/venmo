# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :amount, numericality: { greater_than: 0, less_than: 1_000 }
  validates :amount, presence: true

  def title
    "#{sender.nick} paid #{receiver.nick} on #{created_at} - #{description}"
  end
end
