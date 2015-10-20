class Money
  attr_reader :currency

  def self.conversion_rates(currency, conversion_rates = nil)
    conversion_rates_data[currency] = conversion_rates
  end

  def self.conversion_rate(from:, to:)
    conversion_rates_data[from][to] || 0
  end

  def self.clear_conversion_rates!
    @conversion_rates = nil
  end

  def initialize(amount, currency)
    @amount_in_cents = amount * 100
    @currency = currency
  end

  def amount
    amount_in_cents / 100
  end

  private

  attr_reader :amount_in_cents

  def self.conversion_rates_data
    @conversion_rates ||= Hash.new({})
  end
end
