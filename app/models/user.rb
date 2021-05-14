# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  nick       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :nick, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true
end
