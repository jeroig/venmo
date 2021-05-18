# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/user/:id/payment' do
  describe 'Payment' do
    let!(:juan)   { create(:user, nick: 'juan', balance: 100) }
    let!(:jose)   { create(:user, nick: 'jose', balance: 200) }
    let(:amount)  { 100 }

    subject do
      post payment_api_v1_user_url(juan),
           params: { payload: { friend_id: jose.id, amount: amount, description: 'by test' } }
    end

    context 'when users are friend' do
      let!(:friendship_juan_jose) { create(:friendship, user: juan, friend: jose) }
      it 'returns http success' do
        subject
        expect(response).to be_successful
      end

      it 'create a payment' do
        expect { subject }.to change(Payment, :count).by(1)
      end

      it 'increase receiver balance' do
        old_balance = jose.balance
        subject
        expect(jose.reload.balance).to eq(old_balance + amount)
      end

      context 'when sender has money' do
        it 'debit sender balance' do
          old_balance = juan.balance
          subject
          expect(juan.reload.balance).to eq(old_balance - amount)
        end
      end

      context 'when sender has not money' do
        it 'debit sender balance must be empty' do
          juan.update!(balance: Faker::Number.within(range: 0..50))
          subject
          expect(juan.reload.balance).to eq(0)
        end

        it 'get money from bank' do
          juan.update!(balance: Faker::Number.within(range: 0..50))
          loan = amount - juan.balance
          expect_any_instance_of(MoneyTransferService).to receive(:transfer).with(loan)
          subject
        end
      end
    end

    context 'when users are not friends' do
      it 'returns internal server error' do
        subject
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns correct error json body' do
        subject
        expect(response.parsed_body.keys.map(&:to_sym)).to match_array([:error])
      end

      it 'does not create a payment' do
        subject
        expect { subject }.not_to change(Payment, :count)
      end
    end
  end
end
