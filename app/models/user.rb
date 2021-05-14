# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :nick, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
