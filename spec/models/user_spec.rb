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

  describe 'email' do
    it 'invalid' do
      subject.email = 'invalid_email'
      subject.validate
      expect(subject.errors[:email]).to include('is invalid')
    end

    it 'valid' do
      subject.validate
      expect(subject.errors[:email]).to_not include('is invalid')
    end
  end
end
