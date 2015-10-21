require "money_ruby/errors"

module Configuration
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def conversion_rates(currency, conversion_rates = nil)
      conversion_rates_data[currency] = conversion_rates
    end

    def conversion_rate(from:, to:)
      conversion_rates_data[from][to] ||
        raise(NoConversionRateError, "No conversion rate known for '#{from}' -> '#{to}'")
    end

    def clear_conversion_rates!
      @conversion_rates = nil
    end

    private

    def conversion_rates_data
      @conversion_rates ||= Hash.new({})
    end
  end
end
