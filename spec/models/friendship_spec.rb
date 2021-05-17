# frozen_string_literal: true

# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  friend_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    let(:user)    { create(:user) }
    let(:friend)  { create(:user) }
    let(:friendship) { create(:friendship, user: user, friend: friend) }
    let(:reverse_friendships) { create(:friendship, user: friend, friend: user) }
    let(:myself_friendships)  { create(:friendship, user: user, friend: user) }

    context 'when create a frienship' do
      it 'valid friendship' do
        expect(friendship).to be_valid
      end

      it 'as myself' do
        expect { myself_friendships }.to raise_error(ActiveRecord::RecordInvalid, /I can't be friends with myself/)
      end

      it 'already exists' do
        friendship.save
        expect { reverse_friendships }.to raise_error(ActiveRecord::RecordInvalid, /the friendship already exists/)
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
