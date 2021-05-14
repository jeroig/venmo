# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0).is_less_than(1_000) }
  end

  describe 'associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
