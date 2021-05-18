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
#  balance    :float            default(0.0), not null
#
class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :reverse_friends, through: :reverse_friendships, source: :user

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :nick, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true

  def my_friends
    friends + reverse_friends
  end

  def friends_of_my_friends
    first_level_friends  = my_friends
    second_level_friends = first_level_friends.map(&:my_friends).flatten.uniq
    second_level_friends.delete_if do |friend|
      (friend == self) || first_level_friends.include?(friend)
    end
  end

  def my_friend?(user)
    my_friends.include? user
  end

  def debit(amount)
    self.balance -= amount
    save!
  end

  def credit(amount)
    self.balance += amount
    save!
  end

  alias add_to_balance credit
end
