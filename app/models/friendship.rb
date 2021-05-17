# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate  :not_has_friendship, :not_self_friendship
  validates :user, uniqueness: { scope: :friend, message: 'the friendship already exists' }

  private

  # This method check the reversity from a Friendly relationship
  # the friendship relationship is reciprocal
  # we don't need to store in db the relationship twice because is
  # bi-direccional
  def not_has_friendship
    return unless Friendship.where(user: friend, friend: user).exists?

    errors.add(:base, 'the friendship already exists')
    throw(:abort)
  end

  # We can't be friends with ourselves
  def not_self_friendship
    return unless friend == user

    errors.add(:base, 'I can\'t be friends with myself')
    throw(:abort)
  end
end
