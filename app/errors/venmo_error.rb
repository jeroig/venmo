# frozen_string_literal: true

class VenmoError < StandardError
  class PaymentServiceNotFriend < VenmoError
    def initialize(msg = 'You only can send money to a friend')
      super
    end
  end

  class PaymentServiceDescriptionNotString < VenmoError
    def initialize(msg = 'The field description must be a string')
      super
    end
  end
end
