require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:nick) }
  end

  # describe 'email' do
  #   it { is_expected_to_not allow_value('blah').for(:email) }
  #   it { is_expected_to allow_value('a@b.com').for(:email) }
  # end
end
