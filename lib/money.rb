require "money/version"

module Money
  def self.conversion_rates(currency, conversion_rates = nil)
    conversion_rates_data[currency] = conversion_rates
  end

  def self.conversion_rate(from:, to:)
    conversion_rates_data[from][to] || 0
  end

  def self.clear_conversion_rates!
    @conversion_rates = nil
  end

  private

  def self.conversion_rates_data
    @conversion_rates ||= Hash.new({})
  end
end
