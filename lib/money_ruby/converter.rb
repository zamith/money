class Converter
  def initialize(amount_in_cents, currency)
    @amount_in_cents = amount_in_cents
    @currency = currency
  end

  def convert_to(new_currency)
    Money.new(amount_for_other_currency(new_currency), new_currency, unit: :cent)
  end

  def convert_when_needed(other)
    if currency == other.currency
      yield amount_in_cents, other.amount_in_cents
    else
      converted_other = other.convert_to(currency)
      yield amount_in_cents, converted_other.amount_in_cents
    end
  end

  private

  attr_reader :amount_in_cents, :currency

  def amount_for_other_currency(new_currency)
    amount_in_cents * Money.conversion_rate(from: currency, to: new_currency)
  end
end
