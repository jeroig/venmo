# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/user/:id/balance' do
  describe 'Balance' do
    let!(:user) { create(:user) }
    subject { get balance_api_v1_user_url(user) }
    before  { subject }

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'return correct json body' do
      expect(response.parsed_body.keys.map(&:to_sym)).to match_array([:balance])
    end

    it 'returns not_found' do
      get balance_api_v1_user_url(1)
      expect(response).to have_http_status(:not_found)
    end

    it 'returns correct error json body' do
      get balance_api_v1_user_url(1)
      expect(response.parsed_body.keys.map(&:to_sym)).to match_array([:error])
    end
  end
end
