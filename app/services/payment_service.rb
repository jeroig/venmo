# frozen_string_literal: true

class PaymentService
  attr_reader :sender, :receiver, :amount, :description

  def initialize(sender, receiver, amount, description)
    @sender      = sender
    @receiver    = receiver
    @amount      = amount
    @description = description
  end

  def call
    raise 'You only can send money to a friend' unless sender.my_friend?(receiver)

    ActiveRecord::Base.transaction do
      guarantee_money
      sender.debit(amount)
      receiver.credit(amount)
      create_record
    end
  end

  private

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
