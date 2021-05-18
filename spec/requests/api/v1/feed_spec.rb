# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/user/:id/feed' do
  describe 'Feed' do
    let!(:juan)   { create(:user, nick: 'juan') }
    let!(:jose)   { create(:user, nick: 'jose') }
    let!(:pablo)  { create(:user, nick: 'pablo') }
    let!(:ulises) { create(:user, nick: 'ulises') }

    let!(:friendship_juan_jose) { create(:friendship, user: juan, friend: jose) }
    let!(:friendship_jose_pablo) { create(:friendship, user: jose, friend: pablo) }
    let!(:friendship_pablo_ulises) { create(:friendship, user: pablo, friend: ulises) }

    subject { get feed_api_v1_user_url(juan) }

    context 'when list existing feed' do
      let!(:payments) do
        create(:payment, sender: juan, receiver: jose, amount: 100, created_at: Time.zone.now)
        create(:payment, sender: jose, receiver: pablo, amount: 150, created_at: 1.minute.ago)
        create(:payment, sender: pablo, receiver: ulises, amount: 200, created_at: 2.minute.ago)
        create(:payment, sender: ulises, receiver: jose, amount: 300, created_at: 3.minute.ago)
        create(:payment, sender: jose, receiver: juan, amount: 500, created_at: 4.minute.ago)
      end

      it 'returns http success' do
        subject
        expect(response).to be_successful
      end

      it 'returns my activities, all activities of friend and friend\'s friends' do
        subject
        users = response.parsed_body['data'].map do |item|
          item['title'] =~ /(.*)paid.*on\s(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\sUTC)/
          Regexp.last_match(1).strip
        end
        expect(users).to match_array(%w[jose jose juan pablo])
      end

      it 'returns correct order' do
        subject
        dates = response.parsed_body['data'].map do |item|
          item['title'] =~ /.*paid.*on\s(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\sUTC)/
          Time.parse(Regexp.last_match(1))
        end
        expect(dates).to eq(dates.sort.reverse)
      end
    end
  end
end
