require "money_ruby/configuration"

class Money
  attr_reader :currency, :amount_in_cents
  include Configuration
  include Comparable

  def initialize(amount, currency, unit: :basic)
    @amount_in_cents = (unit == :cent ? amount : amount * 100).to_i
    @currency = currency
  end

  def amount
    amount_in_cents / 100.0
  end

  def inspect
    "%.2f %s" % [amount, currency]
  end

  def convert_to(new_currency)
    Money.new(amount_for_other_currency(new_currency), new_currency, unit: :cent)
  end

  def <=>(other)
    convert_when_needed(other) do |self_amount, other_amount|
      self_amount <=> other_amount
    end
  end

  def +(other)
    convert_when_needed(other) do |self_amount, other_amount|
      Money.new(self_amount + other_amount, currency, unit: :cent)
    end
  end

  def -(other)
    convert_when_needed(other) do |self_amount, other_amount|
      Money.new(self_amount - other_amount, currency, unit: :cent)
    end
  end

  def *(factor)
    Money.new(amount_in_cents * factor, currency, unit: :cent)
  end

  def /(dividend)
    Money.new(amount_in_cents / dividend, currency, unit: :cent)
  end

  def coerce(num)
    [self, num]
  end

  private

  def convert_when_needed(other)
    if currency == other.currency
      yield amount_in_cents, other.amount_in_cents
    else
      converted_other = other.convert_to(currency)
      yield amount_in_cents, converted_other.amount_in_cents
    end
  end

  def amount_for_other_currency(new_currency)
    amount_in_cents * Money.conversion_rate(from: currency, to: new_currency)
  end
end
