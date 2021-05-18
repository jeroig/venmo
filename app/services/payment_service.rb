# frozen_string_literal: true

class PaymentService
  attr_reader :sender, :receiver, :amount, :description

  def initialize(sender, payload)
    @sender      = sender
    @receiver    = User.find(payload[:friend_id])
    @amount      = payload[:amount].to_f
    @description = payload[:description]
  end

  def call
    run_validations!

    ActiveRecord::Base.transaction do
      guarantee_money
      sender.debit(amount)
      receiver.credit(amount)
      create_record
    end
  end

  private

  def run_validations!
    raise VenmoError::PaymentServiceNotFriend unless sender.my_friend?(receiver)
    raise VenmoError::PaymentServiceDescriptionNotString unless description.is_a?(String) ||
                                                                description.nil?
  end

  def guarantee_money
    future_balance = sender.balance - amount
    get_loan(sender, future_balance.abs) if future_balance.negative?
  end

  def get_loan(user, amount_needed)
    MoneyTransferService.new(Object.new, user).transfer(amount_needed)
  end

  def create_record
    Payment.create!(
      sender: sender,
      receiver: receiver,
      amount: amount,
      description: description
    )
  end
end
