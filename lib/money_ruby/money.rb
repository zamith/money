require "money_ruby/configuration"

class Money
  attr_reader :currency
  include Configuration

  def initialize(amount, currency)
    @amount_in_cents = amount * 100
    @currency = currency
  end

  def amount
    amount_in_cents / 100
  end

  def inspect
    "%.2f %s" % [amount, currency]
  end

  private

  attr_reader :amount_in_cents
end
