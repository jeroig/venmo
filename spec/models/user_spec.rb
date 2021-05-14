# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:nick) }
  end

  describe 'email' do
    it 'has a invalid email' do
      subject.email = 'invalid_email'
      subject.validate
      expect(subject.errors[:email]).to include('is invalid')
    end
  end
end
