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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:nick) }
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:friendships) }
    it { should have_many(:friends) }
    it { should have_many(:reverse_friendships) }
    it { should have_many(:reverse_friends) }
  end

  describe 'email' do
    it 'invalid' do
      subject.email = 'invalid_email'
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /Email is invalid/)
    end

    it 'valid' do
      expect(subject).to be_valid
    end
  end

  describe 'friends information' do
    let(:user_a)  { create(:user) }
    let(:user_b)  { create(:user) }
    let(:user_c)  { create(:user) }
    let(:user_d)  { create(:user) }
    let(:user_e)  { create(:user) }
    let!(:friendship_ab) { create(:friendship, user: user_a, friend: user_b) }
    let!(:friendship_ac) { create(:friendship, user: user_a, friend: user_c) }
    let!(:friendship_bc) { create(:friendship, user: user_b, friend: user_c) }
    let!(:friendship_cd) { create(:friendship, user: user_c, friend: user_d) }

    context 'list friends' do
      it 'my friends' do
        friends_of_a = user_a.my_friends
        expect(friends_of_a).to match_array([user_b, user_c])
        expect(friends_of_a).not_to include(user_a, user_d)
      end

      it 'of my friends' do
        friends_of_my_friends_a = user_a.friends_of_my_friends
        expect(friends_of_my_friends_a).to match_array([user_d])
        expect(friends_of_my_friends_a).not_to include(user_a, user_b, user_c)
      end
    end
  end
end
