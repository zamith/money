require "forwardable"
require "money_ruby/configuration"
require "money_ruby/converter"

class Money
  attr_reader :currency, :amount_in_cents
  include Configuration
  include Comparable

  extend Forwardable
  def_delegators :@converter, :convert_to, :convert_when_needed

  def initialize(amount, currency, unit: :basic, converter: Converter)
    @amount_in_cents = (unit == :cent ? amount : amount * 100).to_i
    @currency = currency
    @converter = converter.new(amount_in_cents, currency)
  end

  def amount
    amount_in_cents / 100.0
  end

  def inspect
    "%.2f %s" % [amount, currency]
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
end
